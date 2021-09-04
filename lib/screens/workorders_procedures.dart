import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:glpi4/database/moor_database.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../providers/ticket_suivi_controller.dart';
import './checklist.dart';
import '../widgets/appbar.dart';
import '../utils/constant.dart';
import '../providers/tickets_provider.dart';
import '../models/ticket_response.dart';
import '../models/step.dart' as proStep;
import '../models/ticket.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Procedure extends StatefulWidget {
  static const routeName = '/procedure';
  @override
  _ProcedureState createState() => _ProcedureState();
}

class _ProcedureState extends State<Procedure> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final ticket = arguments['ticket'];
    final int stepIndex = arguments['step_index'];

    final List<proStep.Step> step =
        Provider.of<Tickets>(context, listen: false).findStepById(ticket);
    // final serialNumber = Provider.of<LocalTicketDao>(context, listen: false)
    //     .findById(ticket)
    //     .itemNumber;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: buildAppbar(
            '${AppLocalizations.of(context).etape} ${stepIndex + 1}',
            context,
            false),
        body: QrCode(
            ticket: ticket,
            stepIndex: stepIndex,
            steps: step,
            stepId: step[stepIndex].id,
            serialNumber: ticket.itemNumber,
            keyLoader: _keyLoader),
      ),
    );
  }
}

class QrCode extends StatefulWidget {
  final Ticket ticket;
  final int stepIndex;
  final List<proStep.Step> steps;
  final int stepId;
  final String serialNumber;
  final GlobalKey<State> keyLoader;
  QrCode(
      {Key key,
      @required this.ticket,
      @required this.stepIndex,
      @required this.steps,
      @required this.stepId,
      @required this.serialNumber,
      @required this.keyLoader})
      : super(key: key);
  @override
  _QrCodeState createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  Future<void> validate(Ticket ticket, int stepId) async {
    final qrCode = Provider.of<Tickets>(context, listen: false)
        .findStepQrCode(ticket: ticket, stepId: stepId);
    final qrResult = await BarcodeScanner.scan();
    print('$qrResult');
    print('$qrCode');
    if (qrResult == qrCode) {
      dialog(context, widget.keyLoader);
      final _locationData = await Geolocator.getCurrentPosition();

      UserPosition position = UserPosition(
        longitude: _locationData.longitude,
        latitude: _locationData.latitude,
        description: '${widget.steps[widget.stepIndex].name}',
        datePrise: DateTime.now(),
      );
      Provider.of<TicketSuivi>(context, listen: false).addPosition(position);

      final Comment commentaire = Comment(
        text: qrResult,
        datePrise: position.datePrise,
      );

      Provider.of<TicketSuivi>(context, listen: false).suiviTechnicien =
          commentaire;

      final bool isConnected = await InternetConnectionChecker().hasConnection;

      if (isConnected) {
        await Provider.of<TicketSuivi>(context, listen: false)
            .savePosition(ticket, context);
      } else {
        Navigator.pop(context);
        // print('no data');
      }

      Navigator.popAndPushNamed(context, Checklist.routeName, arguments: {
        'step': widget.stepIndex,
        'ticketId': widget.ticket,
        'ticket': widget.ticket,
        'stepId': widget.stepId,
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).qrCodeError),
        ),
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 45),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${widget.steps[widget.stepIndex].name}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () => validate(widget.ticket, widget.stepId),
                      child: Image.asset(
                        'assets/images/qr_code.png',
                        width: 110,
                        height: 110,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
