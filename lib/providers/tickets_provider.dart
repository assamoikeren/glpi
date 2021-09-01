import 'package:flutter/material.dart';
import '../utils/http.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import '../utils/constant.dart';
import '../models/ticket.dart';
import '../models/task.dart';
import '../models/step.dart' as proStep;
import 'auth.dart';
import '../database/moor_database.dart';
import '../database/converts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class Tickets with ChangeNotifier {
  List<Ticket> _tickets = [];
  int count = 0;

  List<Ticket> get incidents {
    return [..._tickets].where((ticket) {
      return (ticket.type == TicketType.incident);
    }).toList(); // return a copy of the _items list
  }

  List<Ticket> get workOrders {
    return [..._tickets].where((ticket) {
      return (ticket.type == TicketType.workorders);
    }).toList(); // return a copy of the _items list
  }

  Future fetchTickets(BuildContext context) async {
    String token =
        await Provider.of<AuthProvider>(context, listen: false).getToken();
    int id = await Provider.of<AuthProvider>(context, listen: false).getId();

    var http = getHttp();
    final bool isConnected = await InternetConnectionChecker().hasConnection;
    if (isConnected) {
      try {
        final response =
            await http.get(Uri.parse('$API_URL_WALIX/tickets/$id'), headers: {
          'Authorization': 'Bearer $token',
        });
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['Message'] == 'Pas de ticket') {
        } else if (data['Message'] == 'ok') {
          _tickets = [];
          final dao = Provider.of<LocalTicketDao>(context, listen: false);

          if (count != 0) {
            dao.feelingLazy();
          }

          for (int i = 0; i < data['Ticket'].length; i++) {
            Ticket ticket = Ticket.fromJson(json: data['Ticket'][i]);
            dao.inserticket(Converts.castCompagnon(ticket));
          }

          count++;

          notifyListeners();
        }
      } catch (error) {
        print(error);
      } finally {
        http.close();
      }
    }
  }

  Future<void> assignToObserver(
      {int userId, int ticketId, BuildContext context}) async {
    String token =
        await Provider.of<AuthProvider>(context, listen: false).getToken();
    var http = getHttp();
    final dao = Provider.of<LocalTicketDao>(context, listen: false);
    try {
      await http.put(Uri.parse('$API_URL_WALIX/updateTech/$userId/$ticketId'),
          headers: {
            'Authorization': 'Bearer $token',
          });
      dao.deleteTicket(ticketId);
    } catch (error) {
      Navigator.pop(context);
      /*  print(error); */
    } finally {
      http.close();
    }
  }

  List<Ticket> get allTickets {
    return [..._tickets];
  }

  int numberStep(Ticket ticket) {
    //Ticket ticket = findById(id);
    int stepLength = ticket.step.length;
    return stepLength;
  }

  /* List<proStep.Step> findStepById(int id) {
    Ticket ticket = findById(id);
    if (ticket != null) {
      List<proStep.Step> step = ticket.step;
      return step;
    }
    return null;
  } */

  List<proStep.Step> findStepById(Ticket ticket) {
    List<proStep.Step> step = ticket.step;
    return step;
  }

  String findStepQrCode({Ticket ticket, int stepId}) {
    //Ticket ticket = findById(ticketId);
    proStep.Step step =
        ticket.step.firstWhere((element) => element.id == stepId);
    String qrCode = step.qrCode;
    return qrCode;
  }

  List<Task> findTaskById({Ticket ticket, int stepId}) {
    List<Task> task = [];
    //if (ticket != null) {
    task = ticket.task.where((element) => element.stepId == stepId).toList();
    //}
    return task;
  }

  String itemSerial(int id) {
    Ticket ticket = findById(id);
    if (ticket != null) {
      String itemNumber = ticket.itemNumber;
      return itemNumber;
    }
    return null;
  }

  Ticket findById(int id) {
    return [..._tickets]
        .firstWhere((element) => element.id == id, orElse: () => null);
  }

  Ticket demandeur(int id) {
    return [..._tickets]
        .firstWhere((element) => element.id == id, orElse: () => null);
  }

  int demandeurId(int id) {
    Ticket ticket = findById(id);
    if (ticket != null) {
      return ticket.demandeurId;
    }
    return null;
  }

  int itemId(int id) {
    Ticket ticket = findById(id);
    if (ticket != null) {
      return ticket.itemId;
    }
    return null;
  }

  void addTickets(item) {
    _tickets.add(item);
    notifyListeners();
  }

  void change(item) {
    _tickets.add(item);
    notifyListeners();
  }

  void removeTickets(int id) {
    _tickets.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
