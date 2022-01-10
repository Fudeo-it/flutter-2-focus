import 'package:drift/drift.dart';
import 'package:notes_app/database/models/notes.dart';
import 'package:notes_app/database/notes_database.dart';

part 'notes_dao.g.dart';

@DriftAccessor(tables: [Notes])
class NotesDAO extends DatabaseAccessor<NotesDatabase> with _$NotesDAOMixin {
  NotesDAO(NotesDatabase attachedDatabase) : super(attachedDatabase);

  Stream<List<Note>> get items => select(notes).watch();

  Future<bool> remove(int id) async =>
      await (delete(notes)..where((t) => t.id.equals(id))).go() > 0;

  Future<Note> save(
    String content, {
    String? title,
  }) async =>
      await into(notes).insertReturning(
        NotesCompanion(
          content: Value(content),
          title: title != null ? Value(title) : const Value.absent(),
        ),
      );

  Future<bool> replace(
    int id, {
    required String content,
    String? title,
  }) async =>
      await (update(notes).replace(
        NotesCompanion(
          id: Value(id),
          content: Value(content),
          title: title != null ? Value(title) : const Value.absent(),
          updatedAt: Value(DateTime.now()),
        ),
      ));
}
