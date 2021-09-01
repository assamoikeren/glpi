import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sweetalert/sweetalert.dart';
import './signature.dart';
import '../icons/eva_icons_icons.dart';
import '../icons/fontelico_icons.dart';
import '../widgets/appbar.dart';
import './photos.dart';
import '../models/ticket_response.dart';
import '../providers/ticket_suivi_controller.dart';
import '../utils/constant.dart';
import '../styles/styles.dart';
import '../providers/tickets_provider.dart';
import '../models/ticket.dart';
import '../database/moor_database.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CloseTicket extends StatefulWidget {
  static const routeName = '/close-ticket';

  @override
  _CloseTicketState createState() => _CloseTicketState();
}

class _CloseTicketState extends State<CloseTicket> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  Future<void> resolveTicket(Ticket ticket, bool back) async {
    Navigator.pop(context);
    dialog(context, _keyLoader);
    final bool isConnected = await InternetConnectionChecker().hasConnection;
    if (isConnected) {
      try {
        final _locationData = await Geolocator.getCurrentPosition();
        UserPosition position = UserPosition(
            longitude: _locationData.longitude,
            latitude: _locationData.latitude,
            description: AppLocalizations.of(context).finIntervention,
            datePrise: DateTime.now());
        Provider.of<TicketSuivi>(context, listen: false).addPosition(position);
        String response =
            await Provider.of<TicketSuivi>(context, listen: false).closeTicket(
          ticket: ticket,
          context: context,
          itemId: ticket.itemId,
        );
        if (response == "Done") {
          if (back) {
            Navigator.popUntil(context, ModalRoute.withName('/Incidents'));
          } else {
            Navigator.popUntil(context, ModalRoute.withName('/workOrders'));
          }
          SweetAlert.show(context,
              title: AppLocalizations.of(context).succes,
              subtitle: AppLocalizations.of(context).ticketResolu,
              style: SweetAlertStyle.success);
        } else if (response == "ticket résolu") {
          if (back) {
            Navigator.popUntil(context, ModalRoute.withName('/Incidents'));
          } else {
            Navigator.popUntil(context, ModalRoute.withName('/workOrders'));
          }
          final dao = Provider.of<LocalTicketDao>(context, listen: false);
          dao.deleteTicket(ticket.id);
          /* var ticket =
              Provider.of<Tickets>(context, listen: false).findById(id);
          if (ticket != null) {
            Provider.of<Tickets>(context, listen: false).removeTickets(id);
          } */
          SweetAlert.show(context,
              title: AppLocalizations.of(context).desole,
              subtitle: AppLocalizations.of(context).ticketDejaResolu,
              style: SweetAlertStyle.error);
        } else if (response == "Server error") {
          if (back) {
            Navigator.popUntil(context, ModalRoute.withName('/Incidents'));
          } else {
            Navigator.popUntil(context, ModalRoute.withName('/workOrders'));
          }
          SweetAlert.show(context,
              title: AppLocalizations.of(context).desole,
              subtitle: AppLocalizations.of(context).erreurProduiteServeur,
              style: SweetAlertStyle.error);
        } else {
          Navigator.popUntil(context, ModalRoute.withName('/close-ticket'));
          SweetAlert.show(context,
              title: AppLocalizations.of(context).desole,
              subtitle: AppLocalizations.of(context).essayeEncore,
              style: SweetAlertStyle.error);
        }
      } catch (e) {
        Navigator.popUntil(context, ModalRoute.withName('/close-ticket'));
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

  final _formKeyTech = GlobalKey<FormState>();
  final _formKeyClient = GlobalKey<FormState>();
  final scrollController = ScrollController();
  final suiviTechnicien = TextEditingController();
  final commentClient = TextEditingController();
  ScrollPhysics pageScroll = NeverScrollableScrollPhysics();
  final suiviTechController = TextEditingController();
  int pageViewIndex = 0;
  final pageViewController = PageController(initialPage: 0, keepPage: true);

  bool iconChecked = false;
  bool btnYes = false;
  bool btnNo = false;
  int fav = 0;
  bool star_1 = false;
  bool star_2 = false;
  bool star_3 = false;
  bool star_4 = false;

  void starSatisfactionClient(int selected) {
    if (selected == 1) {
      setState(() {
        star_1 = !star_1;
        star_2 = false;
        star_3 = false;
      });
    } else if (selected == 2) {
      setState(() {
        star_1 = false;
        star_2 = !star_2;
        star_3 = false;
      });
    } else if (selected == 3) {
      setState(() {
        star_1 = false;
        star_2 = false;
        star_3 = !star_3;
      });
    }
  }

  void itemStateBtnStyle(int state) {
    if (state == 0) {
      setState(() {
        btnNo = !btnNo;
        btnYes = false;
      });
    } else if (state == 1) {
      setState(() {
        btnNo = false;
        btnYes = !btnYes;
      });
    } else {
      btnNo = false;
      btnYes = false;
    }
  }

  bool _formValidate = false;
  bool _photoValidate = false;

  @override
  void initState() {
    Comment ticketSuivi;
    Comment clientSuivi;
    Future.delayed(Duration.zero).then((_) {
      ticketSuivi =
          Provider.of<TicketSuivi>(context, listen: false).suiviTechnicien;
      clientSuivi =
          Provider.of<TicketSuivi>(context, listen: false).commentClient;
    });

    if (ticketSuivi != null) {
      suiviTechnicien.value = TextEditingValue(text: ticketSuivi.text);
    }
    if (clientSuivi != null) {
      commentClient.value = TextEditingValue(text: clientSuivi.text);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ticketSuivi = Provider.of<TicketSuivi>(context);

    final arguments =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final Ticket ticket = arguments['ticket'];
    //final demandeurId = arguments['demandeurId'];
    //final itemId = arguments['itemId'];
    bool _back = arguments['back'];
    final techSign = ticketSuivi.technicienSignature;
    final clientSign = ticketSuivi.clientSignature;

    Widget requiredMessage() {
      return Visibility(
        visible: _formValidate,
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              color: Color.fromRGBO(239, 163, 169, 1),
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        size: 26,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        AppLocalizations.of(context).champObligatoire,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      );
    }

    Widget requiredPhotoMessage() {
      return Visibility(
        visible: _photoValidate,
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              color: Color.fromRGBO(239, 163, 169, 1),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                child: Text(
                  AppLocalizations.of(context).justifierAppareilArret,
                  softWrap: true,
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      );
    }

    List<Widget> buildTechSuivi() {
      return [
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: AppLocalizations.of(context).suiviTechnicien,
                style: TextStyle(
                  fontFamily: 'QuickSand',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(112, 112, 112, 1),
                ),
              ),
              TextSpan(
                text: '*',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          inputFormatters: [
            FilteringTextInputFormatter.deny(
              RegExp(regex),
            ),
          ],
          controller: suiviTechnicien,
          keyboardType: TextInputType.text,
          minLines: 2,
          cursorColor: Colors.black,
          maxLines: null,
          decoration: InputDecoration(
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                style: BorderStyle.solid,
                color: Color.fromRGBO(204, 204, 204, 1),
                width: 0.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                style: BorderStyle.solid,
                color: Color.fromRGBO(204, 204, 204, 1),
                width: 0.5,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                style: BorderStyle.solid,
                color: Color.fromRGBO(0, 113, 187, 1),
                width: 0.5,
              ),
            ),
            fillColor: Colors.white,
          ),
          onSaved: (value) => ticketSuivi.suiviTechnicien =
              Comment(text: value, datePrise: DateTime.now()),
        )
      ];
    }

    List<Widget> buildTechSign() {
      return [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: AppLocalizations.of(context).signatureTechnicien,
                    style: TextStyle(
                      fontFamily: 'QuickSand',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(112, 112, 112, 1),
                    ),
                  ),
                  TextSpan(
                    text: '*',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FormField(builder: (FormFieldState state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    return Container(
                      height: 170,
                      width: constraints.maxWidth,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          width: 0.5,
                          color: Color.fromRGBO(204, 204, 204, 1),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 10,
                            left: 50,
                            child: Container(
                              height: 130,
                              width: 150,
                              child: techSign == null
                                  ? Container()
                                  : Center(
                                      child: Image.memory(ticketSuivi
                                          .technicienSignature.signature),
                                    ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: IconButton(
                              icon: Icon(
                                EvaIcons.trash_2_outline,
                                color: Theme.of(context).accentColor,
                                size: 23,
                              ),
                              onPressed: () {
                                if (techSign != null) {
                                  ticketSuivi.removeImage(
                                      ticketSuivi.technicienSignature.name);
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 35,
                            child: IconButton(
                              icon: Icon(
                                EvaIcons.edit_2_outline,
                                color: Theme.of(context).accentColor,
                                size: 23,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, TicketSignature.routeName,
                                    arguments: {
                                      'id': ticket.id,
                                      'personn': 1,
                                    });
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              );
            }),
          ],
        ),
      ];
    }

    Widget itemState() {
      return FormField(
        builder: (FormFieldState state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: AppLocalizations.of(context).appareilArret,
                          style: TextStyle(
                            fontFamily: 'QuickSand',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(112, 112, 112, 1),
                          ),
                        ),
                        TextSpan(
                          text: '* ',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: ': ',
                          style: TextStyle(
                            fontFamily: 'QuickSand',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(112, 112, 112, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      itemStateBtnStyle(1);
                      if (btnYes) {
                        ticketSuivi.itemState = 2;
                      } else {
                        ticketSuivi.itemState = 0;
                      }
                      if (ticketSuivi.allImages.isEmpty) {
                        Navigator.pushNamed(context, Photos.routeName,
                            arguments: {
                              'id': ticket.id,
                              'title': 'Ticket : ${ticket.id}',
                              'back': false
                            });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      child: Text(
                        AppLocalizations.of(context).btnOui,
                        style: TextStyle(
                          color: btnYes
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).primaryColor, width: 1),
                        color: btnYes
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      itemStateBtnStyle(0);
                      if (btnNo) {
                        ticketSuivi.itemState = 1;
                      } else {
                        ticketSuivi.itemState = 0;
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      child: Text(
                        AppLocalizations.of(context).btnNo,
                        style: TextStyle(
                          color: btnNo
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).primaryColor, width: 1),
                        color: btnNo
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
    }

    Widget techButtonRow() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              Navigator.pushNamed(context, Photos.routeName, arguments: {
                'id': ticket.id,
                'title': 'Ticket : ${ticket.id}',
                'back': true
              });
            },
            child: Row(
              children: [
                Icon(
                  EvaIcons.camera,
                  size: 18,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  AppLocalizations.of(context).photo,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              _formKeyTech.currentState.save();
              if (btnYes == true && ticketSuivi.allImages.isEmpty) {
                setState(() {
                  _photoValidate = true;
                });
                scrollController.animateTo(
                    scrollController.position.minScrollExtent,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease);
              } else if (ticketSuivi.itemState != 0 &&
                  (ticketSuivi.suiviTechnicien != null &&
                      ticketSuivi.suiviTechnicien.text != '') &&
                  ticketSuivi.sigEmpty()) {
                setState(() {
                  _formValidate = false;
                  pageViewIndex = 1;
                  pageViewController.animateToPage(pageViewIndex,
                      duration: Duration(milliseconds: 100),
                      curve: Curves.easeIn);
                });
              } else {
                setState(() {
                  _formValidate = true;
                });
                scrollController.animateTo(
                    scrollController.position.minScrollExtent,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease);
              }
            },
            child: Text(
              AppLocalizations.of(context).suivant,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
    }

    List<Widget> buildClientComment() {
      return [
        Text(
          AppLocalizations.of(context).suiviClient,
          style: TextStyle(
            fontFamily: 'QuickSand',
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color.fromRGBO(112, 112, 112, 1),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
            inputFormatters: [
              FilteringTextInputFormatter.deny(
                RegExp(regex),
              ),
            ],
            controller: commentClient,
            keyboardType: TextInputType.text,
            minLines: 2,
            cursorColor: Colors.black,
            maxLines: null,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: Color.fromRGBO(204, 204, 204, 1),
                  width: 0.5,
                ),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: Color.fromRGBO(0, 113, 187, 1),
                  width: 0.5,
                ),
              ),
              fillColor: Colors.white,
            ),
            onSaved: (value) {
              if (value.isNotEmpty) {
                ticketSuivi.commentClient = Comment(
                    text: value,
                    datePrise: DateTime.now(),
                    auteur: ticket.demandeurId);
              }
            }),
      ];
    }

    Widget buildClientSign() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).signatureClient,
            style: TextStyle(
              fontFamily: 'QuickSand',
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(112, 112, 112, 1),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              height: 170,
              width: constraints.maxWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  width: 0.5,
                  color: Color.fromRGBO(204, 204, 204, 1),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 50,
                    child: Container(
                      height: 130,
                      width: 150,
                      child: clientSign == null
                          ? Container()
                          : Image.memory(ticketSuivi.clientSignature.signature),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(
                        EvaIcons.trash_2_outline,
                        color: Theme.of(context).accentColor,
                        size: 23,
                      ),
                      onPressed: () {
                        if (clientSign != null) {
                          ticketSuivi
                              .removeImage(ticketSuivi.clientSignature.name);
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 35,
                    child: IconButton(
                      icon: Icon(
                        EvaIcons.edit_2_outline,
                        color: Theme.of(context).accentColor,
                        size: 23,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, TicketSignature.routeName,
                            arguments: {
                              'id': ticket.id,
                              'personn': 2,
                            });
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      );
    }

    Widget satisfactionClient() {
      return Row(
        children: [
          Text(
            AppLocalizations.of(context).satisfactionClient,
            style: TextStyle(
              fontFamily: 'QuickSand',
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(112, 112, 112, 1),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              starSatisfactionClient(1);
              if (star_1) {
                ticketSuivi.satisfactionClient = Comment(
                    text: AppLocalizations.of(context).tresMauvais,
                    datePrise: DateTime.now(),
                    auteur: ticket.demandeurId);
              } else {
                ticketSuivi.satisfactionClient = null;
              }
            },
            child: Container(
              height: 33,
              width: 33,
              decoration: BoxDecoration(
                color: star_1 ? Colors.red : Colors.red[300],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Fontelico.emo_angry,
                color: star_1 ? Colors.white : Colors.red,
                size: 15,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          GestureDetector(
            onTap: () {
              starSatisfactionClient(2);
              if (star_2) {
                ticketSuivi.satisfactionClient = Comment(
                    text: AppLocalizations.of(context).mauvais,
                    datePrise: DateTime.now(),
                    auteur: ticket.demandeurId);
              } else {
                ticketSuivi.satisfactionClient = null;
              }
            },
            child: Container(
              height: 33,
              width: 33,
              decoration: BoxDecoration(
                color: star_2 ? Colors.orange : Colors.orangeAccent,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Fontelico.emo_unhappy,
                color: star_2 ? Colors.white : Colors.orange,
                size: 15,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          GestureDetector(
            onTap: () {
              starSatisfactionClient(3);
              if (star_3) {
                ticketSuivi.satisfactionClient = Comment(
                    text: AppLocalizations.of(context).bien,
                    datePrise: DateTime.now(),
                    auteur: ticket.demandeurId);
              } else {
                ticketSuivi.satisfactionClient = null;
              }
            },
            child: Container(
              height: 33,
              width: 33,
              decoration: BoxDecoration(
                color: star_3 ? Colors.green : Colors.lightGreen,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Fontelico.emo_happy,
                color: star_3 ? Colors.white : Colors.green,
                size: 15,
              ),
            ),
          ),
        ],
      );
    }

    Widget clientButtonRow() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
            ),
            /* disabledColor: Color.fromRGBO(0, 113, 187, 0.5), */
            onPressed: () {
              setState(() {
                pageViewIndex = 0;
                pageViewController.animateToPage(pageViewIndex,
                    duration: Duration(milliseconds: 100),
                    curve: Curves.easeIn);
              });
              _formKeyClient.currentState.save();
            },
            child: Text(
              AppLocalizations.of(context).retour,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              _formKeyClient.currentState.save();
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => confirmAlertDialog(
                  no: () {
                    Navigator.of(context).pop();
                  },
                  yes: () {
                    resolveTicket(ticket, _back);
                  },
                  title: AppLocalizations.of(context).etesVousSur,
                  subtitle: AppLocalizations.of(context).effectuerModification,
                  context: context,
                ),
              );
            },
            child: Text(
              AppLocalizations.of(context).confirmer,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
    }

    Widget buildTechPage() {
      return Form(
        key: _formKeyTech,
        child: SingleChildScrollView(
          controller: scrollController,
          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              requiredMessage(),
              requiredPhotoMessage(),
              ...buildTechSuivi(),
              SizedBox(
                height: 28,
              ),
              ...buildTechSign(),
              SizedBox(
                height: 28,
              ),
              itemState(),
              SizedBox(
                height: 28,
              ),
              techButtonRow(),
            ],
          ),
        ),
      );
    }

    Widget buildClientPage() {
      return Form(
        key: _formKeyClient,
        child: SingleChildScrollView(
          controller: scrollController,
          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...buildClientComment(),
              SizedBox(
                height: 28,
              ),
              buildClientSign(),
              SizedBox(
                height: 28,
              ),
              satisfactionClient(),
              SizedBox(
                height: 32,
              ),
              clientButtonRow(),
            ],
          ),
        ),
      );
    }

    List pageContent = [
      buildTechPage(),
      buildClientPage(),
    ];

    bool returnIfEmpty() {
      ticketSuivi.resetTicketResponse();
      return true;
    }

    return _back
        ? WillPopScope(
            onWillPop: () async {
              return ticketSuivi.checkIfEmpty()
                  ? returnIfEmpty()
                  : (await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => AlertDialog(
                          actionsPadding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                          title: Text(
                            AppLocalizations.of(context).etesVousSur,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          content: Text(
                            AppLocalizations.of(context).retournerTicket,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(false);
                                /* return false; */
                              },
                              child: Text(
                                AppLocalizations.of(context).btnNo,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontFamily: 'QuickSand',
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(true);
                                ticketSuivi.resetTicketResponse();
                                /* return true; */
                              },
                              child: Text(
                                AppLocalizations.of(context).btnOui,
                                style: TextStyle(
                                    color: Colors.green,
                                    fontFamily: 'QuickSand'),
                              ),
                            ),
                          ],
                        ),
                      )) ??
                      false;
            },
            child: Scaffold(
              appBar: buildAppbar(
                'Ticket : ${ticket.id}',
                context,
                _back,
              ),
              body: PageView.builder(
                physics: NeverScrollableScrollPhysics(),
                controller: pageViewController,
                itemBuilder: (context, pageViewIndex) {
                  return pageContent[pageViewIndex];
                },
              ),
            ),
          )
        : WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              appBar: buildAppbar(
                'Ticket : ${ticket.id}',
                context,
                _back,
              ),
              body: PageView.builder(
                physics: NeverScrollableScrollPhysics(),
                controller: pageViewController,
                itemBuilder: (context, pageViewIndex) {
                  return pageContent[pageViewIndex];
                },
              ),
            ),
          );
  }
}
