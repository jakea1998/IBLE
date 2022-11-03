part of 'notes_bloc.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

class NotesEventLoadNotes extends NotesEvent {}

class NotesEventUpdateNotes extends NotesEvent {
  final List<NoteModel> notes;
  NotesEventUpdateNotes({required this.notes});
  @override
  List<Object> get props => [notes];
}
class NotesEventSaveNote extends NotesEvent {
  final NoteModel note;
  NotesEventSaveNote({required this.note});
  @override
  List<Object> get props => [note];
}
class NotesEventDeleteNote extends NotesEvent {
  final NoteModel note;
  NotesEventDeleteNote({required this.note});
  @override
  List<Object> get props => [note];
}