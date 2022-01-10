import 'package:drift/drift.dart';
import 'package:notes_app/database/models/favorites.dart';
import 'package:notes_app/database/notes_database.dart';

part 'favorites_dao.g.dart';

@DriftAccessor(tables: [Favorites])
class FavoritesDAO extends DatabaseAccessor<NotesDatabase>
    with _$FavoritesDAOMixin {
  FavoritesDAO(NotesDatabase attachedDatabase) : super(attachedDatabase);

  Stream<List<Favorite>> get items => select(favorites).watch();

  Future<bool> remove(int id) async =>
      (await (delete(favorites)..where((t) => t.id.equals(id))).go()) > 0;

  Future<bool> save(int id) async =>
      await (into(favorites).insert(
        FavoritesCompanion(id: Value(id)),
        mode: InsertMode.insertOrReplace,
      )) >
      0;
}
