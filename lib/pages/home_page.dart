import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubits/favorites_cubit.dart';
import 'package:notes_app/cubits/notes/notes_cubit.dart';
import 'package:notes_app/database/notes_database.dart';
import 'package:notes_app/widgets/note_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Notes App'),
        ),
        body: BlocBuilder<NotesCubit, NotesState>(builder: (context, state) {
          if (state is FetchedNotesState) {
            return _notes(notes: state.notes);
          } else if (state is NoNotesState) {
            return _noNotes();
          } else if (state is FetchingNotesState) {
            return _fetchingNotes();
          } else if (state is ErrorNotesState) {
            return _errorNotes();
          }

          return Container();
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _addNoteDialog(context),
          child: const Icon(Icons.add),
        ),
      );

  Widget _notes({required List<Note> notes}) =>
      BlocBuilder<FavoritesCubit, Set<int>>(
        builder: (context, favorites) => ListView.builder(
          itemBuilder: (context, index) {
            final note = notes[index];
            final favorite = favorites.contains(note.id);

            return NoteWidget(note,
                favorite: favorite,
                onTap: () => favorite
                    ? context.read<FavoritesCubit>().remove(note.id)
                    : context.read<FavoritesCubit>().save(note.id),
                onLongTap: () => _addNoteDialog(context, note: note),
                onDismissed: (_) => context.read<NotesCubit>().remove(note.id));
          },
          itemCount: notes.length,
        ),
      );

  Widget _noNotes() => const Center(child: Text('Nessuna nota'));

  Widget _fetchingNotes() => const Center(child: CircularProgressIndicator());

  Widget _errorNotes() =>
      const Center(child: Text('Errore nel recuperare le note'));

  _addNoteDialog(BuildContext context, {Note? note}) async {
    final cubit = context.read<NotesCubit>();

    final titleController = TextEditingController(text: note?.title);
    final contentController = TextEditingController(text: note?.content);

    final result = await showDialog(
      context: context,
      builder: (_) => AlertDialog(
          title: const Text('Aggiungi nota'),
          content: SingleChildScrollView(
            child: Column(children: [
              TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Titolo',
                    alignLabelWithHint: true,
                  )),
              TextField(
                  controller: contentController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Contenuto',
                    alignLabelWithHint: true,
                  ))
            ]),
          ),
          actions: [
            TextButton(
              child: const Text('Annulla'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(true),
            )
          ]),
    );

    if (result) {
      final title =
          titleController.text.isNotEmpty ? titleController.text : null;
      final content = contentController.text;

      if (content.isNotEmpty) {
        if (note != null) {
          cubit.replace(
            note.id,
            content: content,
            title: title,
          );
        } else {
          cubit.save(content, title: title);
        }
      }
    }
  }
}
