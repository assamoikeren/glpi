import 'dart:io';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:moor_flutter/moor_flutter.dart';

final dateFormat = new DateFormat('yyyy-MM-dd H:m:s');

class TicketResponse {
  int ticketId;
  int userId;
  int procedureId;
  DateTime dateOuverture;
  String categorie;
  int type;
  String demandeurName;
  String techName;
  String contractNumber;
  String itemSerialNumber;
  Comment suiviTechnicien;
  Comment commentClient;
  int itemState;
  int itemId;
  Comment satisfactionClient;
  List<Picture> itemPictures;
  List<Picture> taskPictures;
  List<UserPosition> ticketPositions;
  List<SelectedTask> selectedTask;
  DateTime solveDate;

  TicketResponse(
      {this.userId,
      this.ticketId,
      this.procedureId,
      this.dateOuverture,
      this.categorie,
      this.type,
      this.demandeurName,
      this.techName,
      this.contractNumber,
      this.itemSerialNumber,
      this.suiviTechnicien,
      this.commentClient,
      this.itemState,
      this.satisfactionClient,
      this.itemPictures,
      this.taskPictures,
      this.ticketPositions,
      this.selectedTask,
      this.itemId,
      this.solveDate});

  Map<String, dynamic> toJsonPosition() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticketId'] = this.ticketId;
    data['userId'] = this.userId;
    data['ticketPositions'] =
        this.ticketPositions.map((e) => e.toJson()).toList();
    data['suiviTechnicien'] = this.suiviTechnicien.toJson();
    data['solvedate'] = '${dateFormat.format(this.solveDate.toUtc())}';
    data['itemId'] = this.itemId;
    data['techName'] = '${this.techName}(${this.userId})';
    return data;
  }

  Map<String, dynamic> toJsonstartIncident() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticketId'] = this.ticketId;
    data['userId'] = this.userId;
    data['ticketPositions'] =
        this.ticketPositions.map((e) => e.toJson()).toList();
    data['suiviTechnicien'] = this.suiviTechnicien.toJson();
    data['solvedate'] = '${dateFormat.format(this.solveDate.toUtc())}';
    data['itemId'] = this.itemId;
    data['techName'] = '${this.techName}(${this.userId})';
    return data;
  }

  Map<String, dynamic> toJsonSelectedTask() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['selectedTask'] = this.selectedTask.map((e) => e.toJson()).toList();
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['ticketId'] = this.ticketId;
    data['procedureId'] = this.procedureId;
    data['dateOuverture'] = '${dateFormat.format(this.dateOuverture.toUtc())}';
    data['categorie'] = this.categorie;
    data['type'] = this.type;
    data['demandeurName'] = this.demandeurName;
    data['techName'] = this.techName;
    data['contractNumber'] = this.contractNumber;
    data['itemSerialNumber'] = this.itemSerialNumber;
    data['suiviTechnicien'] = this.suiviTechnicien.toJson();
    if (this.commentClient != null) {
      data['commentClient'] = this.commentClient.toJson();
    }
    if (this.itemState == 0 || this.itemState == 1) {
      data['itemState'] = 0;
    } else {
      data['itemState'] = 1;
    }
    if (this.satisfactionClient != null) {
      data['satisfactionClient'] = this.satisfactionClient.toJson();
    }
    data['itemPictures'] = this.itemPictures.map((e) => e.toJson()).toList();
    data['ticketPositions'] =
        this.ticketPositions.map((e) => e.toJson()).toList();
    data['itemId'] = this.itemId;
    data['solveDate'] = '${dateFormat.format(this.solveDate.toUtc())}';
    return data;
  }
}

class Picture {
  final String name;
  final File image;
  final Uint8List signature;
  final int statut;
  final DateTime datePrise;

  Picture({
    this.name,
    this.statut,
    this.image,
    this.signature,
    this.datePrise,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['statut'] = this.statut;
    if (this.image != null) {
      data['image'] = base64Encode(this.image.readAsBytesSync());
    }
    if (this.signature != null) {
      data['signature'] = base64Encode(this.signature);
    }
    data['datePrise'] = '${dateFormat.format(this.datePrise.toUtc())}';
    return data;
  }
}

class UserPosition {
  final double longitude;
  final double latitude;
  final String description;
  final DateTime datePrise;

  UserPosition({
    this.longitude,
    this.latitude,
    this.description,
    this.datePrise,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['description'] = this.description;
    data['datePrise'] = '${dateFormat.format(this.datePrise.toUtc())}';
    return data;
  }
}

class Comment {
  String text;
  DateTime datePrise;
  int auteur;

  Comment({this.text, this.datePrise, this.auteur});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['datePrise'] = '${dateFormat.format(this.datePrise.toUtc())}';
    if (this.auteur != null) {
      data['auteur'] = this.auteur;
    }
    return data;
  }
}

class SelectedTask {
  int ticketId;
  int stepId;
  int taskId;
  String comment;
  List<Picture> taskPictures;
  DateTime dateFin;

  SelectedTask({
    this.ticketId,
    this.stepId,
    this.taskId,
    this.taskPictures,
    this.comment,
    this.dateFin,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticketId'] = this.ticketId;
    data['stepId'] = this.stepId;
    data['taskId'] = this.taskId;
    if (this.taskPictures.isNotEmpty) {
      data['taskPictures'] = this.taskPictures.map((e) => e.toJson()).toList();
    }
    if (this.comment != null) {
      data['comment'] = this.comment;
    }
    data['dateFin'] = '${dateFormat.format(this.dateFin.toUtc())}';
    return data;
  }
}
