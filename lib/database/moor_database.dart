import 'package:moor_flutter/moor_flutter.dart';
part 'moor_database.g.dart';

class LocalTickets extends Table {
  IntColumn get id => integer().nullable()();
  TextColumn get demandeur => text().nullable()();
  IntColumn get demandeurId => integer().nullable()();
  IntColumn get itemId => integer().nullable()();
  TextColumn get itemNumber => text().nullable()();
  TextColumn get titre => text().nullable()();
  TextColumn get categorie => text().nullable()();
  IntColumn get categorieId => integer().nullable()();
  TextColumn get technicien => text().nullable()();
  DateTimeColumn get dateCreation => dateTime().nullable()();
  DateTimeColumn get dateDebut => dateTime().nullable()();
  DateTimeColumn get dateFin => dateTime().nullable()();
  TextColumn get sla => text().nullable()();
  TextColumn get description => text().nullable()();
  IntColumn get type => integer().nullable()();
  TextColumn get observateurs => text().nullable()();
  TextColumn get steps => text().nullable()();
  TextColumn get tasks => text().nullable()();
  IntColumn get procedureId => integer().nullable()();
  TextColumn get contrat => text().nullable()();
  TextColumn get slaStatus => text().nullable()();
  IntColumn get statut => integer().nullable()();
  BoolColumn get isObs => boolean().nullable()();
  BoolColumn get isTech => boolean().nullable()();
  //BoolColumn get started => boolean().nullable()();
  BoolColumn get ticketIsNew => boolean().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Responses extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ticketId => integer().nullable()();
  IntColumn get userId => integer().nullable()();
  IntColumn get procedureId => integer().nullable()();
  DateTimeColumn get dateOuverture => dateTime().nullable()();
  TextColumn get categorie => text().nullable()();
  IntColumn get type => integer().nullable()();
  TextColumn get demandeurName => text().nullable()();
  TextColumn get techName => text().nullable()();
  TextColumn get contractNumber => text().nullable()();
  TextColumn get itemSerialNumber => text().nullable()();
  TextColumn get suiviTechnicien => text().nullable()();
  TextColumn get commentClient => text().nullable()();
  IntColumn get itemState => integer().nullable()();
  IntColumn get itemId => integer().nullable()();
  TextColumn get satisfactionClient => text().nullable()();
  TextColumn get itemPictures => text().nullable()();
  TextColumn get ticketPositions => text().nullable()();
  TextColumn get selectedTask => text().nullable()();
  DateTimeColumn get solveDate => dateTime().nullable()();
}

@UseMoor(tables: [Responses, LocalTickets], daos: [LocalTicketDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;

  /* Future<void> deleteEverything() {
    return transaction(() async {
      // you only need this if you've manually enabled foreign keys
      // await customStatement('PRAGMA foreign_keys = OFF');
      for (final table in allTables) {
        await delete(localTickets).go();
      }
    });
  } */
}

@UseDao(tables: [LocalTickets])
class LocalTicketDao extends DatabaseAccessor<AppDatabase>
    with _$LocalTicketDaoMixin {
  final AppDatabase db;
  LocalTicketDao(this.db) : super(db);

  Future<List<LocalTicket>> getAllTickets() => select(localTickets).get();
  Future<LocalTicket> findById(int id) {
    return (select(localTickets)..where((t) => t.id.equals(id))).getSingle();
  }

  Stream<List<LocalTicket>> watchAllTicketBySla(String sla) {
    return (select(localTickets)
          ..orderBy([
            (t) => OrderingTerm(
                expression: t.dateCreation, mode: OrderingMode.desc)
          ])
          ..where((t) => t.slaStatus.equals(sla)))
        .watch();
  }

  Stream<List<LocalTicket>> watchAllTicketByType(int type) {
    return (select(localTickets)
          ..orderBy([
            (t) => OrderingTerm(
                expression: t.dateCreation, mode: OrderingMode.desc)
          ])
          ..where((t) => t.type.equals(type)))
        .watch();
  }

  Future updateTicketStatus(int id, int statut) {
    return (update(localTickets)..where((t) => t.id.equals(id))).write(
      LocalTicketsCompanion(
        statut: Value(statut),
      ),
    );
  }

  Future updateTicketNew(int id) {
    return (update(localTickets)..where((t) => t.id.equals(id))).write(
      LocalTicketsCompanion(
        ticketIsNew: Value(false),
      ),
    );
  }

  Future deleteTicket(int id) {
    return (delete(localTickets)..where((t) => t.id.equals(id))).go();
  }

  Future inserticket(Insertable<LocalTicket> ticket) =>
      into(localTickets).insert(ticket);
  Future updateTicket(Insertable<LocalTicket> ticket) =>
      update(localTickets).replace(ticket);

  Future feelingLazy() {
    // delete the oldest nine tasks
    return (delete(localTickets)).go();
  }
}
