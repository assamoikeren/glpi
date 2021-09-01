import 'package:flutter/foundation.dart';
import './task.dart';
import './step.dart';
import './observer.dart';

enum TicketType {
  incident,
  workorders,
}

class Ticket with ChangeNotifier {
  int id;
  String demandeur;
  int demandeurId;
  int itemId;
  String itemNumber;
  String titre;
  String categorie;
  int categorieId;
  String technicien;
/*   final String adresseclient; */
  DateTime dateCreation;
  DateTime dateDebut;
  DateTime dateFin;
  String sla;
  String description;
  TicketType type;
  //List<dynamic> country;
  List<Observer> observateur;
  List<Step> step;
  List<Task> task;
  int procedureId;
  String contrat;
  String slaStatus;
  bool isObs;
  bool isTech;
  int statut;
  //bool started;
  bool ticketIsNew;

  Ticket(
      {this.id,
      this.demandeur,
      this.demandeurId,
      this.itemNumber,
      this.titre,
      this.itemId,
      this.categorie,
      this.categorieId,
      this.technicien,
      this.isObs,
      this.isTech,
      /*  @required this.adresseclient, */
      this.dateCreation,
      this.sla,
      this.description,
      //this.country,
      this.observateur,
      this.step,
      this.task,
      this.type,
      this.procedureId,
      this.contrat,
      this.statut,
      this.slaStatus,
      this.dateDebut,
      this.dateFin,
      this.ticketIsNew});

  void toggleStatut() {
    this.statut = 7;
    notifyListeners();
  }

  void toggleIsNew() {
    this.ticketIsNew = false;
    notifyListeners();
  }

  factory Ticket.fromMap({Map<String, dynamic> map, int index}) {
    return Ticket(
      id: map['number'],
      procedureId: map['procedure_id'],
      contrat: map['contrat'],
      demandeur: map['demandeur'],
      demandeurId:
          map['demandeurId'] != '' ? int.parse(map['demandeurId']) : null,
      itemNumber: map['item_number'] ?? map['item_number'],
      titre: map['titre'],
      sla: map['sla'],
      categorie: map['categorie'],
      categorieId: map['categorie_id'],
      technicien: map['technicien'],
      dateCreation: DateTime.parse(map['dateCreation']),
      dateDebut:
          map['dateDebut'] != null ? DateTime.parse(map['dateDebut']) : null,
      dateFin: map['dateFin'] != null ? DateTime.parse(map['dateFin']) : null,
      type: map['type'] == 1 ? TicketType.incident : TicketType.workorders,
      description: map['description'],
      observateur: map['observateur'],
      isObs: map['obs'] == 'yes' ? true : false,
      isTech: map['tech'] == 'yes' ? true : false,
      statut: map['status'],
      slaStatus: map['slaStatus'],
      task: map['task'] != null ? convertToTask(map['task']) : null,
      step: map['step'] != null ? convertToStep(map['step']) : null,
      itemId: map['item_id'],
      ticketIsNew: map['new'] == 0 ? false : true,
    );
  }

  factory Ticket.fromJson({Map<String, dynamic> json, int index}) {
    return Ticket(
      id: json['number'],
      procedureId: json['procedure_id'],
      contrat: json['contrat'],
      demandeur: json['demandeur'],
      demandeurId:
          json['demandeurId'] != '' ? int.parse(json['demandeurId']) : null,
      itemNumber: json['item_number'] ?? json['item_number'],
      titre: json['titre'],
      sla: json['sla'],
      categorie: json['categorie'],
      categorieId: json['categorie_id'],
      technicien: json['technicien'],
      dateCreation: DateTime.parse(json['dateCreation']),
      dateDebut:
          json['dateDebut'] != null ? DateTime.parse(json['dateDebut']) : null,
      dateFin: json['dateFin'] != null ? DateTime.parse(json['dateFin']) : null,
      type: json['type'] == 1 ? TicketType.incident : TicketType.workorders,
      description: json['description'],
      observateur: json['observateur'] != null
          ? convertToObserver(json['observateur'])
          : null,
      isObs: json['obs'] == 'yes' ? true : false,
      isTech: json['tech'] == 'yes' ? true : false,
      statut: json['status'],
      slaStatus: json['slaStatus'],
      task: json['task'] != null ? convertToTask(json['task']) : null,
      step: json['step'] != null ? convertToStep(json['step']) : null,
      itemId: json['item_id'],
      ticketIsNew: json['new'] == 0 ? false : true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'procedureId': procedureId,
      'contrat': contrat,
      'demandeur': demandeur,
      'demandeurId': demandeurId,
      'itemNumber': itemNumber,
      'titre': titre,
      'sla': sla,
      'categorie': categorie,
      'categorieId': categorieId,
      'technicien': technicien,
      'dateCreation': dateCreation,
      'dateDebut': dateDebut,
      'dateFin': dateFin,
      'type': type,
      'description': description,
      'observateur': observateur,
      'isObs': isObs,
      'isTech': isTech,
      'statut': statut,
      'slaStatus': slaStatus,
      'task': task,
      'step': step,
      'itemId': itemId,
      'ticketIsNew': ticketIsNew,
    };
  }
}

List<Task> convertToTask(List<dynamic> json) {
  List<Task> taskList = [];
  for (var i = 0; i < json.length; i++) {
    taskList.add(Task.convertToTask(json[i]));
  }
  return taskList;
}

List<Observer> convertToObserver(List<dynamic> json) {
  List<Observer> observerList = [];
  for (var i = 0; i < json.length; i++) {
    observerList.add(Observer.convertToObserver(json[i]));
  }
  return observerList;
}

List<Step> convertToStep(List<dynamic> json) {
  List<Step> stepList = [];
  for (var i = 0; i < json.length; i++) {
    stepList.add(Step.convertToStep(json[i]));
  }
  return stepList;
}
