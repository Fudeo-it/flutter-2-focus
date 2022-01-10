import 'package:drift/drift.dart';

@DataClassName('Favorite')
class Favorites extends Table {
  IntColumn get id => integer()();

  DateTimeColumn get createdAt => dateTime().named('created_at').withDefault(currentDateAndTime)();
}