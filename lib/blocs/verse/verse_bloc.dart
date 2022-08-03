import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ible/blocs/repos/verse_repo.dart';
import 'package:ible/models/category_model.dart';
import 'package:ible/models/failure_model.dart';
import 'package:ible/models/passage_model.dart';
import 'package:ible/models/verse_model.dart';

part 'verse_event.dart';
part 'verse_state.dart';

class VerseBloc extends Bloc<VerseEvent, VerseState> {
  VerseRepo _repo = VerseRepo();
  FirebaseAuth _auth = FirebaseAuth.instance;
  VerseBloc() : super(VerseState.initial()) {
    on<VerseEventSearchVerse>((event, emit) async {
      try {
        final verses = await VerseRepo().searchVerses(query: event.query ?? '');

        emit(state.copyWith(verseStatus: VerseStatus.loaded, verses: verses));
      } catch (e) {
        emit(state.copyWith(
            verseStatus: VerseStatus.error,
            failure: Failure(message: "failed to load verses")));
      }
    });
    on<VerseEventDeleteVerse>((event, emit) {
      emit(state.copyWith(
          verseStatus: VerseStatus.loading, verses: state.verses));
      state.verses?.removeWhere(
        (element) {
          return element.id == event.verse?.id;
        },
      );
      emit(state.copyWith(
          verseStatus: VerseStatus.loaded, verses: state.verses));
    });
    on<VerseEventUpdateCategory>((event, emit) {
      emit(state.copyWith(
          verseStatus: VerseStatus.loading, verses: state.verses));
      print(event.category);
      emit(state.copyWith(
        selectedCat: event.category,
        verseStatus: VerseStatus.loaded,
      ));
    });
    on<VerseEventSaveScripture>((event, emit) async {
      emit(state.copyWith(
        verseStatus: VerseStatus.loading,
      ));
      try {
        print(state.selectedCat);
        if (state.selectedCat != null) {
          print('selected');
          await _repo.saveVerses(
              category: state.selectedCat!,
              verses: event.verses,
              isNew: event.isNew,
              userId: _auth.currentUser?.uid ?? "");
          emit(state.copyWith(
            selectedCat: null,
            verses: [],
            verseStatus: VerseStatus.loaded,
          ));
        }
      } catch (e) {
        emit(state.copyWith(
          verseStatus: VerseStatus.error,
        ));
      }
    });
  }
}
