part of 'notes_bloc.dart';

enum NotesStatus { loading, loaded, error, initial }

class NotesState extends Equatable {
  final NotesStatus? status;
  final List<NoteModel>? notes;
  const NotesState({this.status, this.notes});
  factory NotesState.initial() {
    return NotesState(notes: [], status: NotesStatus.loaded);
  }
  NotesState copyWith({NotesStatus? status,
   List<NoteModel>? notes}) {
    return NotesState(
        notes: notes ?? this.notes,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [notes,status];
}

