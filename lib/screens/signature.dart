import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import '../icons/eva_icons_icons.dart';
import 'package:provider/provider.dart';
import '../providers/ticket_suivi_controller.dart';

class TicketSignature extends StatefulWidget {
  static const routeName = '/signature';
  @override
  _TicketSignatureState createState() => _TicketSignatureState();
}

class _TicketSignatureState extends State<TicketSignature> {
  final SignatureController _controllerTechnicien = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    /* final categorieId = arguments['categorie_id']; */
    final ticketID = arguments['id'];
    final personn = arguments['personn'];
    final imagesData = Provider.of<TicketSuivi>(context);
    final sign = imagesData.signature(personn);

    final appBar = AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      centerTitle: true,
      elevation: 0,
      actions: [
        IconButton(
            padding: EdgeInsets.all(0),
            alignment: Alignment.centerLeft,
            icon: Icon(
              EvaIcons.trash_2_outline,
              color: Colors.white,
            ),
            onPressed: () {
              if (sign == null) {
                setState(() {
                  _controllerTechnicien.clear();
                });
              } else {
                imagesData.removeImage(sign.name);
              }
            }),
        IconButton(
          padding: EdgeInsets.all(0),
          alignment: Alignment.centerLeft,
          icon: Icon(
            EvaIcons.save_outline,
            color: Colors.white,
          ),
          onPressed: () async {
            if (sign == null) {
              if (_controllerTechnicien.isNotEmpty) {
                var data = await _controllerTechnicien.toPngBytes();
                imagesData.takeSignature(data, ticketID, personn);
                Navigator.pop(context);
              }
            } else {
              return null;
            }
          },
        )
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(25),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return sign == null
            ? Signature(
                controller: _controllerTechnicien,
                height: constraints.maxHeight * 0.86,
                width: constraints.maxWidth * 0.86,
                backgroundColor: Colors.white,
              )
            : Center(
                child: Image.memory(sign.signature),
              );
      }),
    );
  }
}
