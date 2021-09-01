import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import '../icons/eva_icons_icons.dart';
import '../models/ticket.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sweetalert/sweetalert.dart';
import '../models/step.dart' as proStep;
import 'dart:async';

import '../providers/tickets_provider.dart';
import './workorders_procedures.dart';
import 'close_ticket.dart';
import '../utils/constant.dart';
import '../models/ticket_response.dart';
import '../providers/ticket_suivi_controller.dart';
import '../styles/styles.dart';
import '../models/observer.dart';
import '../database/moor_database.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TicketDetailsScreen extends StatefulWidget {
  static const routeName = '/ticket-details';

  @override
  _TicketDetailsScreenState createState() => _TicketDetailsScreenState();
}

class _TicketDetailsScreenState extends State<TicketDetailsScreen> {
  var qrResult;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  Future<void> assignToObserver(
      int ticketId, TicketType type, int userId) async {
    Navigator.pop(context);
    dialog(context, _keyLoader);
    final bool isConnected = await InternetConnectionChecker().hasConnection;
    if (isConnected) {
      try {
        await Provider.of<Tickets>(context, listen: false).assignToObserver(
            ticketId: ticketId, context: context, userId: userId);
        Provider.of<Tickets>(context, listen: false).removeTickets(ticketId);
        if (type == TicketType.incident) {
          Navigator.popUntil(context, ModalRoute.withName('/Incidents'));
        } else {
          Navigator.popUntil(context, ModalRoute.withName('/workOrders'));
        }
        SweetAlert.show(context,
            title: AppLocalizations.of(context).succes,
            subtitle: AppLocalizations.of(context).tikcetReattribue,
            style: SweetAlertStyle.success);
      } catch (e) {
        SweetAlert.show(context,
            title: AppLocalizations.of(context).desole,
            subtitle: AppLocalizations.of(context).erreurProduite,
            style: SweetAlertStyle.error);
      }
    } else {
      Navigator.pop(context);
      SweetAlert.show(context,
          title: AppLocalizations.of(context).erreur,
          subtitle: AppLocalizations.of(context).pasDeConnexion,
          style: SweetAlertStyle.error);
    }
  }

  Future<void> startWorkoder(Ticket ticket, int id, BuildContext context,
      int categorieID, String demandeur, int itemId, int demandeurId) async {
    dialog(context, _keyLoader);

    final List<proStep.Step> step =
        Provider.of<Tickets>(context, listen: false).findStepById(ticket);

    final bool isConnected = await InternetConnectionChecker().hasConnection;
    if (isConnected) {
      try {
        final _locationData = await Geolocator.getCurrentPosition();
        UserPosition position = UserPosition(
            longitude: _locationData.longitude,
            latitude: _locationData.latitude,
            description: AppLocalizations.of(context).debutIntervention,
            datePrise: DateTime.now());
        Provider.of<TicketSuivi>(context, listen: false).addPosition(position);

        final Comment commentaire = Comment(
          text: AppLocalizations.of(context).debuteIntervention,
          datePrise: position.datePrise,
        );

        Provider.of<TicketSuivi>(context, listen: false).suiviTechnicien =
            commentaire;

        await Provider.of<TicketSuivi>(context, listen: false)
            .startIncident(ticket, context);

        if (step.length == 0) {
          Navigator.popAndPushNamed(
            context,
            CloseTicket.routeName,
            arguments: {
              'ticket': ticket,
              'itemId': itemId,
              'back': false,
              'demandeurId': demandeurId
            },
          );
        } else {
          Navigator.popAndPushNamed(
            context,
            Procedure.routeName,
            arguments: {'ticket': ticket, 'step_index': 0},
          );
        }
      } catch (e) {
        SweetAlert.show(context,
            title: AppLocalizations.of(context).desole,
            subtitle: AppLocalizations.of(context).erreurProduite,
            style: SweetAlertStyle.error);
      }
    } else {
      Navigator.pop(context);
      SweetAlert.show(context,
          title: AppLocalizations.of(context).erreur,
          subtitle: AppLocalizations.of(context).pasDeConnexion,
          style: SweetAlertStyle.error);
    }
  }

  Future<void> qrCode(Ticket ticket, int id, BuildContext context,
      int categorieID, String demandeur, int itemId, int demandeurId) async {
    dialog(context, _keyLoader);
    final snackBar = SnackBar(
      content: Text(AppLocalizations.of(context).qrCodeError),
    );

    final List<proStep.Step> step =
        Provider.of<Tickets>(context, listen: false).findStepById(ticket);

    final bool isConnected = await InternetConnectionChecker().hasConnection;
    if (isConnected) {
      try {
        final qrResult = await BarcodeScanner.scan();
        final qrCode = demandeur;
        if (qrResult == qrCode) {
          final _locationData = await Geolocator.getCurrentPosition();
          UserPosition position = UserPosition(
              longitude: _locationData.longitude,
              latitude: _locationData.latitude,
              description: AppLocalizations.of(context).debutIntervention,
              datePrise: DateTime.now());
          Provider.of<TicketSuivi>(context, listen: false)
              .addPosition(position);

          final Comment commentaire = Comment(
            text: AppLocalizations.of(context).debuteIntervention,
            datePrise: position.datePrise,
          );

          Provider.of<TicketSuivi>(context, listen: false).suiviTechnicien =
              commentaire;

          await Provider.of<TicketSuivi>(context, listen: false)
              .startIncident(ticket, context);

          if (step.length == 0) {
            Navigator.popAndPushNamed(
              context,
              CloseTicket.routeName,
              arguments: {
                'ticket': ticket,
                'back': false,
              },
            );
          } else {
            Navigator.popAndPushNamed(
              context,
              Procedure.routeName,
              arguments: {'id': id, 'step_index': 0},
            );
          }
        } else {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return;
        }
      } catch (e) {
        Navigator.pop(context);
      }
    } else {
      Navigator.pop(context);
      SweetAlert.show(context,
          title: AppLocalizations.of(context).erreur,
          subtitle: AppLocalizations.of(context).pasDeConnexion,
          style: SweetAlertStyle.error);
    }
  }

  Future<void> startIntervetion(int ticketId, Ticket ticket) async {
    dialog(context, _keyLoader);
    final bool isConnected = await InternetConnectionChecker().hasConnection;
    final dao = Provider.of<LocalTicketDao>(context, listen: false);
    if (isConnected) {
      try {
        final _locationData = await Geolocator.getCurrentPosition();
        //Locale myLocale = Localizations.localeOf(context);
        //print('pp: $myLocale');
        UserPosition position = UserPosition(
            longitude: _locationData.longitude,
            latitude: _locationData.latitude,
            description: AppLocalizations.of(context).debutIntervention,
            datePrise: DateTime.now());
        Provider.of<TicketSuivi>(context, listen: false).addPosition(position);
        final Comment commentaire = Comment(
          text: AppLocalizations.of(context).debuteIntervention,
          datePrise: position.datePrise,
        );
        print(commentaire.text);
        Provider.of<TicketSuivi>(context, listen: false).suiviTechnicien =
            commentaire;
        await Provider.of<TicketSuivi>(context, listen: false)
            .startIncident(ticket, context);
        dao.updateTicketStatus(ticketId, 7);
        setState(() {
          ticket.toggleStatut();
          //ticket.toggleIsNew();
        });
        Navigator.pop(context);
        SweetAlert.show(context,
            title: AppLocalizations.of(context).succes,
            subtitle: AppLocalizations.of(context).interventionDebute,
            style: SweetAlertStyle.success);
      } catch (e) {
        Navigator.pop(context);
      }
    } else {
      Navigator.pop(context);
      SweetAlert.show(context,
          title: AppLocalizations.of(context).erreur,
          subtitle: AppLocalizations.of(context).pasDeConnexion,
          style: SweetAlertStyle.error);
    }
  }

  void ficheIntervention(Ticket ticket) {
    Navigator.pushNamed(
      context,
      CloseTicket.routeName,
      arguments: {
        'ticket': ticket,
        'back': true,
      },
    );
  }

  @override
  Widget build(BuildContext widgetContext) {
    final Ticket ticket = ModalRoute.of(context).settings.arguments as Ticket;

    Widget setupAlertDialoadContainer(BuildContext context) {
      List<dynamic> ticketObservers = [];
      ticketObservers = ticket.observateur;
      return Container(
        width: 300,
        height: 220,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: ticketObservers.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(ticketObservers[index]["name"]),
              leading: Icon(
                EvaIcons.eye_outline,
                color: Theme.of(context).accentColor,
              ),
              contentPadding: EdgeInsets.all(0),
              onTap: () {
                assignToObserver(
                    ticket.id, ticket.type, ticketObservers[index].id);
              },
            );
          },
        ),
      );
    }

    final mediaQuery = MediaQuery.of(context);

    final appBar = AppBar(
      centerTitle: true,
      title: Text(
        'Ticket : ${ticket.id}',
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(25),
        ),
      ),
    );

    final screenHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    return Scaffold(
      appBar: appBar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(
              top: screenHeight * 0.03,
              left: 15,
              right: 15,
              bottom: screenHeight * 0.03,
            ),
            height: screenHeight * 0.9,
            child: Container(
              padding: EdgeInsets.only(
                left: 20,
                top: 25,
                right: 20,
                bottom: 10,
              ),
              decoration: BoxDecoration(
                color: Color.fromRGBO(242, 242, 242, 1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Stack(children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ticket.titre.capitalize(),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        ticket.description,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(112, 112, 112, 1),
                        ),
                      ),
                    ],
                  ),
                ),
                ticket.statut == 7
                    ? Positioned(
                        bottom: 10,
                        child: Text(
                          AppLocalizations.of(context).ticketPrisEnCompte,
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : SizedBox(),
              ]),
            ),
          ),
          ticket.isTech
              ? Container(
                  height: screenHeight * 0.1,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(242, 242, 242, 1),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: ElevatedButton(
                              onPressed: () {
                                ticket.observateur.isNotEmpty
                                    ? showDialog(
                                        context: context,
                                        builder: (BuildContext dialogcontext) {
                                          return AlertDialog(
                                            title: Text(
                                              AppLocalizations.of(context)
                                                  .observer,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            content: setupAlertDialoadContainer(
                                                context),
                                          );
                                        })
                                    : SweetAlert.show(
                                        context,
                                        title: "Oups!",
                                        subtitle: AppLocalizations.of(context)
                                            .pasObservateur,
                                      );
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: Color.fromRGBO(0, 113, 185, 0.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              child: Icon(EvaIcons.corner_up_left_outline),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Consumer<Ticket>(
                                builder: (context, auth, child) {
                              return ElevatedButton(
                                onPressed: ticket.statut == 7 &&
                                        ticket.type == TicketType.incident
                                    ? null
                                    : () {
                                        if (ticket.type ==
                                            TicketType.incident) {
                                          startIntervetion(ticket.id, ticket);
                                        } else {
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (context) => AlertDialog(
                                              actionsPadding:
                                                  EdgeInsets.fromLTRB(
                                                      8.0, 0, 8.0, 0),
                                              title: new Text(
                                                AppLocalizations.of(context)
                                                    .attention,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              content: new Text(
                                                AppLocalizations.of(context)
                                                    .notGoBack,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                              actions: <Widget>[
                                                new TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: new Text(
                                                    AppLocalizations.of(context)
                                                        .btnNo,
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontFamily: 'QuickSand',
                                                    ),
                                                  ),
                                                ),
                                                new TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    startWorkoder(
                                                      ticket,
                                                      ticket.id,
                                                      widgetContext,
                                                      ticket.categorieId,
                                                      ticket.demandeur,
                                                      ticket.itemId,
                                                      ticket.demandeurId,
                                                    );
                                                  },
                                                  child: new Text(
                                                    AppLocalizations.of(context)
                                                        .btnOui,
                                                    style: TextStyle(
                                                      color: Colors.green,
                                                      fontFamily: 'QuickSand',
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  primary: Color.fromRGBO(0, 113, 185, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                child: Icon(EvaIcons.play_circle_outline),
                              );
                            }),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.only(
                              left: 5,
                              top: 5,
                              right: 0,
                              bottom: 5,
                            ),
                            child: ElevatedButton(
                              onPressed: ticket.statut == 7 ||
                                      ticket.type == TicketType.workorders
                                  ? () {
                                      if (ticket.type == TicketType.incident) {
                                        ficheIntervention(
                                          ticket,
                                        );
                                      } else {
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) =>
                                              confirmAlertDialog(
                                            no: () {
                                              Navigator.of(context).pop();
                                            },
                                            yes: () {
                                              Navigator.of(context).pop();
                                              qrCode(
                                                ticket,
                                                ticket.id,
                                                widgetContext,
                                                ticket.categorieId,
                                                ticket.demandeur,
                                                ticket.itemId,
                                                ticket.demandeurId,
                                              );
                                            },
                                            title: AppLocalizations.of(context)
                                                .attention,
                                            subtitle:
                                                AppLocalizations.of(context)
                                                    .notGoBack,
                                            context: context,
                                          ),
                                        );
                                      }
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: ticket.type == TicketType.incident
                                    ? Color.fromRGBO(4, 164, 5, 0.5)
                                    : Color.fromRGBO(0, 113, 185, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              child: ticket.type == TicketType.incident
                                  ? Icon(EvaIcons.checkmark_circle)
                                  : Icon(Icons.qr_code_outlined),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : SizedBox(
                  height: 0,
                ),
        ],
      ),
    );
  }
}
