import 'package:drift/drift.dart';

@DataClassName('Note')
class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().nullable()();

  TextColumn get content => text()();

  DateTimeColumn get createdAt => dateTime().named('created_at').withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt => dateTime().named('updated_at').nullable()();
}