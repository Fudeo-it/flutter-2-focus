import 'package:drift/drift.dart';
import 'package:notes_app/database/daos/favorites_dao.dart';
import 'package:notes_app/database/daos/notes_dao.dart';
import 'package:notes_app/database/models/favorites.dart';
import 'package:notes_app/database/models/notes.dart';

part 'notes_database.g.dart';

@DriftDatabase(tables: [
  Notes,
  Favorites
], daos: [
  NotesDAO,
  FavoritesDAO,
],)
class NotesDatabase extends _$NotesDatabase {
  NotesDatabase(QueryExecutor executor) : super(executor);

  @override
  int get schemaVersion => 1;
}