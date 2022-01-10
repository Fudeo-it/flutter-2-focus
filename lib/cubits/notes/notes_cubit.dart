import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notes_app/database/daos/notes_dao.dart';
import 'package:notes_app/database/notes_database.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  final NotesDAO notesDAO;

  StreamSubscription<List<Note>>? _notesSubscription;

  NotesCubit({required this.notesDAO}) : super(FetchingNotesState()) {
    _notesSubscription = notesDAO.items.listen(
      (notes) =>
          emit(notes.isEmpty ? NoNotesState() : FetchedNotesState(notes)),
      onError: (_) => emit(ErrorNotesState()),
    );
  }

  @override
  Future<void> close() async {
    await _notesSubscription?.cancel();

    return super.close();
  }

  void save(String content, {String? title}) => notesDAO.save(content, title: title);

  void replace(int id, {String? title, required String content}) => notesDAO.replace(
    id,
    title: title,
    content: content,
  );

  void remove(int id) => notesDAO.remove(id);
}
