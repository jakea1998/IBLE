import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ible/blocs/repos/verse_repo.dart';
import 'package:ible/blocs/selected_item/selected_item_bloc.dart';
import 'package:ible/models/bible_version.dart';
import 'package:ible/models/category_model.dart';
import 'package:ible/models/passage_model.dart';

part 'scriptures_event.dart';
part 'scriptures_state.dart';

class ScripturesBloc extends Bloc<ScripturesEvent, ScripturesState> {
  final _repo = VerseRepo();
  final _auth = FirebaseAuth.instance;
  final SelectedItemBloc selectedItemBloc;
  StreamSubscription<List<Passage>>? _stream1;
  ScripturesBloc({required this.selectedItemBloc}) : super(ScripturesState.initial()) {
    /* on<ScripturesEventLoadScriptures>((event, emit) {
      // TODO: implement event handler
      final _auth = FirebaseAuth.instance;
      if (_stream1 != null) _stream1?.cancel();
      _stream1 =
          _repo.getVerses(userId: _auth.currentUser?.uid ?? '').listen((event) {
        add(ScripturesEventUpdateScriptures(scriptures: event));
      });
    });
    on<ScripturesEventUpdateScriptures>((event, emit) {
      emit(state.copyWith(status: ScripturesStatus.loading));
      // TODO: implement event handler
      final scriptures = event.scriptures
          .where((e) =>
              e.categoryId.toString() ==
              state.selectedCategory?.id.toString())
          .toList();
      print(event.scriptures.length);
      emit(state.copyWith(
          status: ScripturesStatus.loaded,
          allScriptures: event.scriptures,
          displayedScriptures: scriptures));
    }); */
    /* on<ScripturesEventSelectCategory>((event, emit) {
      // TODO: implement event handler
      emit(state.copyWith(status: ScripturesStatus.loading));
      final scriptures = state.allScriptures
              ?.where((e) =>
                  e.categoryId.toString() == event.category.id.toString())
              .toList() ??
          [];
      print(scriptures.length);
      emit(state.copyWith(
          status: ScripturesStatus.loaded,
          selectedCategory: selectedItemBloc.state.selectedItem as Category,
          displayedScriptures: scriptures));
    }); */
    on<ScripturesEventMoveVerse>((event, emit) async {
      try {
        await _repo.deleteVerse(
            category: event.oldCategory,
            verse: event.verse,
            userId: _auth.currentUser?.uid ?? "");
        await _repo.saveVerses(
            isNew: false,
            category: event.newCategory,
            verses: [event.verse],
            bibleVersion: event.verse.bibleVersion ?? Data.empty(),
            userId: _auth.currentUser?.uid ?? "");
      } catch (e) {
        print(e);
      }
    });
    on<ScripturesEventDeleteVerse>((event, emit) async {
      // TODO: implement event handler
      print('delete11');
      await _repo.deleteVerse(
          category: event.category,
          verse: event.verse,
          userId: _auth.currentUser?.uid ?? "");
    });
  }
}
