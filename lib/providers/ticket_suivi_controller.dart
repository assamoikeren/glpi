import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:provider/provider.dart';
import 'auth.dart';
import '../models/ticket.dart';
import '../models/ticket_response.dart';
import '../utils/constant.dart';
import '../utils/http.dart';
import '../providers/tickets_provider.dart';
import '../database/moor_database.dart';

class TicketSuivi with ChangeNotifier {
  List<Picture> _itemPictures = [];
  int itemState = 0;
  Comment satisfactionClient;
  Comment commentClient;
  Comment suiviTechnicien;
  List<SelectedTask> _selectedTask = [];
  List<UserPosition> _positions = [];

  void resetTicketResponse() {
    _itemPictures = [];
    _positions = [];
    _selectedTask = [];
    itemState = 0;
    satisfactionClient = null;
    commentClient = null;
    suiviTechnicien = null;
  }

  bool checkIfEmpty() {
    if (_itemPictures.isEmpty &&
        itemState == 0 &&
        satisfactionClient == null &&
        commentClient == null &&
        suiviTechnicien == null) {
      return true;
    } else {
      return false;
    }
  }

  void addImage(Picture file) {
    _itemPictures.add(file);
    notifyListeners();
  }

  void addTaskImage(Picture file, int taskId) {
    _selectedTask
        .firstWhere(
            (element) => element.taskId == taskId /* , orElse: () => null */)
        .taskPictures
        .add(file);
    notifyListeners();
  }

  void removeTaskImage(String name, int taskId) {
    _selectedTask
        .firstWhere(
            (element) => element.taskId == taskId /* , orElse: () => null */)
        .taskPictures
        .removeWhere((image) => image.name == name);
    notifyListeners();
  }

  void addSelectedTask(SelectedTask task) {
    _selectedTask.add(task);
    notifyListeners();
  }

  addCommentTask(String commentaire, int taskId) {
    _selectedTask
        .firstWhere(
            (element) => element.taskId == taskId /* , orElse: () => null */)
        .comment = commentaire;
    notifyListeners();
  }

  void removeSelectedTask(int id) {
    _selectedTask.removeWhere((element) => element.taskId == id);
  }

  void addPosition(UserPosition userGps) {
    _positions.add(userGps);
    notifyListeners();
  }

  void removeImage(String name) {
    _itemPictures.removeWhere((image) => image.name == name);
    notifyListeners();
  }

  void takeSignature(Uint8List img, int ticketId, int stat) async {
    final Picture signature = Picture(
      name:
          stat == 1 ? '${ticketId}_sig_tech.png' : '${ticketId}_sig_client.png',
      datePrise: DateTime.now(),
      signature: img,
      statut: stat,
    );
    addImage(signature);
  }

  List<Picture> get allImages {
    return [..._itemPictures].where((element) => element.statut == 0).toList();
  }

  List<Picture> taskImages(taskId) {
    final task = _selectedTask.firstWhere((element) => element.taskId == taskId,
        orElse: () => null);
    final pictureList = task.taskPictures;
    return pictureList;
  }

  Picture get technicienSignature {
    return [..._itemPictures].firstWhere((element) => element.statut == 1,
        orElse: () => null); // return a copy of the _items list
  }

  Picture get clientSignature {
    return [..._itemPictures].firstWhere((element) => element.statut == 2,
        orElse: () => null); // return a copy of the _items list
  }

  Picture signature(int personn) {
    return [..._itemPictures].firstWhere((element) => element.statut == personn,
        orElse: () => null); // return a copy of the _items list
  }

  bool sigEmpty() {
    Picture sig = signature(1);
    if (sig == null) {
      return false;
    }
    return true;
  }

  void saveComment({String comment, int personn}) {
    final Comment commentaire = Comment(
      text: comment,
      datePrise: DateTime.now(),
    );
    personn == 1 ? commentClient = commentaire : suiviTechnicien = commentaire;
    notifyListeners();
  }

  void removeComment(int personn) {
    personn == 1 ? commentClient = null : suiviTechnicien = null;
    notifyListeners();
  }

  Future<void> saveSelectedTask(BuildContext context, GlobalKey key) async {
    String token =
        await Provider.of<AuthProvider>(context, listen: false).getToken();
    final ticketResponse = TicketResponse(
      selectedTask: this._selectedTask,
    );
    final data = ticketResponse.toJsonSelectedTask();
    var http = getHttp();
    try {
      final response =
          await http.post(Uri.parse('$API_URL_WALIX/saveSelectedTask'),
              headers: {
                'Accept': 'application/json ',
                'Content-Type': 'application/json ; charset=UTF-8',
                'Authorization': 'Bearer $token',
              },
              body: jsonEncode(data));
      _selectedTask = [];
      if (response.statusCode == 500) {
        // Map<String, dynamic> apiResponse = json.decode(response.body);
        final Map<String, dynamic> data = json.decode(response.body);
        print(data['message']);
      }
    } catch (error) {} finally {
      http.close();
    }
  }

  Future<void> savePosition(Ticket ticket, BuildContext context) async {
    int id = await Provider.of<AuthProvider>(context, listen: false).getId();
    String token =
        await Provider.of<AuthProvider>(context, listen: false).getToken();
    /* final ticket =
        Provider.of<Tickets>(context, listen: false).findById(ticketId); */
    final ticketResponse = TicketResponse(
        ticketId: ticket.id,
        userId: id,
        ticketPositions: this._positions,
        suiviTechnicien: this.suiviTechnicien,
        solveDate: this._positions.last.datePrise,
        itemId: ticket.itemId,
        techName: ticket.technicien);

    final data = ticketResponse.toJsonPosition();
    var http = getHttp();
    try {
      final response = await http.post(Uri.parse('$API_URL_WALIX/savePosition'),
          headers: {
            'Accept': 'application/json ',
            'Content-Type': 'application/json ; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(data));
      if (response.statusCode == 500) {
        // Map<String, dynamic> apiResponse = json.decode(response.body);
        print('error');
      }
      resetTicketResponse();
    } catch (error) {} finally {
      http.close();
    }
  }

  Future<void> startIncident(Ticket ticket, BuildContext context) async {
    int id = await Provider.of<AuthProvider>(context, listen: false).getId();
    String token =
        await Provider.of<AuthProvider>(context, listen: false).getToken();
    /* final ticket =
    Provider.of<Tickets>(context, listen: false).findById(ticketId); */
    final ticketResponse = TicketResponse(
        ticketId: ticket.id,
        userId: id,
        ticketPositions: this._positions,
        suiviTechnicien: this.suiviTechnicien,
        solveDate: this._positions.last.datePrise,
        itemId: ticket.itemId,
        techName: ticket.technicien);
    final data = ticketResponse.toJsonstartIncident();
    var http = getHttp();
    try {
      final response =
          await http.post(Uri.parse('$API_URL_WALIX/startIncident'),
              headers: {
                'Accept': 'application/json ',
                'Content-Type': 'application/json ; charset=UTF-8',
                'Authorization': 'Bearer $token',
              },
              body: jsonEncode(data));
      if (response.statusCode == 500) {
        // Map<String, dynamic> apiResponse = json.decode(response.body);
        print('error');
      }
      resetTicketResponse();
    } catch (error) {} finally {
      http.close();
    }
  }

  Future<String> closeTicket(
      {Ticket ticket, BuildContext context, int itemId, GlobalKey key}) async {
    var http = getHttp();
    String result;
    int id = await Provider.of<AuthProvider>(context, listen: false).getId();
    String token =
        await Provider.of<AuthProvider>(context, listen: false).getToken();
    final dao = Provider.of<LocalTicketDao>(context, listen: false);
    /* final ticket =
        Provider.of<Tickets>(context, listen: false).findById(ticketId); */
    final ticketResponse = TicketResponse(
      userId: id,
      ticketId: ticket.id,
      procedureId: ticket.procedureId,
      dateOuverture: ticket.dateCreation,
      categorie: ticket.categorie,
      type: ticket.type == TicketType.incident ? 1 : 2,
      demandeurName: ticket.demandeur,
      techName: ticket.technicien,
      contractNumber: ticket.contrat,
      itemSerialNumber: ticket.itemNumber,
      suiviTechnicien: this.suiviTechnicien,
      commentClient: this.commentClient,
      itemState: this.itemState,
      satisfactionClient: this.satisfactionClient,
      itemPictures: this
          ._itemPictures, //intervention débuter/ position et ticket résolu position
      ticketPositions: this._positions,
      itemId: itemId,
      solveDate: this
          ._positions
          .last
          .datePrise, // date à laquelle il clique sur le boutton résolu
    );

    try {
      final response = await http
          .post(Uri.parse('$API_URL_WALIX/solveTicket'),
              headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json ; charset=UTF-8',
                'Authorization': 'Bearer $token',
              },
              body: jsonEncode(ticketResponse))
          .timeout(
            const Duration(seconds: 120),
          );
      if (response.statusCode == 200) {
        resetTicketResponse();
        dao.deleteTicket(ticket.id);
        //Provider.of<Tickets>(context, listen: false).removeTickets(ticket.id);
        result = "Done";
      } else if (response.statusCode == 422) {
        resetTicketResponse();
        result = "ticket résolu";
      } else if (response.statusCode == 500) {
        final Map<String, dynamic> data = json.decode(response.body);
        print(data['message']);
        resetTicketResponse();
        result = "Server error";
      }
    } on TimeoutException catch (_) {
      result = "Error";
    } catch (error) {
      _positions.removeAt(0);
      result = "Error";
    }
    return result;
  }
}
