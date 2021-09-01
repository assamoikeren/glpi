// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Response extends DataClass implements Insertable<Response> {
  final int id;
  final int ticketId;
  final int userId;
  final int procedureId;
  final DateTime dateOuverture;
  final String categorie;
  final int type;
  final String demandeurName;
  final String techName;
  final String contractNumber;
  final String itemSerialNumber;
  final String suiviTechnicien;
  final String commentClient;
  final int itemState;
  final int itemId;
  final String satisfactionClient;
  final String itemPictures;
  final String ticketPositions;
  final String selectedTask;
  final DateTime solveDate;
  Response(
      {@required this.id,
      this.ticketId,
      this.userId,
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
      this.itemId,
      this.satisfactionClient,
      this.itemPictures,
      this.ticketPositions,
      this.selectedTask,
      this.solveDate});
  factory Response.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final stringType = db.typeSystem.forDartType<String>();
    return Response(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      ticketId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}ticket_id']),
      userId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}user_id']),
      procedureId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}procedure_id']),
      dateOuverture: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}date_ouverture']),
      categorie: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}categorie']),
      type: intType.mapFromDatabaseResponse(data['${effectivePrefix}type']),
      demandeurName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}demandeur_name']),
      techName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}tech_name']),
      contractNumber: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}contract_number']),
      itemSerialNumber: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}item_serial_number']),
      suiviTechnicien: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}suivi_technicien']),
      commentClient: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}comment_client']),
      itemState:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}item_state']),
      itemId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}item_id']),
      satisfactionClient: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}satisfaction_client']),
      itemPictures: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}item_pictures']),
      ticketPositions: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}ticket_positions']),
      selectedTask: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}selected_task']),
      solveDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}solve_date']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || ticketId != null) {
      map['ticket_id'] = Variable<int>(ticketId);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<int>(userId);
    }
    if (!nullToAbsent || procedureId != null) {
      map['procedure_id'] = Variable<int>(procedureId);
    }
    if (!nullToAbsent || dateOuverture != null) {
      map['date_ouverture'] = Variable<DateTime>(dateOuverture);
    }
    if (!nullToAbsent || categorie != null) {
      map['categorie'] = Variable<String>(categorie);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<int>(type);
    }
    if (!nullToAbsent || demandeurName != null) {
      map['demandeur_name'] = Variable<String>(demandeurName);
    }
    if (!nullToAbsent || techName != null) {
      map['tech_name'] = Variable<String>(techName);
    }
    if (!nullToAbsent || contractNumber != null) {
      map['contract_number'] = Variable<String>(contractNumber);
    }
    if (!nullToAbsent || itemSerialNumber != null) {
      map['item_serial_number'] = Variable<String>(itemSerialNumber);
    }
    if (!nullToAbsent || suiviTechnicien != null) {
      map['suivi_technicien'] = Variable<String>(suiviTechnicien);
    }
    if (!nullToAbsent || commentClient != null) {
      map['comment_client'] = Variable<String>(commentClient);
    }
    if (!nullToAbsent || itemState != null) {
      map['item_state'] = Variable<int>(itemState);
    }
    if (!nullToAbsent || itemId != null) {
      map['item_id'] = Variable<int>(itemId);
    }
    if (!nullToAbsent || satisfactionClient != null) {
      map['satisfaction_client'] = Variable<String>(satisfactionClient);
    }
    if (!nullToAbsent || itemPictures != null) {
      map['item_pictures'] = Variable<String>(itemPictures);
    }
    if (!nullToAbsent || ticketPositions != null) {
      map['ticket_positions'] = Variable<String>(ticketPositions);
    }
    if (!nullToAbsent || selectedTask != null) {
      map['selected_task'] = Variable<String>(selectedTask);
    }
    if (!nullToAbsent || solveDate != null) {
      map['solve_date'] = Variable<DateTime>(solveDate);
    }
    return map;
  }

  ResponsesCompanion toCompanion(bool nullToAbsent) {
    return ResponsesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      ticketId: ticketId == null && nullToAbsent
          ? const Value.absent()
          : Value(ticketId),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      procedureId: procedureId == null && nullToAbsent
          ? const Value.absent()
          : Value(procedureId),
      dateOuverture: dateOuverture == null && nullToAbsent
          ? const Value.absent()
          : Value(dateOuverture),
      categorie: categorie == null && nullToAbsent
          ? const Value.absent()
          : Value(categorie),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      demandeurName: demandeurName == null && nullToAbsent
          ? const Value.absent()
          : Value(demandeurName),
      techName: techName == null && nullToAbsent
          ? const Value.absent()
          : Value(techName),
      contractNumber: contractNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(contractNumber),
      itemSerialNumber: itemSerialNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(itemSerialNumber),
      suiviTechnicien: suiviTechnicien == null && nullToAbsent
          ? const Value.absent()
          : Value(suiviTechnicien),
      commentClient: commentClient == null && nullToAbsent
          ? const Value.absent()
          : Value(commentClient),
      itemState: itemState == null && nullToAbsent
          ? const Value.absent()
          : Value(itemState),
      itemId:
          itemId == null && nullToAbsent ? const Value.absent() : Value(itemId),
      satisfactionClient: satisfactionClient == null && nullToAbsent
          ? const Value.absent()
          : Value(satisfactionClient),
      itemPictures: itemPictures == null && nullToAbsent
          ? const Value.absent()
          : Value(itemPictures),
      ticketPositions: ticketPositions == null && nullToAbsent
          ? const Value.absent()
          : Value(ticketPositions),
      selectedTask: selectedTask == null && nullToAbsent
          ? const Value.absent()
          : Value(selectedTask),
      solveDate: solveDate == null && nullToAbsent
          ? const Value.absent()
          : Value(solveDate),
    );
  }

  factory Response.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Response(
      id: serializer.fromJson<int>(json['id']),
      ticketId: serializer.fromJson<int>(json['ticketId']),
      userId: serializer.fromJson<int>(json['userId']),
      procedureId: serializer.fromJson<int>(json['procedureId']),
      dateOuverture: serializer.fromJson<DateTime>(json['dateOuverture']),
      categorie: serializer.fromJson<String>(json['categorie']),
      type: serializer.fromJson<int>(json['type']),
      demandeurName: serializer.fromJson<String>(json['demandeurName']),
      techName: serializer.fromJson<String>(json['techName']),
      contractNumber: serializer.fromJson<String>(json['contractNumber']),
      itemSerialNumber: serializer.fromJson<String>(json['itemSerialNumber']),
      suiviTechnicien: serializer.fromJson<String>(json['suiviTechnicien']),
      commentClient: serializer.fromJson<String>(json['commentClient']),
      itemState: serializer.fromJson<int>(json['itemState']),
      itemId: serializer.fromJson<int>(json['itemId']),
      satisfactionClient:
          serializer.fromJson<String>(json['satisfactionClient']),
      itemPictures: serializer.fromJson<String>(json['itemPictures']),
      ticketPositions: serializer.fromJson<String>(json['ticketPositions']),
      selectedTask: serializer.fromJson<String>(json['selectedTask']),
      solveDate: serializer.fromJson<DateTime>(json['solveDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ticketId': serializer.toJson<int>(ticketId),
      'userId': serializer.toJson<int>(userId),
      'procedureId': serializer.toJson<int>(procedureId),
      'dateOuverture': serializer.toJson<DateTime>(dateOuverture),
      'categorie': serializer.toJson<String>(categorie),
      'type': serializer.toJson<int>(type),
      'demandeurName': serializer.toJson<String>(demandeurName),
      'techName': serializer.toJson<String>(techName),
      'contractNumber': serializer.toJson<String>(contractNumber),
      'itemSerialNumber': serializer.toJson<String>(itemSerialNumber),
      'suiviTechnicien': serializer.toJson<String>(suiviTechnicien),
      'commentClient': serializer.toJson<String>(commentClient),
      'itemState': serializer.toJson<int>(itemState),
      'itemId': serializer.toJson<int>(itemId),
      'satisfactionClient': serializer.toJson<String>(satisfactionClient),
      'itemPictures': serializer.toJson<String>(itemPictures),
      'ticketPositions': serializer.toJson<String>(ticketPositions),
      'selectedTask': serializer.toJson<String>(selectedTask),
      'solveDate': serializer.toJson<DateTime>(solveDate),
    };
  }

  Response copyWith(
          {int id,
          int ticketId,
          int userId,
          int procedureId,
          DateTime dateOuverture,
          String categorie,
          int type,
          String demandeurName,
          String techName,
          String contractNumber,
          String itemSerialNumber,
          String suiviTechnicien,
          String commentClient,
          int itemState,
          int itemId,
          String satisfactionClient,
          String itemPictures,
          String ticketPositions,
          String selectedTask,
          DateTime solveDate}) =>
      Response(
        id: id ?? this.id,
        ticketId: ticketId ?? this.ticketId,
        userId: userId ?? this.userId,
        procedureId: procedureId ?? this.procedureId,
        dateOuverture: dateOuverture ?? this.dateOuverture,
        categorie: categorie ?? this.categorie,
        type: type ?? this.type,
        demandeurName: demandeurName ?? this.demandeurName,
        techName: techName ?? this.techName,
        contractNumber: contractNumber ?? this.contractNumber,
        itemSerialNumber: itemSerialNumber ?? this.itemSerialNumber,
        suiviTechnicien: suiviTechnicien ?? this.suiviTechnicien,
        commentClient: commentClient ?? this.commentClient,
        itemState: itemState ?? this.itemState,
        itemId: itemId ?? this.itemId,
        satisfactionClient: satisfactionClient ?? this.satisfactionClient,
        itemPictures: itemPictures ?? this.itemPictures,
        ticketPositions: ticketPositions ?? this.ticketPositions,
        selectedTask: selectedTask ?? this.selectedTask,
        solveDate: solveDate ?? this.solveDate,
      );
  @override
  String toString() {
    return (StringBuffer('Response(')
          ..write('id: $id, ')
          ..write('ticketId: $ticketId, ')
          ..write('userId: $userId, ')
          ..write('procedureId: $procedureId, ')
          ..write('dateOuverture: $dateOuverture, ')
          ..write('categorie: $categorie, ')
          ..write('type: $type, ')
          ..write('demandeurName: $demandeurName, ')
          ..write('techName: $techName, ')
          ..write('contractNumber: $contractNumber, ')
          ..write('itemSerialNumber: $itemSerialNumber, ')
          ..write('suiviTechnicien: $suiviTechnicien, ')
          ..write('commentClient: $commentClient, ')
          ..write('itemState: $itemState, ')
          ..write('itemId: $itemId, ')
          ..write('satisfactionClient: $satisfactionClient, ')
          ..write('itemPictures: $itemPictures, ')
          ..write('ticketPositions: $ticketPositions, ')
          ..write('selectedTask: $selectedTask, ')
          ..write('solveDate: $solveDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          ticketId.hashCode,
          $mrjc(
              userId.hashCode,
              $mrjc(
                  procedureId.hashCode,
                  $mrjc(
                      dateOuverture.hashCode,
                      $mrjc(
                          categorie.hashCode,
                          $mrjc(
                              type.hashCode,
                              $mrjc(
                                  demandeurName.hashCode,
                                  $mrjc(
                                      techName.hashCode,
                                      $mrjc(
                                          contractNumber.hashCode,
                                          $mrjc(
                                              itemSerialNumber.hashCode,
                                              $mrjc(
                                                  suiviTechnicien.hashCode,
                                                  $mrjc(
                                                      commentClient.hashCode,
                                                      $mrjc(
                                                          itemState.hashCode,
                                                          $mrjc(
                                                              itemId.hashCode,
                                                              $mrjc(
                                                                  satisfactionClient
                                                                      .hashCode,
                                                                  $mrjc(
                                                                      itemPictures
                                                                          .hashCode,
                                                                      $mrjc(
                                                                          ticketPositions
                                                                              .hashCode,
                                                                          $mrjc(
                                                                              selectedTask.hashCode,
                                                                              solveDate.hashCode))))))))))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Response &&
          other.id == this.id &&
          other.ticketId == this.ticketId &&
          other.userId == this.userId &&
          other.procedureId == this.procedureId &&
          other.dateOuverture == this.dateOuverture &&
          other.categorie == this.categorie &&
          other.type == this.type &&
          other.demandeurName == this.demandeurName &&
          other.techName == this.techName &&
          other.contractNumber == this.contractNumber &&
          other.itemSerialNumber == this.itemSerialNumber &&
          other.suiviTechnicien == this.suiviTechnicien &&
          other.commentClient == this.commentClient &&
          other.itemState == this.itemState &&
          other.itemId == this.itemId &&
          other.satisfactionClient == this.satisfactionClient &&
          other.itemPictures == this.itemPictures &&
          other.ticketPositions == this.ticketPositions &&
          other.selectedTask == this.selectedTask &&
          other.solveDate == this.solveDate);
}

class ResponsesCompanion extends UpdateCompanion<Response> {
  final Value<int> id;
  final Value<int> ticketId;
  final Value<int> userId;
  final Value<int> procedureId;
  final Value<DateTime> dateOuverture;
  final Value<String> categorie;
  final Value<int> type;
  final Value<String> demandeurName;
  final Value<String> techName;
  final Value<String> contractNumber;
  final Value<String> itemSerialNumber;
  final Value<String> suiviTechnicien;
  final Value<String> commentClient;
  final Value<int> itemState;
  final Value<int> itemId;
  final Value<String> satisfactionClient;
  final Value<String> itemPictures;
  final Value<String> ticketPositions;
  final Value<String> selectedTask;
  final Value<DateTime> solveDate;
  const ResponsesCompanion({
    this.id = const Value.absent(),
    this.ticketId = const Value.absent(),
    this.userId = const Value.absent(),
    this.procedureId = const Value.absent(),
    this.dateOuverture = const Value.absent(),
    this.categorie = const Value.absent(),
    this.type = const Value.absent(),
    this.demandeurName = const Value.absent(),
    this.techName = const Value.absent(),
    this.contractNumber = const Value.absent(),
    this.itemSerialNumber = const Value.absent(),
    this.suiviTechnicien = const Value.absent(),
    this.commentClient = const Value.absent(),
    this.itemState = const Value.absent(),
    this.itemId = const Value.absent(),
    this.satisfactionClient = const Value.absent(),
    this.itemPictures = const Value.absent(),
    this.ticketPositions = const Value.absent(),
    this.selectedTask = const Value.absent(),
    this.solveDate = const Value.absent(),
  });
  ResponsesCompanion.insert({
    this.id = const Value.absent(),
    this.ticketId = const Value.absent(),
    this.userId = const Value.absent(),
    this.procedureId = const Value.absent(),
    this.dateOuverture = const Value.absent(),
    this.categorie = const Value.absent(),
    this.type = const Value.absent(),
    this.demandeurName = const Value.absent(),
    this.techName = const Value.absent(),
    this.contractNumber = const Value.absent(),
    this.itemSerialNumber = const Value.absent(),
    this.suiviTechnicien = const Value.absent(),
    this.commentClient = const Value.absent(),
    this.itemState = const Value.absent(),
    this.itemId = const Value.absent(),
    this.satisfactionClient = const Value.absent(),
    this.itemPictures = const Value.absent(),
    this.ticketPositions = const Value.absent(),
    this.selectedTask = const Value.absent(),
    this.solveDate = const Value.absent(),
  });
  static Insertable<Response> custom({
    Expression<int> id,
    Expression<int> ticketId,
    Expression<int> userId,
    Expression<int> procedureId,
    Expression<DateTime> dateOuverture,
    Expression<String> categorie,
    Expression<int> type,
    Expression<String> demandeurName,
    Expression<String> techName,
    Expression<String> contractNumber,
    Expression<String> itemSerialNumber,
    Expression<String> suiviTechnicien,
    Expression<String> commentClient,
    Expression<int> itemState,
    Expression<int> itemId,
    Expression<String> satisfactionClient,
    Expression<String> itemPictures,
    Expression<String> ticketPositions,
    Expression<String> selectedTask,
    Expression<DateTime> solveDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ticketId != null) 'ticket_id': ticketId,
      if (userId != null) 'user_id': userId,
      if (procedureId != null) 'procedure_id': procedureId,
      if (dateOuverture != null) 'date_ouverture': dateOuverture,
      if (categorie != null) 'categorie': categorie,
      if (type != null) 'type': type,
      if (demandeurName != null) 'demandeur_name': demandeurName,
      if (techName != null) 'tech_name': techName,
      if (contractNumber != null) 'contract_number': contractNumber,
      if (itemSerialNumber != null) 'item_serial_number': itemSerialNumber,
      if (suiviTechnicien != null) 'suivi_technicien': suiviTechnicien,
      if (commentClient != null) 'comment_client': commentClient,
      if (itemState != null) 'item_state': itemState,
      if (itemId != null) 'item_id': itemId,
      if (satisfactionClient != null) 'satisfaction_client': satisfactionClient,
      if (itemPictures != null) 'item_pictures': itemPictures,
      if (ticketPositions != null) 'ticket_positions': ticketPositions,
      if (selectedTask != null) 'selected_task': selectedTask,
      if (solveDate != null) 'solve_date': solveDate,
    });
  }

  ResponsesCompanion copyWith(
      {Value<int> id,
      Value<int> ticketId,
      Value<int> userId,
      Value<int> procedureId,
      Value<DateTime> dateOuverture,
      Value<String> categorie,
      Value<int> type,
      Value<String> demandeurName,
      Value<String> techName,
      Value<String> contractNumber,
      Value<String> itemSerialNumber,
      Value<String> suiviTechnicien,
      Value<String> commentClient,
      Value<int> itemState,
      Value<int> itemId,
      Value<String> satisfactionClient,
      Value<String> itemPictures,
      Value<String> ticketPositions,
      Value<String> selectedTask,
      Value<DateTime> solveDate}) {
    return ResponsesCompanion(
      id: id ?? this.id,
      ticketId: ticketId ?? this.ticketId,
      userId: userId ?? this.userId,
      procedureId: procedureId ?? this.procedureId,
      dateOuverture: dateOuverture ?? this.dateOuverture,
      categorie: categorie ?? this.categorie,
      type: type ?? this.type,
      demandeurName: demandeurName ?? this.demandeurName,
      techName: techName ?? this.techName,
      contractNumber: contractNumber ?? this.contractNumber,
      itemSerialNumber: itemSerialNumber ?? this.itemSerialNumber,
      suiviTechnicien: suiviTechnicien ?? this.suiviTechnicien,
      commentClient: commentClient ?? this.commentClient,
      itemState: itemState ?? this.itemState,
      itemId: itemId ?? this.itemId,
      satisfactionClient: satisfactionClient ?? this.satisfactionClient,
      itemPictures: itemPictures ?? this.itemPictures,
      ticketPositions: ticketPositions ?? this.ticketPositions,
      selectedTask: selectedTask ?? this.selectedTask,
      solveDate: solveDate ?? this.solveDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ticketId.present) {
      map['ticket_id'] = Variable<int>(ticketId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (procedureId.present) {
      map['procedure_id'] = Variable<int>(procedureId.value);
    }
    if (dateOuverture.present) {
      map['date_ouverture'] = Variable<DateTime>(dateOuverture.value);
    }
    if (categorie.present) {
      map['categorie'] = Variable<String>(categorie.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (demandeurName.present) {
      map['demandeur_name'] = Variable<String>(demandeurName.value);
    }
    if (techName.present) {
      map['tech_name'] = Variable<String>(techName.value);
    }
    if (contractNumber.present) {
      map['contract_number'] = Variable<String>(contractNumber.value);
    }
    if (itemSerialNumber.present) {
      map['item_serial_number'] = Variable<String>(itemSerialNumber.value);
    }
    if (suiviTechnicien.present) {
      map['suivi_technicien'] = Variable<String>(suiviTechnicien.value);
    }
    if (commentClient.present) {
      map['comment_client'] = Variable<String>(commentClient.value);
    }
    if (itemState.present) {
      map['item_state'] = Variable<int>(itemState.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<int>(itemId.value);
    }
    if (satisfactionClient.present) {
      map['satisfaction_client'] = Variable<String>(satisfactionClient.value);
    }
    if (itemPictures.present) {
      map['item_pictures'] = Variable<String>(itemPictures.value);
    }
    if (ticketPositions.present) {
      map['ticket_positions'] = Variable<String>(ticketPositions.value);
    }
    if (selectedTask.present) {
      map['selected_task'] = Variable<String>(selectedTask.value);
    }
    if (solveDate.present) {
      map['solve_date'] = Variable<DateTime>(solveDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ResponsesCompanion(')
          ..write('id: $id, ')
          ..write('ticketId: $ticketId, ')
          ..write('userId: $userId, ')
          ..write('procedureId: $procedureId, ')
          ..write('dateOuverture: $dateOuverture, ')
          ..write('categorie: $categorie, ')
          ..write('type: $type, ')
          ..write('demandeurName: $demandeurName, ')
          ..write('techName: $techName, ')
          ..write('contractNumber: $contractNumber, ')
          ..write('itemSerialNumber: $itemSerialNumber, ')
          ..write('suiviTechnicien: $suiviTechnicien, ')
          ..write('commentClient: $commentClient, ')
          ..write('itemState: $itemState, ')
          ..write('itemId: $itemId, ')
          ..write('satisfactionClient: $satisfactionClient, ')
          ..write('itemPictures: $itemPictures, ')
          ..write('ticketPositions: $ticketPositions, ')
          ..write('selectedTask: $selectedTask, ')
          ..write('solveDate: $solveDate')
          ..write(')'))
        .toString();
  }
}

class $ResponsesTable extends Responses
    with TableInfo<$ResponsesTable, Response> {
  final GeneratedDatabase _db;
  final String _alias;
  $ResponsesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _ticketIdMeta = const VerificationMeta('ticketId');
  GeneratedIntColumn _ticketId;
  @override
  GeneratedIntColumn get ticketId => _ticketId ??= _constructTicketId();
  GeneratedIntColumn _constructTicketId() {
    return GeneratedIntColumn(
      'ticket_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  GeneratedIntColumn _userId;
  @override
  GeneratedIntColumn get userId => _userId ??= _constructUserId();
  GeneratedIntColumn _constructUserId() {
    return GeneratedIntColumn(
      'user_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _procedureIdMeta =
      const VerificationMeta('procedureId');
  GeneratedIntColumn _procedureId;
  @override
  GeneratedIntColumn get procedureId =>
      _procedureId ??= _constructProcedureId();
  GeneratedIntColumn _constructProcedureId() {
    return GeneratedIntColumn(
      'procedure_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _dateOuvertureMeta =
      const VerificationMeta('dateOuverture');
  GeneratedDateTimeColumn _dateOuverture;
  @override
  GeneratedDateTimeColumn get dateOuverture =>
      _dateOuverture ??= _constructDateOuverture();
  GeneratedDateTimeColumn _constructDateOuverture() {
    return GeneratedDateTimeColumn(
      'date_ouverture',
      $tableName,
      true,
    );
  }

  final VerificationMeta _categorieMeta = const VerificationMeta('categorie');
  GeneratedTextColumn _categorie;
  @override
  GeneratedTextColumn get categorie => _categorie ??= _constructCategorie();
  GeneratedTextColumn _constructCategorie() {
    return GeneratedTextColumn(
      'categorie',
      $tableName,
      true,
    );
  }

  final VerificationMeta _typeMeta = const VerificationMeta('type');
  GeneratedIntColumn _type;
  @override
  GeneratedIntColumn get type => _type ??= _constructType();
  GeneratedIntColumn _constructType() {
    return GeneratedIntColumn(
      'type',
      $tableName,
      true,
    );
  }

  final VerificationMeta _demandeurNameMeta =
      const VerificationMeta('demandeurName');
  GeneratedTextColumn _demandeurName;
  @override
  GeneratedTextColumn get demandeurName =>
      _demandeurName ??= _constructDemandeurName();
  GeneratedTextColumn _constructDemandeurName() {
    return GeneratedTextColumn(
      'demandeur_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _techNameMeta = const VerificationMeta('techName');
  GeneratedTextColumn _techName;
  @override
  GeneratedTextColumn get techName => _techName ??= _constructTechName();
  GeneratedTextColumn _constructTechName() {
    return GeneratedTextColumn(
      'tech_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _contractNumberMeta =
      const VerificationMeta('contractNumber');
  GeneratedTextColumn _contractNumber;
  @override
  GeneratedTextColumn get contractNumber =>
      _contractNumber ??= _constructContractNumber();
  GeneratedTextColumn _constructContractNumber() {
    return GeneratedTextColumn(
      'contract_number',
      $tableName,
      true,
    );
  }

  final VerificationMeta _itemSerialNumberMeta =
      const VerificationMeta('itemSerialNumber');
  GeneratedTextColumn _itemSerialNumber;
  @override
  GeneratedTextColumn get itemSerialNumber =>
      _itemSerialNumber ??= _constructItemSerialNumber();
  GeneratedTextColumn _constructItemSerialNumber() {
    return GeneratedTextColumn(
      'item_serial_number',
      $tableName,
      true,
    );
  }

  final VerificationMeta _suiviTechnicienMeta =
      const VerificationMeta('suiviTechnicien');
  GeneratedTextColumn _suiviTechnicien;
  @override
  GeneratedTextColumn get suiviTechnicien =>
      _suiviTechnicien ??= _constructSuiviTechnicien();
  GeneratedTextColumn _constructSuiviTechnicien() {
    return GeneratedTextColumn(
      'suivi_technicien',
      $tableName,
      true,
    );
  }

  final VerificationMeta _commentClientMeta =
      const VerificationMeta('commentClient');
  GeneratedTextColumn _commentClient;
  @override
  GeneratedTextColumn get commentClient =>
      _commentClient ??= _constructCommentClient();
  GeneratedTextColumn _constructCommentClient() {
    return GeneratedTextColumn(
      'comment_client',
      $tableName,
      true,
    );
  }

  final VerificationMeta _itemStateMeta = const VerificationMeta('itemState');
  GeneratedIntColumn _itemState;
  @override
  GeneratedIntColumn get itemState => _itemState ??= _constructItemState();
  GeneratedIntColumn _constructItemState() {
    return GeneratedIntColumn(
      'item_state',
      $tableName,
      true,
    );
  }

  final VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  GeneratedIntColumn _itemId;
  @override
  GeneratedIntColumn get itemId => _itemId ??= _constructItemId();
  GeneratedIntColumn _constructItemId() {
    return GeneratedIntColumn(
      'item_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _satisfactionClientMeta =
      const VerificationMeta('satisfactionClient');
  GeneratedTextColumn _satisfactionClient;
  @override
  GeneratedTextColumn get satisfactionClient =>
      _satisfactionClient ??= _constructSatisfactionClient();
  GeneratedTextColumn _constructSatisfactionClient() {
    return GeneratedTextColumn(
      'satisfaction_client',
      $tableName,
      true,
    );
  }

  final VerificationMeta _itemPicturesMeta =
      const VerificationMeta('itemPictures');
  GeneratedTextColumn _itemPictures;
  @override
  GeneratedTextColumn get itemPictures =>
      _itemPictures ??= _constructItemPictures();
  GeneratedTextColumn _constructItemPictures() {
    return GeneratedTextColumn(
      'item_pictures',
      $tableName,
      true,
    );
  }

  final VerificationMeta _ticketPositionsMeta =
      const VerificationMeta('ticketPositions');
  GeneratedTextColumn _ticketPositions;
  @override
  GeneratedTextColumn get ticketPositions =>
      _ticketPositions ??= _constructTicketPositions();
  GeneratedTextColumn _constructTicketPositions() {
    return GeneratedTextColumn(
      'ticket_positions',
      $tableName,
      true,
    );
  }

  final VerificationMeta _selectedTaskMeta =
      const VerificationMeta('selectedTask');
  GeneratedTextColumn _selectedTask;
  @override
  GeneratedTextColumn get selectedTask =>
      _selectedTask ??= _constructSelectedTask();
  GeneratedTextColumn _constructSelectedTask() {
    return GeneratedTextColumn(
      'selected_task',
      $tableName,
      true,
    );
  }

  final VerificationMeta _solveDateMeta = const VerificationMeta('solveDate');
  GeneratedDateTimeColumn _solveDate;
  @override
  GeneratedDateTimeColumn get solveDate => _solveDate ??= _constructSolveDate();
  GeneratedDateTimeColumn _constructSolveDate() {
    return GeneratedDateTimeColumn(
      'solve_date',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        ticketId,
        userId,
        procedureId,
        dateOuverture,
        categorie,
        type,
        demandeurName,
        techName,
        contractNumber,
        itemSerialNumber,
        suiviTechnicien,
        commentClient,
        itemState,
        itemId,
        satisfactionClient,
        itemPictures,
        ticketPositions,
        selectedTask,
        solveDate
      ];
  @override
  $ResponsesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'responses';
  @override
  final String actualTableName = 'responses';
  @override
  VerificationContext validateIntegrity(Insertable<Response> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('ticket_id')) {
      context.handle(_ticketIdMeta,
          ticketId.isAcceptableOrUnknown(data['ticket_id'], _ticketIdMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id'], _userIdMeta));
    }
    if (data.containsKey('procedure_id')) {
      context.handle(
          _procedureIdMeta,
          procedureId.isAcceptableOrUnknown(
              data['procedure_id'], _procedureIdMeta));
    }
    if (data.containsKey('date_ouverture')) {
      context.handle(
          _dateOuvertureMeta,
          dateOuverture.isAcceptableOrUnknown(
              data['date_ouverture'], _dateOuvertureMeta));
    }
    if (data.containsKey('categorie')) {
      context.handle(_categorieMeta,
          categorie.isAcceptableOrUnknown(data['categorie'], _categorieMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type'], _typeMeta));
    }
    if (data.containsKey('demandeur_name')) {
      context.handle(
          _demandeurNameMeta,
          demandeurName.isAcceptableOrUnknown(
              data['demandeur_name'], _demandeurNameMeta));
    }
    if (data.containsKey('tech_name')) {
      context.handle(_techNameMeta,
          techName.isAcceptableOrUnknown(data['tech_name'], _techNameMeta));
    }
    if (data.containsKey('contract_number')) {
      context.handle(
          _contractNumberMeta,
          contractNumber.isAcceptableOrUnknown(
              data['contract_number'], _contractNumberMeta));
    }
    if (data.containsKey('item_serial_number')) {
      context.handle(
          _itemSerialNumberMeta,
          itemSerialNumber.isAcceptableOrUnknown(
              data['item_serial_number'], _itemSerialNumberMeta));
    }
    if (data.containsKey('suivi_technicien')) {
      context.handle(
          _suiviTechnicienMeta,
          suiviTechnicien.isAcceptableOrUnknown(
              data['suivi_technicien'], _suiviTechnicienMeta));
    }
    if (data.containsKey('comment_client')) {
      context.handle(
          _commentClientMeta,
          commentClient.isAcceptableOrUnknown(
              data['comment_client'], _commentClientMeta));
    }
    if (data.containsKey('item_state')) {
      context.handle(_itemStateMeta,
          itemState.isAcceptableOrUnknown(data['item_state'], _itemStateMeta));
    }
    if (data.containsKey('item_id')) {
      context.handle(_itemIdMeta,
          itemId.isAcceptableOrUnknown(data['item_id'], _itemIdMeta));
    }
    if (data.containsKey('satisfaction_client')) {
      context.handle(
          _satisfactionClientMeta,
          satisfactionClient.isAcceptableOrUnknown(
              data['satisfaction_client'], _satisfactionClientMeta));
    }
    if (data.containsKey('item_pictures')) {
      context.handle(
          _itemPicturesMeta,
          itemPictures.isAcceptableOrUnknown(
              data['item_pictures'], _itemPicturesMeta));
    }
    if (data.containsKey('ticket_positions')) {
      context.handle(
          _ticketPositionsMeta,
          ticketPositions.isAcceptableOrUnknown(
              data['ticket_positions'], _ticketPositionsMeta));
    }
    if (data.containsKey('selected_task')) {
      context.handle(
          _selectedTaskMeta,
          selectedTask.isAcceptableOrUnknown(
              data['selected_task'], _selectedTaskMeta));
    }
    if (data.containsKey('solve_date')) {
      context.handle(_solveDateMeta,
          solveDate.isAcceptableOrUnknown(data['solve_date'], _solveDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Response map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Response.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ResponsesTable createAlias(String alias) {
    return $ResponsesTable(_db, alias);
  }
}

class LocalTicket extends DataClass implements Insertable<LocalTicket> {
  final int id;
  final String demandeur;
  final int demandeurId;
  final int itemId;
  final String itemNumber;
  final String titre;
  final String categorie;
  final int categorieId;
  final String technicien;
  final DateTime dateCreation;
  final DateTime dateDebut;
  final DateTime dateFin;
  final String sla;
  final String description;
  final int type;
  final String observateurs;
  final String steps;
  final String tasks;
  final int procedureId;
  final String contrat;
  final String slaStatus;
  final int statut;
  final bool isObs;
  final bool isTech;
  final bool ticketIsNew;
  LocalTicket(
      {this.id,
      this.demandeur,
      this.demandeurId,
      this.itemId,
      this.itemNumber,
      this.titre,
      this.categorie,
      this.categorieId,
      this.technicien,
      this.dateCreation,
      this.dateDebut,
      this.dateFin,
      this.sla,
      this.description,
      this.type,
      this.observateurs,
      this.steps,
      this.tasks,
      this.procedureId,
      this.contrat,
      this.slaStatus,
      this.statut,
      this.isObs,
      this.isTech,
      this.ticketIsNew});
  factory LocalTicket.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final boolType = db.typeSystem.forDartType<bool>();
    return LocalTicket(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      demandeur: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}demandeur']),
      demandeurId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}demandeur_id']),
      itemId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}item_id']),
      itemNumber: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}item_number']),
      titre:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}titre']),
      categorie: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}categorie']),
      categorieId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}categorie_id']),
      technicien: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}technicien']),
      dateCreation: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}date_creation']),
      dateDebut: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}date_debut']),
      dateFin: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}date_fin']),
      sla: stringType.mapFromDatabaseResponse(data['${effectivePrefix}sla']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      type: intType.mapFromDatabaseResponse(data['${effectivePrefix}type']),
      observateurs: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}observateurs']),
      steps:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}steps']),
      tasks:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}tasks']),
      procedureId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}procedure_id']),
      contrat:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}contrat']),
      slaStatus: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}sla_status']),
      statut: intType.mapFromDatabaseResponse(data['${effectivePrefix}statut']),
      isObs: boolType.mapFromDatabaseResponse(data['${effectivePrefix}is_obs']),
      isTech:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}is_tech']),
      ticketIsNew: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}ticket_is_new']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || demandeur != null) {
      map['demandeur'] = Variable<String>(demandeur);
    }
    if (!nullToAbsent || demandeurId != null) {
      map['demandeur_id'] = Variable<int>(demandeurId);
    }
    if (!nullToAbsent || itemId != null) {
      map['item_id'] = Variable<int>(itemId);
    }
    if (!nullToAbsent || itemNumber != null) {
      map['item_number'] = Variable<String>(itemNumber);
    }
    if (!nullToAbsent || titre != null) {
      map['titre'] = Variable<String>(titre);
    }
    if (!nullToAbsent || categorie != null) {
      map['categorie'] = Variable<String>(categorie);
    }
    if (!nullToAbsent || categorieId != null) {
      map['categorie_id'] = Variable<int>(categorieId);
    }
    if (!nullToAbsent || technicien != null) {
      map['technicien'] = Variable<String>(technicien);
    }
    if (!nullToAbsent || dateCreation != null) {
      map['date_creation'] = Variable<DateTime>(dateCreation);
    }
    if (!nullToAbsent || dateDebut != null) {
      map['date_debut'] = Variable<DateTime>(dateDebut);
    }
    if (!nullToAbsent || dateFin != null) {
      map['date_fin'] = Variable<DateTime>(dateFin);
    }
    if (!nullToAbsent || sla != null) {
      map['sla'] = Variable<String>(sla);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<int>(type);
    }
    if (!nullToAbsent || observateurs != null) {
      map['observateurs'] = Variable<String>(observateurs);
    }
    if (!nullToAbsent || steps != null) {
      map['steps'] = Variable<String>(steps);
    }
    if (!nullToAbsent || tasks != null) {
      map['tasks'] = Variable<String>(tasks);
    }
    if (!nullToAbsent || procedureId != null) {
      map['procedure_id'] = Variable<int>(procedureId);
    }
    if (!nullToAbsent || contrat != null) {
      map['contrat'] = Variable<String>(contrat);
    }
    if (!nullToAbsent || slaStatus != null) {
      map['sla_status'] = Variable<String>(slaStatus);
    }
    if (!nullToAbsent || statut != null) {
      map['statut'] = Variable<int>(statut);
    }
    if (!nullToAbsent || isObs != null) {
      map['is_obs'] = Variable<bool>(isObs);
    }
    if (!nullToAbsent || isTech != null) {
      map['is_tech'] = Variable<bool>(isTech);
    }
    if (!nullToAbsent || ticketIsNew != null) {
      map['ticket_is_new'] = Variable<bool>(ticketIsNew);
    }
    return map;
  }

  LocalTicketsCompanion toCompanion(bool nullToAbsent) {
    return LocalTicketsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      demandeur: demandeur == null && nullToAbsent
          ? const Value.absent()
          : Value(demandeur),
      demandeurId: demandeurId == null && nullToAbsent
          ? const Value.absent()
          : Value(demandeurId),
      itemId:
          itemId == null && nullToAbsent ? const Value.absent() : Value(itemId),
      itemNumber: itemNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(itemNumber),
      titre:
          titre == null && nullToAbsent ? const Value.absent() : Value(titre),
      categorie: categorie == null && nullToAbsent
          ? const Value.absent()
          : Value(categorie),
      categorieId: categorieId == null && nullToAbsent
          ? const Value.absent()
          : Value(categorieId),
      technicien: technicien == null && nullToAbsent
          ? const Value.absent()
          : Value(technicien),
      dateCreation: dateCreation == null && nullToAbsent
          ? const Value.absent()
          : Value(dateCreation),
      dateDebut: dateDebut == null && nullToAbsent
          ? const Value.absent()
          : Value(dateDebut),
      dateFin: dateFin == null && nullToAbsent
          ? const Value.absent()
          : Value(dateFin),
      sla: sla == null && nullToAbsent ? const Value.absent() : Value(sla),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      observateurs: observateurs == null && nullToAbsent
          ? const Value.absent()
          : Value(observateurs),
      steps:
          steps == null && nullToAbsent ? const Value.absent() : Value(steps),
      tasks:
          tasks == null && nullToAbsent ? const Value.absent() : Value(tasks),
      procedureId: procedureId == null && nullToAbsent
          ? const Value.absent()
          : Value(procedureId),
      contrat: contrat == null && nullToAbsent
          ? const Value.absent()
          : Value(contrat),
      slaStatus: slaStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(slaStatus),
      statut:
          statut == null && nullToAbsent ? const Value.absent() : Value(statut),
      isObs:
          isObs == null && nullToAbsent ? const Value.absent() : Value(isObs),
      isTech:
          isTech == null && nullToAbsent ? const Value.absent() : Value(isTech),
      ticketIsNew: ticketIsNew == null && nullToAbsent
          ? const Value.absent()
          : Value(ticketIsNew),
    );
  }

  factory LocalTicket.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return LocalTicket(
      id: serializer.fromJson<int>(json['id']),
      demandeur: serializer.fromJson<String>(json['demandeur']),
      demandeurId: serializer.fromJson<int>(json['demandeurId']),
      itemId: serializer.fromJson<int>(json['itemId']),
      itemNumber: serializer.fromJson<String>(json['itemNumber']),
      titre: serializer.fromJson<String>(json['titre']),
      categorie: serializer.fromJson<String>(json['categorie']),
      categorieId: serializer.fromJson<int>(json['categorieId']),
      technicien: serializer.fromJson<String>(json['technicien']),
      dateCreation: serializer.fromJson<DateTime>(json['dateCreation']),
      dateDebut: serializer.fromJson<DateTime>(json['dateDebut']),
      dateFin: serializer.fromJson<DateTime>(json['dateFin']),
      sla: serializer.fromJson<String>(json['sla']),
      description: serializer.fromJson<String>(json['description']),
      type: serializer.fromJson<int>(json['type']),
      observateurs: serializer.fromJson<String>(json['observateurs']),
      steps: serializer.fromJson<String>(json['steps']),
      tasks: serializer.fromJson<String>(json['tasks']),
      procedureId: serializer.fromJson<int>(json['procedureId']),
      contrat: serializer.fromJson<String>(json['contrat']),
      slaStatus: serializer.fromJson<String>(json['slaStatus']),
      statut: serializer.fromJson<int>(json['statut']),
      isObs: serializer.fromJson<bool>(json['isObs']),
      isTech: serializer.fromJson<bool>(json['isTech']),
      ticketIsNew: serializer.fromJson<bool>(json['ticketIsNew']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'demandeur': serializer.toJson<String>(demandeur),
      'demandeurId': serializer.toJson<int>(demandeurId),
      'itemId': serializer.toJson<int>(itemId),
      'itemNumber': serializer.toJson<String>(itemNumber),
      'titre': serializer.toJson<String>(titre),
      'categorie': serializer.toJson<String>(categorie),
      'categorieId': serializer.toJson<int>(categorieId),
      'technicien': serializer.toJson<String>(technicien),
      'dateCreation': serializer.toJson<DateTime>(dateCreation),
      'dateDebut': serializer.toJson<DateTime>(dateDebut),
      'dateFin': serializer.toJson<DateTime>(dateFin),
      'sla': serializer.toJson<String>(sla),
      'description': serializer.toJson<String>(description),
      'type': serializer.toJson<int>(type),
      'observateurs': serializer.toJson<String>(observateurs),
      'steps': serializer.toJson<String>(steps),
      'tasks': serializer.toJson<String>(tasks),
      'procedureId': serializer.toJson<int>(procedureId),
      'contrat': serializer.toJson<String>(contrat),
      'slaStatus': serializer.toJson<String>(slaStatus),
      'statut': serializer.toJson<int>(statut),
      'isObs': serializer.toJson<bool>(isObs),
      'isTech': serializer.toJson<bool>(isTech),
      'ticketIsNew': serializer.toJson<bool>(ticketIsNew),
    };
  }

  LocalTicket copyWith(
          {int id,
          String demandeur,
          int demandeurId,
          int itemId,
          String itemNumber,
          String titre,
          String categorie,
          int categorieId,
          String technicien,
          DateTime dateCreation,
          DateTime dateDebut,
          DateTime dateFin,
          String sla,
          String description,
          int type,
          String observateurs,
          String steps,
          String tasks,
          int procedureId,
          String contrat,
          String slaStatus,
          int statut,
          bool isObs,
          bool isTech,
          bool ticketIsNew}) =>
      LocalTicket(
        id: id ?? this.id,
        demandeur: demandeur ?? this.demandeur,
        demandeurId: demandeurId ?? this.demandeurId,
        itemId: itemId ?? this.itemId,
        itemNumber: itemNumber ?? this.itemNumber,
        titre: titre ?? this.titre,
        categorie: categorie ?? this.categorie,
        categorieId: categorieId ?? this.categorieId,
        technicien: technicien ?? this.technicien,
        dateCreation: dateCreation ?? this.dateCreation,
        dateDebut: dateDebut ?? this.dateDebut,
        dateFin: dateFin ?? this.dateFin,
        sla: sla ?? this.sla,
        description: description ?? this.description,
        type: type ?? this.type,
        observateurs: observateurs ?? this.observateurs,
        steps: steps ?? this.steps,
        tasks: tasks ?? this.tasks,
        procedureId: procedureId ?? this.procedureId,
        contrat: contrat ?? this.contrat,
        slaStatus: slaStatus ?? this.slaStatus,
        statut: statut ?? this.statut,
        isObs: isObs ?? this.isObs,
        isTech: isTech ?? this.isTech,
        ticketIsNew: ticketIsNew ?? this.ticketIsNew,
      );
  @override
  String toString() {
    return (StringBuffer('LocalTicket(')
          ..write('id: $id, ')
          ..write('demandeur: $demandeur, ')
          ..write('demandeurId: $demandeurId, ')
          ..write('itemId: $itemId, ')
          ..write('itemNumber: $itemNumber, ')
          ..write('titre: $titre, ')
          ..write('categorie: $categorie, ')
          ..write('categorieId: $categorieId, ')
          ..write('technicien: $technicien, ')
          ..write('dateCreation: $dateCreation, ')
          ..write('dateDebut: $dateDebut, ')
          ..write('dateFin: $dateFin, ')
          ..write('sla: $sla, ')
          ..write('description: $description, ')
          ..write('type: $type, ')
          ..write('observateurs: $observateurs, ')
          ..write('steps: $steps, ')
          ..write('tasks: $tasks, ')
          ..write('procedureId: $procedureId, ')
          ..write('contrat: $contrat, ')
          ..write('slaStatus: $slaStatus, ')
          ..write('statut: $statut, ')
          ..write('isObs: $isObs, ')
          ..write('isTech: $isTech, ')
          ..write('ticketIsNew: $ticketIsNew')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          demandeur.hashCode,
          $mrjc(
              demandeurId.hashCode,
              $mrjc(
                  itemId.hashCode,
                  $mrjc(
                      itemNumber.hashCode,
                      $mrjc(
                          titre.hashCode,
                          $mrjc(
                              categorie.hashCode,
                              $mrjc(
                                  categorieId.hashCode,
                                  $mrjc(
                                      technicien.hashCode,
                                      $mrjc(
                                          dateCreation.hashCode,
                                          $mrjc(
                                              dateDebut.hashCode,
                                              $mrjc(
                                                  dateFin.hashCode,
                                                  $mrjc(
                                                      sla.hashCode,
                                                      $mrjc(
                                                          description.hashCode,
                                                          $mrjc(
                                                              type.hashCode,
                                                              $mrjc(
                                                                  observateurs
                                                                      .hashCode,
                                                                  $mrjc(
                                                                      steps
                                                                          .hashCode,
                                                                      $mrjc(
                                                                          tasks
                                                                              .hashCode,
                                                                          $mrjc(
                                                                              procedureId.hashCode,
                                                                              $mrjc(contrat.hashCode, $mrjc(slaStatus.hashCode, $mrjc(statut.hashCode, $mrjc(isObs.hashCode, $mrjc(isTech.hashCode, ticketIsNew.hashCode)))))))))))))))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is LocalTicket &&
          other.id == this.id &&
          other.demandeur == this.demandeur &&
          other.demandeurId == this.demandeurId &&
          other.itemId == this.itemId &&
          other.itemNumber == this.itemNumber &&
          other.titre == this.titre &&
          other.categorie == this.categorie &&
          other.categorieId == this.categorieId &&
          other.technicien == this.technicien &&
          other.dateCreation == this.dateCreation &&
          other.dateDebut == this.dateDebut &&
          other.dateFin == this.dateFin &&
          other.sla == this.sla &&
          other.description == this.description &&
          other.type == this.type &&
          other.observateurs == this.observateurs &&
          other.steps == this.steps &&
          other.tasks == this.tasks &&
          other.procedureId == this.procedureId &&
          other.contrat == this.contrat &&
          other.slaStatus == this.slaStatus &&
          other.statut == this.statut &&
          other.isObs == this.isObs &&
          other.isTech == this.isTech &&
          other.ticketIsNew == this.ticketIsNew);
}

class LocalTicketsCompanion extends UpdateCompanion<LocalTicket> {
  final Value<int> id;
  final Value<String> demandeur;
  final Value<int> demandeurId;
  final Value<int> itemId;
  final Value<String> itemNumber;
  final Value<String> titre;
  final Value<String> categorie;
  final Value<int> categorieId;
  final Value<String> technicien;
  final Value<DateTime> dateCreation;
  final Value<DateTime> dateDebut;
  final Value<DateTime> dateFin;
  final Value<String> sla;
  final Value<String> description;
  final Value<int> type;
  final Value<String> observateurs;
  final Value<String> steps;
  final Value<String> tasks;
  final Value<int> procedureId;
  final Value<String> contrat;
  final Value<String> slaStatus;
  final Value<int> statut;
  final Value<bool> isObs;
  final Value<bool> isTech;
  final Value<bool> ticketIsNew;
  const LocalTicketsCompanion({
    this.id = const Value.absent(),
    this.demandeur = const Value.absent(),
    this.demandeurId = const Value.absent(),
    this.itemId = const Value.absent(),
    this.itemNumber = const Value.absent(),
    this.titre = const Value.absent(),
    this.categorie = const Value.absent(),
    this.categorieId = const Value.absent(),
    this.technicien = const Value.absent(),
    this.dateCreation = const Value.absent(),
    this.dateDebut = const Value.absent(),
    this.dateFin = const Value.absent(),
    this.sla = const Value.absent(),
    this.description = const Value.absent(),
    this.type = const Value.absent(),
    this.observateurs = const Value.absent(),
    this.steps = const Value.absent(),
    this.tasks = const Value.absent(),
    this.procedureId = const Value.absent(),
    this.contrat = const Value.absent(),
    this.slaStatus = const Value.absent(),
    this.statut = const Value.absent(),
    this.isObs = const Value.absent(),
    this.isTech = const Value.absent(),
    this.ticketIsNew = const Value.absent(),
  });
  LocalTicketsCompanion.insert({
    this.id = const Value.absent(),
    this.demandeur = const Value.absent(),
    this.demandeurId = const Value.absent(),
    this.itemId = const Value.absent(),
    this.itemNumber = const Value.absent(),
    this.titre = const Value.absent(),
    this.categorie = const Value.absent(),
    this.categorieId = const Value.absent(),
    this.technicien = const Value.absent(),
    this.dateCreation = const Value.absent(),
    this.dateDebut = const Value.absent(),
    this.dateFin = const Value.absent(),
    this.sla = const Value.absent(),
    this.description = const Value.absent(),
    this.type = const Value.absent(),
    this.observateurs = const Value.absent(),
    this.steps = const Value.absent(),
    this.tasks = const Value.absent(),
    this.procedureId = const Value.absent(),
    this.contrat = const Value.absent(),
    this.slaStatus = const Value.absent(),
    this.statut = const Value.absent(),
    this.isObs = const Value.absent(),
    this.isTech = const Value.absent(),
    this.ticketIsNew = const Value.absent(),
  });
  static Insertable<LocalTicket> custom({
    Expression<int> id,
    Expression<String> demandeur,
    Expression<int> demandeurId,
    Expression<int> itemId,
    Expression<String> itemNumber,
    Expression<String> titre,
    Expression<String> categorie,
    Expression<int> categorieId,
    Expression<String> technicien,
    Expression<DateTime> dateCreation,
    Expression<DateTime> dateDebut,
    Expression<DateTime> dateFin,
    Expression<String> sla,
    Expression<String> description,
    Expression<int> type,
    Expression<String> observateurs,
    Expression<String> steps,
    Expression<String> tasks,
    Expression<int> procedureId,
    Expression<String> contrat,
    Expression<String> slaStatus,
    Expression<int> statut,
    Expression<bool> isObs,
    Expression<bool> isTech,
    Expression<bool> ticketIsNew,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (demandeur != null) 'demandeur': demandeur,
      if (demandeurId != null) 'demandeur_id': demandeurId,
      if (itemId != null) 'item_id': itemId,
      if (itemNumber != null) 'item_number': itemNumber,
      if (titre != null) 'titre': titre,
      if (categorie != null) 'categorie': categorie,
      if (categorieId != null) 'categorie_id': categorieId,
      if (technicien != null) 'technicien': technicien,
      if (dateCreation != null) 'date_creation': dateCreation,
      if (dateDebut != null) 'date_debut': dateDebut,
      if (dateFin != null) 'date_fin': dateFin,
      if (sla != null) 'sla': sla,
      if (description != null) 'description': description,
      if (type != null) 'type': type,
      if (observateurs != null) 'observateurs': observateurs,
      if (steps != null) 'steps': steps,
      if (tasks != null) 'tasks': tasks,
      if (procedureId != null) 'procedure_id': procedureId,
      if (contrat != null) 'contrat': contrat,
      if (slaStatus != null) 'sla_status': slaStatus,
      if (statut != null) 'statut': statut,
      if (isObs != null) 'is_obs': isObs,
      if (isTech != null) 'is_tech': isTech,
      if (ticketIsNew != null) 'ticket_is_new': ticketIsNew,
    });
  }

  LocalTicketsCompanion copyWith(
      {Value<int> id,
      Value<String> demandeur,
      Value<int> demandeurId,
      Value<int> itemId,
      Value<String> itemNumber,
      Value<String> titre,
      Value<String> categorie,
      Value<int> categorieId,
      Value<String> technicien,
      Value<DateTime> dateCreation,
      Value<DateTime> dateDebut,
      Value<DateTime> dateFin,
      Value<String> sla,
      Value<String> description,
      Value<int> type,
      Value<String> observateurs,
      Value<String> steps,
      Value<String> tasks,
      Value<int> procedureId,
      Value<String> contrat,
      Value<String> slaStatus,
      Value<int> statut,
      Value<bool> isObs,
      Value<bool> isTech,
      Value<bool> ticketIsNew}) {
    return LocalTicketsCompanion(
      id: id ?? this.id,
      demandeur: demandeur ?? this.demandeur,
      demandeurId: demandeurId ?? this.demandeurId,
      itemId: itemId ?? this.itemId,
      itemNumber: itemNumber ?? this.itemNumber,
      titre: titre ?? this.titre,
      categorie: categorie ?? this.categorie,
      categorieId: categorieId ?? this.categorieId,
      technicien: technicien ?? this.technicien,
      dateCreation: dateCreation ?? this.dateCreation,
      dateDebut: dateDebut ?? this.dateDebut,
      dateFin: dateFin ?? this.dateFin,
      sla: sla ?? this.sla,
      description: description ?? this.description,
      type: type ?? this.type,
      observateurs: observateurs ?? this.observateurs,
      steps: steps ?? this.steps,
      tasks: tasks ?? this.tasks,
      procedureId: procedureId ?? this.procedureId,
      contrat: contrat ?? this.contrat,
      slaStatus: slaStatus ?? this.slaStatus,
      statut: statut ?? this.statut,
      isObs: isObs ?? this.isObs,
      isTech: isTech ?? this.isTech,
      ticketIsNew: ticketIsNew ?? this.ticketIsNew,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (demandeur.present) {
      map['demandeur'] = Variable<String>(demandeur.value);
    }
    if (demandeurId.present) {
      map['demandeur_id'] = Variable<int>(demandeurId.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<int>(itemId.value);
    }
    if (itemNumber.present) {
      map['item_number'] = Variable<String>(itemNumber.value);
    }
    if (titre.present) {
      map['titre'] = Variable<String>(titre.value);
    }
    if (categorie.present) {
      map['categorie'] = Variable<String>(categorie.value);
    }
    if (categorieId.present) {
      map['categorie_id'] = Variable<int>(categorieId.value);
    }
    if (technicien.present) {
      map['technicien'] = Variable<String>(technicien.value);
    }
    if (dateCreation.present) {
      map['date_creation'] = Variable<DateTime>(dateCreation.value);
    }
    if (dateDebut.present) {
      map['date_debut'] = Variable<DateTime>(dateDebut.value);
    }
    if (dateFin.present) {
      map['date_fin'] = Variable<DateTime>(dateFin.value);
    }
    if (sla.present) {
      map['sla'] = Variable<String>(sla.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (observateurs.present) {
      map['observateurs'] = Variable<String>(observateurs.value);
    }
    if (steps.present) {
      map['steps'] = Variable<String>(steps.value);
    }
    if (tasks.present) {
      map['tasks'] = Variable<String>(tasks.value);
    }
    if (procedureId.present) {
      map['procedure_id'] = Variable<int>(procedureId.value);
    }
    if (contrat.present) {
      map['contrat'] = Variable<String>(contrat.value);
    }
    if (slaStatus.present) {
      map['sla_status'] = Variable<String>(slaStatus.value);
    }
    if (statut.present) {
      map['statut'] = Variable<int>(statut.value);
    }
    if (isObs.present) {
      map['is_obs'] = Variable<bool>(isObs.value);
    }
    if (isTech.present) {
      map['is_tech'] = Variable<bool>(isTech.value);
    }
    if (ticketIsNew.present) {
      map['ticket_is_new'] = Variable<bool>(ticketIsNew.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalTicketsCompanion(')
          ..write('id: $id, ')
          ..write('demandeur: $demandeur, ')
          ..write('demandeurId: $demandeurId, ')
          ..write('itemId: $itemId, ')
          ..write('itemNumber: $itemNumber, ')
          ..write('titre: $titre, ')
          ..write('categorie: $categorie, ')
          ..write('categorieId: $categorieId, ')
          ..write('technicien: $technicien, ')
          ..write('dateCreation: $dateCreation, ')
          ..write('dateDebut: $dateDebut, ')
          ..write('dateFin: $dateFin, ')
          ..write('sla: $sla, ')
          ..write('description: $description, ')
          ..write('type: $type, ')
          ..write('observateurs: $observateurs, ')
          ..write('steps: $steps, ')
          ..write('tasks: $tasks, ')
          ..write('procedureId: $procedureId, ')
          ..write('contrat: $contrat, ')
          ..write('slaStatus: $slaStatus, ')
          ..write('statut: $statut, ')
          ..write('isObs: $isObs, ')
          ..write('isTech: $isTech, ')
          ..write('ticketIsNew: $ticketIsNew')
          ..write(')'))
        .toString();
  }
}

class $LocalTicketsTable extends LocalTickets
    with TableInfo<$LocalTicketsTable, LocalTicket> {
  final GeneratedDatabase _db;
  final String _alias;
  $LocalTicketsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn(
      'id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _demandeurMeta = const VerificationMeta('demandeur');
  GeneratedTextColumn _demandeur;
  @override
  GeneratedTextColumn get demandeur => _demandeur ??= _constructDemandeur();
  GeneratedTextColumn _constructDemandeur() {
    return GeneratedTextColumn(
      'demandeur',
      $tableName,
      true,
    );
  }

  final VerificationMeta _demandeurIdMeta =
      const VerificationMeta('demandeurId');
  GeneratedIntColumn _demandeurId;
  @override
  GeneratedIntColumn get demandeurId =>
      _demandeurId ??= _constructDemandeurId();
  GeneratedIntColumn _constructDemandeurId() {
    return GeneratedIntColumn(
      'demandeur_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  GeneratedIntColumn _itemId;
  @override
  GeneratedIntColumn get itemId => _itemId ??= _constructItemId();
  GeneratedIntColumn _constructItemId() {
    return GeneratedIntColumn(
      'item_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _itemNumberMeta = const VerificationMeta('itemNumber');
  GeneratedTextColumn _itemNumber;
  @override
  GeneratedTextColumn get itemNumber => _itemNumber ??= _constructItemNumber();
  GeneratedTextColumn _constructItemNumber() {
    return GeneratedTextColumn(
      'item_number',
      $tableName,
      true,
    );
  }

  final VerificationMeta _titreMeta = const VerificationMeta('titre');
  GeneratedTextColumn _titre;
  @override
  GeneratedTextColumn get titre => _titre ??= _constructTitre();
  GeneratedTextColumn _constructTitre() {
    return GeneratedTextColumn(
      'titre',
      $tableName,
      true,
    );
  }

  final VerificationMeta _categorieMeta = const VerificationMeta('categorie');
  GeneratedTextColumn _categorie;
  @override
  GeneratedTextColumn get categorie => _categorie ??= _constructCategorie();
  GeneratedTextColumn _constructCategorie() {
    return GeneratedTextColumn(
      'categorie',
      $tableName,
      true,
    );
  }

  final VerificationMeta _categorieIdMeta =
      const VerificationMeta('categorieId');
  GeneratedIntColumn _categorieId;
  @override
  GeneratedIntColumn get categorieId =>
      _categorieId ??= _constructCategorieId();
  GeneratedIntColumn _constructCategorieId() {
    return GeneratedIntColumn(
      'categorie_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _technicienMeta = const VerificationMeta('technicien');
  GeneratedTextColumn _technicien;
  @override
  GeneratedTextColumn get technicien => _technicien ??= _constructTechnicien();
  GeneratedTextColumn _constructTechnicien() {
    return GeneratedTextColumn(
      'technicien',
      $tableName,
      true,
    );
  }

  final VerificationMeta _dateCreationMeta =
      const VerificationMeta('dateCreation');
  GeneratedDateTimeColumn _dateCreation;
  @override
  GeneratedDateTimeColumn get dateCreation =>
      _dateCreation ??= _constructDateCreation();
  GeneratedDateTimeColumn _constructDateCreation() {
    return GeneratedDateTimeColumn(
      'date_creation',
      $tableName,
      true,
    );
  }

  final VerificationMeta _dateDebutMeta = const VerificationMeta('dateDebut');
  GeneratedDateTimeColumn _dateDebut;
  @override
  GeneratedDateTimeColumn get dateDebut => _dateDebut ??= _constructDateDebut();
  GeneratedDateTimeColumn _constructDateDebut() {
    return GeneratedDateTimeColumn(
      'date_debut',
      $tableName,
      true,
    );
  }

  final VerificationMeta _dateFinMeta = const VerificationMeta('dateFin');
  GeneratedDateTimeColumn _dateFin;
  @override
  GeneratedDateTimeColumn get dateFin => _dateFin ??= _constructDateFin();
  GeneratedDateTimeColumn _constructDateFin() {
    return GeneratedDateTimeColumn(
      'date_fin',
      $tableName,
      true,
    );
  }

  final VerificationMeta _slaMeta = const VerificationMeta('sla');
  GeneratedTextColumn _sla;
  @override
  GeneratedTextColumn get sla => _sla ??= _constructSla();
  GeneratedTextColumn _constructSla() {
    return GeneratedTextColumn(
      'sla',
      $tableName,
      true,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn(
      'description',
      $tableName,
      true,
    );
  }

  final VerificationMeta _typeMeta = const VerificationMeta('type');
  GeneratedIntColumn _type;
  @override
  GeneratedIntColumn get type => _type ??= _constructType();
  GeneratedIntColumn _constructType() {
    return GeneratedIntColumn(
      'type',
      $tableName,
      true,
    );
  }

  final VerificationMeta _observateursMeta =
      const VerificationMeta('observateurs');
  GeneratedTextColumn _observateurs;
  @override
  GeneratedTextColumn get observateurs =>
      _observateurs ??= _constructObservateurs();
  GeneratedTextColumn _constructObservateurs() {
    return GeneratedTextColumn(
      'observateurs',
      $tableName,
      true,
    );
  }

  final VerificationMeta _stepsMeta = const VerificationMeta('steps');
  GeneratedTextColumn _steps;
  @override
  GeneratedTextColumn get steps => _steps ??= _constructSteps();
  GeneratedTextColumn _constructSteps() {
    return GeneratedTextColumn(
      'steps',
      $tableName,
      true,
    );
  }

  final VerificationMeta _tasksMeta = const VerificationMeta('tasks');
  GeneratedTextColumn _tasks;
  @override
  GeneratedTextColumn get tasks => _tasks ??= _constructTasks();
  GeneratedTextColumn _constructTasks() {
    return GeneratedTextColumn(
      'tasks',
      $tableName,
      true,
    );
  }

  final VerificationMeta _procedureIdMeta =
      const VerificationMeta('procedureId');
  GeneratedIntColumn _procedureId;
  @override
  GeneratedIntColumn get procedureId =>
      _procedureId ??= _constructProcedureId();
  GeneratedIntColumn _constructProcedureId() {
    return GeneratedIntColumn(
      'procedure_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _contratMeta = const VerificationMeta('contrat');
  GeneratedTextColumn _contrat;
  @override
  GeneratedTextColumn get contrat => _contrat ??= _constructContrat();
  GeneratedTextColumn _constructContrat() {
    return GeneratedTextColumn(
      'contrat',
      $tableName,
      true,
    );
  }

  final VerificationMeta _slaStatusMeta = const VerificationMeta('slaStatus');
  GeneratedTextColumn _slaStatus;
  @override
  GeneratedTextColumn get slaStatus => _slaStatus ??= _constructSlaStatus();
  GeneratedTextColumn _constructSlaStatus() {
    return GeneratedTextColumn(
      'sla_status',
      $tableName,
      true,
    );
  }

  final VerificationMeta _statutMeta = const VerificationMeta('statut');
  GeneratedIntColumn _statut;
  @override
  GeneratedIntColumn get statut => _statut ??= _constructStatut();
  GeneratedIntColumn _constructStatut() {
    return GeneratedIntColumn(
      'statut',
      $tableName,
      true,
    );
  }

  final VerificationMeta _isObsMeta = const VerificationMeta('isObs');
  GeneratedBoolColumn _isObs;
  @override
  GeneratedBoolColumn get isObs => _isObs ??= _constructIsObs();
  GeneratedBoolColumn _constructIsObs() {
    return GeneratedBoolColumn(
      'is_obs',
      $tableName,
      true,
    );
  }

  final VerificationMeta _isTechMeta = const VerificationMeta('isTech');
  GeneratedBoolColumn _isTech;
  @override
  GeneratedBoolColumn get isTech => _isTech ??= _constructIsTech();
  GeneratedBoolColumn _constructIsTech() {
    return GeneratedBoolColumn(
      'is_tech',
      $tableName,
      true,
    );
  }

  final VerificationMeta _ticketIsNewMeta =
      const VerificationMeta('ticketIsNew');
  GeneratedBoolColumn _ticketIsNew;
  @override
  GeneratedBoolColumn get ticketIsNew =>
      _ticketIsNew ??= _constructTicketIsNew();
  GeneratedBoolColumn _constructTicketIsNew() {
    return GeneratedBoolColumn(
      'ticket_is_new',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        demandeur,
        demandeurId,
        itemId,
        itemNumber,
        titre,
        categorie,
        categorieId,
        technicien,
        dateCreation,
        dateDebut,
        dateFin,
        sla,
        description,
        type,
        observateurs,
        steps,
        tasks,
        procedureId,
        contrat,
        slaStatus,
        statut,
        isObs,
        isTech,
        ticketIsNew
      ];
  @override
  $LocalTicketsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'local_tickets';
  @override
  final String actualTableName = 'local_tickets';
  @override
  VerificationContext validateIntegrity(Insertable<LocalTicket> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('demandeur')) {
      context.handle(_demandeurMeta,
          demandeur.isAcceptableOrUnknown(data['demandeur'], _demandeurMeta));
    }
    if (data.containsKey('demandeur_id')) {
      context.handle(
          _demandeurIdMeta,
          demandeurId.isAcceptableOrUnknown(
              data['demandeur_id'], _demandeurIdMeta));
    }
    if (data.containsKey('item_id')) {
      context.handle(_itemIdMeta,
          itemId.isAcceptableOrUnknown(data['item_id'], _itemIdMeta));
    }
    if (data.containsKey('item_number')) {
      context.handle(
          _itemNumberMeta,
          itemNumber.isAcceptableOrUnknown(
              data['item_number'], _itemNumberMeta));
    }
    if (data.containsKey('titre')) {
      context.handle(
          _titreMeta, titre.isAcceptableOrUnknown(data['titre'], _titreMeta));
    }
    if (data.containsKey('categorie')) {
      context.handle(_categorieMeta,
          categorie.isAcceptableOrUnknown(data['categorie'], _categorieMeta));
    }
    if (data.containsKey('categorie_id')) {
      context.handle(
          _categorieIdMeta,
          categorieId.isAcceptableOrUnknown(
              data['categorie_id'], _categorieIdMeta));
    }
    if (data.containsKey('technicien')) {
      context.handle(
          _technicienMeta,
          technicien.isAcceptableOrUnknown(
              data['technicien'], _technicienMeta));
    }
    if (data.containsKey('date_creation')) {
      context.handle(
          _dateCreationMeta,
          dateCreation.isAcceptableOrUnknown(
              data['date_creation'], _dateCreationMeta));
    }
    if (data.containsKey('date_debut')) {
      context.handle(_dateDebutMeta,
          dateDebut.isAcceptableOrUnknown(data['date_debut'], _dateDebutMeta));
    }
    if (data.containsKey('date_fin')) {
      context.handle(_dateFinMeta,
          dateFin.isAcceptableOrUnknown(data['date_fin'], _dateFinMeta));
    }
    if (data.containsKey('sla')) {
      context.handle(
          _slaMeta, sla.isAcceptableOrUnknown(data['sla'], _slaMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type'], _typeMeta));
    }
    if (data.containsKey('observateurs')) {
      context.handle(
          _observateursMeta,
          observateurs.isAcceptableOrUnknown(
              data['observateurs'], _observateursMeta));
    }
    if (data.containsKey('steps')) {
      context.handle(
          _stepsMeta, steps.isAcceptableOrUnknown(data['steps'], _stepsMeta));
    }
    if (data.containsKey('tasks')) {
      context.handle(
          _tasksMeta, tasks.isAcceptableOrUnknown(data['tasks'], _tasksMeta));
    }
    if (data.containsKey('procedure_id')) {
      context.handle(
          _procedureIdMeta,
          procedureId.isAcceptableOrUnknown(
              data['procedure_id'], _procedureIdMeta));
    }
    if (data.containsKey('contrat')) {
      context.handle(_contratMeta,
          contrat.isAcceptableOrUnknown(data['contrat'], _contratMeta));
    }
    if (data.containsKey('sla_status')) {
      context.handle(_slaStatusMeta,
          slaStatus.isAcceptableOrUnknown(data['sla_status'], _slaStatusMeta));
    }
    if (data.containsKey('statut')) {
      context.handle(_statutMeta,
          statut.isAcceptableOrUnknown(data['statut'], _statutMeta));
    }
    if (data.containsKey('is_obs')) {
      context.handle(
          _isObsMeta, isObs.isAcceptableOrUnknown(data['is_obs'], _isObsMeta));
    }
    if (data.containsKey('is_tech')) {
      context.handle(_isTechMeta,
          isTech.isAcceptableOrUnknown(data['is_tech'], _isTechMeta));
    }
    if (data.containsKey('ticket_is_new')) {
      context.handle(
          _ticketIsNewMeta,
          ticketIsNew.isAcceptableOrUnknown(
              data['ticket_is_new'], _ticketIsNewMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalTicket map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return LocalTicket.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $LocalTicketsTable createAlias(String alias) {
    return $LocalTicketsTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $ResponsesTable _responses;
  $ResponsesTable get responses => _responses ??= $ResponsesTable(this);
  $LocalTicketsTable _localTickets;
  $LocalTicketsTable get localTickets =>
      _localTickets ??= $LocalTicketsTable(this);
  LocalTicketDao _localTicketDao;
  LocalTicketDao get localTicketDao =>
      _localTicketDao ??= LocalTicketDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [responses, localTickets];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$LocalTicketDaoMixin on DatabaseAccessor<AppDatabase> {
  $LocalTicketsTable get localTickets => attachedDatabase.localTickets;
}
