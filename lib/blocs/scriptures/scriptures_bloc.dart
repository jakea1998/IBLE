import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ible/blocs/repos/verse_repo.dart';
import 'package:ible/models/category_model.dart';
import 'package:ible/models/passage_model.dart';

part 'scriptures_event.dart';
part 'scriptures_state.dart';

class ScripturesBloc extends Bloc<ScripturesEvent, ScripturesState> {
  final _repo = VerseRepo();
  StreamSubscription<List<Passage>>? _stream1;
  ScripturesBloc() : super(ScripturesState.initial()) {
    on<ScripturesEventLoadScriptures>((event, emit) {
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
              e.categoryTitle.toString() ==
              state.selectedCategory?.title.toString())
          .toList();
      print(event.scriptures.length);
      emit(state.copyWith(
          status: ScripturesStatus.loaded,
          allScriptures: event.scriptures,
          displayedScriptures: scriptures));
    });
    on<ScripturesEventSelectCategory>((event, emit) {
      // TODO: implement event handler
      emit(state.copyWith(status: ScripturesStatus.loading));
      final scriptures = state.allScriptures
              ?.where((e) =>
                  e.categoryTitle.toString() == event.category.title.toString())
              .toList() ??
          [];
      print(scriptures.length);
      emit(state.copyWith(
          status: ScripturesStatus.loaded,
          selectedCategory: event.category,
          displayedScriptures: scriptures));
    });
  }
}
