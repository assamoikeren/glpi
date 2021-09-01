//import 'package:glpi3/models/ticketResponse.dart';
import 'dart:convert';
import 'package:moor/moor.dart' hide Column;
import 'moor_database.dart';
import '../models/ticket.dart';
import '../models/observer.dart';
import '../models/step.dart';
import '../models/task.dart';
//import 'package:glpi3/models/ticketResponse.dart';
//import 'package:duration/duration.dart';
//import 'package:intl/intl.dart';

class Converts {
  //static int  TICKET_NEW =1,TICKET_EN_COURS =2,TICKET_PLANIFIE=3,TICKET_EN_ATTENTE=4, TICKET_RESOLU = 5, TICKET_CLOS =6;

  static LocalTicketsCompanion castCompagnon(Ticket ticket) {
    return LocalTicketsCompanion(
      id: Value(ticket.id),
      demandeur: Value(ticket.demandeur),
      demandeurId: Value(ticket.demandeurId),
      itemId: Value(ticket.itemId),
      itemNumber: Value(ticket.itemNumber),
      titre: Value(ticket.titre),
      categorie: Value(ticket.categorie),
      categorieId: Value(ticket.categorieId),
      technicien: Value(ticket.technicien),
      dateCreation: Value(ticket.dateCreation),
      dateDebut: Value(ticket.dateDebut),
      dateFin: Value(ticket.dateFin),
      sla: Value(ticket.sla),
      description: Value(ticket.description),
      type: ticket.type == TicketType.incident ? Value(1) : Value(2),
      observateurs: Value(observateursToString(ticket.observateur)),
      steps: Value(stepsToString(ticket.step)),
      tasks: Value(tasksToString(ticket.task)),
      procedureId: Value(ticket.procedureId),
      contrat: Value(ticket.contrat),
      slaStatus: Value(ticket.slaStatus),
      isObs: Value(ticket.isObs),
      isTech: Value(ticket.isTech),
      statut: Value(ticket.statut),
      //started: Value(ticket.started),
      ticketIsNew: Value(ticket.ticketIsNew),
    );
  }

  // Convertir TicketCompation à TicketReponse
  static Ticket convert(LocalTicket tc) {
    Ticket tr = new Ticket();
    tr.id = tc.id;
    tr.demandeur = tc.titre;
    tr.demandeurId = tc.demandeurId;
    tr.itemId = tc.itemId;
    tr.itemNumber = tc.itemNumber;
    tr.titre = tc.titre;
    tr.categorie = tc.categorie;
    tr.categorieId = tc.categorieId;
    tr.technicien = tc.technicien;
    tr.dateCreation = tc.dateCreation;
    tr.dateDebut = tc.dateDebut;
    tr.dateFin = tc.dateFin;
    tr.sla = tc.sla;
    tr.description = tc.description;
    tr.type = tc.type == 1 ? TicketType.incident : TicketType.workorders;
    tr.observateur = stringToSbservateurs(tc.observateurs);
    tr.step = stringTosteps(tc.steps);
    tr.task = stringToTasks(tc.tasks);
    tr.procedureId = tc.procedureId;
    tr.contrat = tc.contrat;
    tr.slaStatus = tc.slaStatus;
    tr.technicien = tc.technicien;
    tr.isObs = tc.isObs;
    tr.isTech = tc.isTech;
    tr.statut = tc.statut;
    //tr.started = tc.started;
    tr.ticketIsNew = tc.ticketIsNew;
    return tr;
  }

  // Converter tables ************
  // Observateur
  static String observateursToString(List<Observer> list) {
    if (list == null) {
      return null;
    }
    return jsonEncode(list.map((e) => e.toJson()).toList());
  }

  static List<Observer> stringToSbservateurs(String observateurs) {
    try {
      List<dynamic> map = jsonDecode(observateurs);
      final parsed = map.cast<Map<String, dynamic>>();
      return parsed.map<Observer>((json) => Observer.fromJson(json)).toList();
    } catch (e) {
      return null;
    }
  }

  // Suivis
  static String stepsToString(List<Step> list) {
    if (list == null) {
      return null;
    }
    return jsonEncode(list.map((e) => e.toJson()).toList());
  }

  static List<Step> stringTosteps(String steps) {
    try {
      List<dynamic> map = jsonDecode(steps);
      final parsed = map.cast<Map<String, dynamic>>();
      return parsed.map<Step>((json) => Step.fromJson(json)).toList();
    } catch (e) {
      return null;
    }
  }

  // Taches
  static String tasksToString(List<Task> list) {
    if (list == null) {
      return null;
    }
    return jsonEncode(list.map((e) => e.toJson()).toList());
  }

  static List<Task> stringToTasks(String taches) {
    try {
      List<dynamic> map = jsonDecode(taches);
      final parsed = map.cast<Map<String, dynamic>>();
      return parsed.map<Task>((json) => Task.fromJson(json)).toList();
    } catch (e) {
      return null;
    }
  }
}
