import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/appbar.dart';
import '../utils/constant.dart';
import 'package:flutter/services.dart';
import './photos.dart';
import '../providers/tickets_provider.dart';
import '../providers/ticket_suivi_controller.dart';
import '../models/task.dart';
import '../models/ticket_response.dart';
import './close_ticket.dart';
import '../screens/workorders_procedures.dart';
import '../models/ticket.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Checklist extends StatefulWidget {
  static const routeName = '/checklist';

  @override
  _ChecklistState createState() => _ChecklistState();
}

class _ChecklistState extends State<Checklist> with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final selectedTasks = <Task>{};
  List<bool> selected = [];
  String commentaire;

  String periodText(int period) {
    if (period == 1) {
      return 'Description / ${AppLocalizations.of(context).passageMensuel}';
    } else if (period == 2) {
      return 'Description / ${AppLocalizations.of(context).passageTrimestriel}';
    } else if (period == 3) {
      return 'Description / ${AppLocalizations.of(context).passageTrimestriel}';
    } else if (period == 4) {
      return 'Description / ${AppLocalizations.of(context).passageAnnuel}';
    }
    return '';
  }

  void onPopMenuSelect(
      int value, int index, List<Task> tabTaks, int ticketId, int stepId) {
    switch (value) {
      case 1:
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  periodText(tabTaks[index].period),
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpensSans'),
                ),
                content: Text(
                  tabTaks[index].taskContent,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              );
            });
        break;
      case 2:
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                actionsPadding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(237, 241, 247, 1),
                      padding: EdgeInsets.all(5),
                      textStyle: TextStyle(
                        fontSize: 12,
                        fontFamily: "Quicksand",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context).annuler,
                      style: TextStyle(
                        color: Color.fromRGBO(132, 135, 138, 1),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        Navigator.pop(context);
                        Provider.of<TicketSuivi>(context, listen: false)
                            .addCommentTask(commentaire, tabTaks[index].taskId);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(0, 113, 187, 1),
                      padding: EdgeInsets.all(5),
                      textStyle: TextStyle(
                        fontSize: 12,
                        fontFamily: "Quicksand",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context).sauvegarder,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
                content: Form(
                  key: _formKey,
                  child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(
                        RegExp(regex),
                      ),
                    ],
                    validator: (value) => value.isEmpty
                        ? AppLocalizations.of(context).renseignerCommentaire
                        : null,
                    onSaved: (value) => commentaire = value,
                    textAlignVertical: TextAlignVertical.center,
                    keyboardType: TextInputType.multiline,
                    minLines: 5,
                    cursorColor: Colors.black,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context).writeCommentaire,
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(112, 112, 112, 0.6),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          style: BorderStyle.none,
                          color: Colors.white,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          style: BorderStyle.none,
                          color: Colors.white,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          style: BorderStyle.none,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            });
        break;
      case 3:
        Navigator.pushNamed(context, Photos.routeName, arguments: {
          'title': '${AppLocalizations.of(context).taches} ${index + 1}',
          'task_id': tabTaks[index].taskId,
          'id': ticketId,
          'step_id': stepId,
          'back': true,
        });
        break;
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    print('checklist is buildings');
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('checklist is building');
    //final ticketSuivi = Provider.of<TicketSuivi>(context, listen: false);
    final arguments =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final int stepIndex = arguments['step'];
    final Ticket ticket = arguments['ticket'];
    final int stepId = arguments['stepId'];
    final taskList = Provider.of<Tickets>(context, listen: false)
        .findTaskById(ticket: ticket, stepId: stepId);
    final demandeurId = ticket.demandeurId;
    final itemId = ticket.id;
    final step =
        Provider.of<Tickets>(context, listen: false).findStepById(ticket);
    final stepLength =
        Provider.of<Tickets>(context, listen: false).numberStep(ticket);

    Color popMenuButtonColor(int period) {
      Color setColor;
      if (period == 1) {
        setColor = Color.fromRGBO(255, 206, 0, 1);
        // mensuel jaune
      } else if (period == 2) {
        setColor = Color.fromRGBO(0, 159, 0, 1);
        // trimestriel vert
      } else if (period == 3) {
        setColor = Colors.pink;
        // semestriel
      } else if (period == 4) {
        setColor = Colors.red;
        // annuel
      }
      return setColor;
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: taskList.isEmpty
              ? buildAppbar('Tâches', context, false)
              : buildAppbar('${step[stepIndex].name}', context, false),
          body: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              height: double.infinity,
              child: taskList.isEmpty
                  ? Container(
                      child: Text(AppLocalizations.of(context).vousAvezTache),
                    )
                  : Stack(children: [
                      ListView.builder(
                        padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
                        itemBuilder: (context, index) {
                          Task task = taskList[index];
                          int ind = taskList.indexOf(task);
                          return Card(
                            margin: EdgeInsets.only(bottom: 15),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 5),
                              child: CheckboxListTile(
                                key: ValueKey(task.taskId),
                                value: task
                                    .checked == true, //selectedTasks.contains(task),
                                onChanged: (bool newValue) {
                                  print(task.checked);
                                  setState(() {
                                    task.toggleCheck();
                                  });
                                  print(task.checked);
                                  if (task.checked) {
                                    selectedTasks.add(task);
                                    Provider.of<TicketSuivi>(context,
                                            listen: false)
                                        .addSelectedTask(
                                      SelectedTask(
                                          ticketId: ticket.id,
                                          stepId: stepId,
                                          taskId: task.taskId,
                                          taskPictures: [],
                                          comment: null,
                                          dateFin: DateTime.now()),
                                    );
                                  } else {
                                    selectedTasks.remove(task);
                                    Provider.of<TicketSuivi>(context,
                                            listen: false)
                                        .removeSelectedTask(task.taskId);
                                  }
                                  //setState(() {});
                                },
                                title: Text(
                                  taskList[index]
                                      .taskName
                                      .toString()
                                      .capitalizeAndLowercase(),
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Quicksand',
                                  ),
                                ),
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 0, 10, 0),
                                secondary: PopupMenuButton<int>(
                                  icon: Icon(
                                    Icons.more_vert_outlined,
                                    color: popMenuButtonColor(
                                        taskList[index].period),
                                    size: 25,
                                  ),
                                  offset: Offset(0, 20),
                                  onSelected: (result) {
                                    int value = result;
                                    if (value != 1) {
                                      if (task.checked /* selectedTasks
                                          .contains(taskList[index] )*/
                                          ) {
                                        onPopMenuSelect(value, index, taskList,
                                            ticket.id, stepId);
                                      } else {
                                        final snackBar = SnackBar(
                                          content: Text(
                                              AppLocalizations.of(context)
                                                  .selectionnerTache),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    } else {
                                      onPopMenuSelect(value, index, taskList,
                                          ticket.id, stepId);
                                    }
                                  },
                                  itemBuilder: (BuildContext context) => [
                                    const PopupMenuItem(
                                      value: 1,
                                      child: Text(
                                        'Description',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    const PopupMenuDivider(
                                      height: 10,
                                    ),
                                    PopupMenuItem(
                                      value: 2,
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .commentaire,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    const PopupMenuDivider(
                                      height: 10,
                                    ),
                                    PopupMenuItem(
                                      value: 3,
                                      child: Text(
                                        AppLocalizations.of(context).photos,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                activeColor:
                                    popMenuButtonColor(taskList[index].period),
                              ),
                            ),
                          );
                        },
                        itemCount: taskList.length,
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            if (selectedTasks.containsAll(taskList)) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => new AlertDialog(
                                  actionsPadding:
                                      EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                                  title: new Text(
                                    AppLocalizations.of(context).etesVousSur,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  content: Text(
                                    AppLocalizations.of(context)
                                        .effectuerModification,
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: new Text(
                                        AppLocalizations.of(context).btnNo,
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontFamily: 'Quicksand'),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        if (selected
                                            .isNotEmpty /* selectedTasks.isNotEmpty */) {
                                          Provider.of<TicketSuivi>(context,
                                                  listen: false)
                                              .saveSelectedTask(
                                                  context, _keyLoader);
                                        }
                                        int index = stepIndex + 1;
                                        if (index < stepLength) {
                                          Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            Procedure.routeName,
                                            ModalRoute.withName('/workOrders'),
                                            arguments: {
                                              'id': ticket.id,
                                              'ticket': ticket,
                                              'step_index': index
                                            },
                                          );
                                        } else {
                                          Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            CloseTicket.routeName,
                                            ModalRoute.withName('/workOrders'),
                                            arguments: {
                                              'id': ticket.id,
                                              'ticket': ticket,
                                              'back': false,
                                              'itemId': itemId,
                                              'demandeurId': demandeurId
                                            },
                                          );
                                        }
                                      },
                                      child: new Text(
                                        AppLocalizations.of(context).btnOui,
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontFamily: 'Quicksand',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => new AlertDialog(
                                  actionsPadding:
                                      EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                                  title: new Text(
                                    AppLocalizations.of(context).etesVousSur,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  content: Text(
                                    AppLocalizations.of(context)
                                        .toutesLesTaches,
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: new Text(
                                        AppLocalizations.of(context).btnNo,
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontFamily: 'QuickSand'),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        if (selected
                                            .isNotEmpty /* selectedTasks.isNotEmpty */) {
                                          Provider.of<TicketSuivi>(context,
                                                  listen: false)
                                              .saveSelectedTask(
                                                  context, _keyLoader);
                                        }
                                        int index = stepIndex + 1;
                                        if (index < stepLength) {
                                          Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            Procedure.routeName,
                                            ModalRoute.withName('/workOrders'),
                                            arguments: {
                                              'id': ticket.id,
                                              'ticket': ticket,
                                              'step_index': index
                                            },
                                          );
                                        } else {
                                          Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            CloseTicket.routeName,
                                            ModalRoute.withName('/workOrders'),
                                            arguments: {
                                              'id': ticket.id,
                                              'ticket': ticket,
                                              'back': false,
                                              'itemId': itemId,
                                              'demandeurId': demandeurId
                                            },
                                          );
                                        }
                                      },
                                      child: new Text(
                                        AppLocalizations.of(context).btnOui,
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
                          child: Text(
                            AppLocalizations.of(context).suivant,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ]),
            ),
          )),
    );
  }
}
