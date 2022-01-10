part of 'notes_cubit.dart';

abstract class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object> get props => [];
}

class FetchingNotesState extends NotesState {}

class NoNotesState extends NotesState {}

class ErrorNotesState extends NotesState {}

class FetchedNotesState extends NotesState {
  final List<Note> notes;

  const FetchedNotesState(this.notes);

  @override
  List<Object> get props => [notes];
}