import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ible/blocs/repos/notes_repo.dart';
import 'package:ible/models/note_model.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  StreamSubscription<List<NoteModel>>? _stream;
  NotesRepo _notesRepo = NotesRepo();
  FirebaseAuth _auth = FirebaseAuth.instance;
  NotesBloc() : super(NotesState.initial()) {
    /*  on<NotesEventLoadNotes>((event, emit) {
      emit(state.copyWith(status: NotesStatus.loading, notes: state.notes));
      try {
        final userId = _auth.currentUser?.uid;
        if (_stream != null) _stream = null;
        _stream = _notesRepo.getAllNotes(userId: userId ?? '').listen((event) {
          add(NotesEventUpdateNotes(notes: event));
        });
      } catch (e) {
        emit(state.copyWith(status: NotesStatus.error, notes: state.notes));
      }
    });

    on<NotesEventUpdateNotes>((event, emit) {
      emit(state.copyWith(status: NotesStatus.loading));
      emit(state.copyWith(status: NotesStatus.loaded, notes: event.notes));
    }); */
    on<NotesEventSaveNote>((event, emit) async {
      try {
        await _notesRepo.saveNote(
            note: event.note, userId: _auth.currentUser?.uid ?? "");

        emit(state.copyWith(status: NotesStatus.loaded));
      } catch (e) {
        emit(state.copyWith(status: NotesStatus.error, notes: state.notes));
      }
    });
    on<NotesEventDeleteNote>((event, emit) async {
      try {
        await _notesRepo.deleteNote(
            note: event.note, userId: _auth.currentUser?.uid ?? "");
        emit(state.copyWith(status: NotesStatus.loaded));
      } catch (e) {
        emit(state.copyWith(status: NotesStatus.error, notes: state.notes));
      }
    });
  }
}
