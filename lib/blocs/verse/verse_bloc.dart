import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ible/blocs/repos/verse_repo.dart';
import 'package:ible/models/failure_model.dart';
import 'package:ible/models/passage_model.dart';
import 'package:ible/models/verse_model.dart';

part 'verse_event.dart';
part 'verse_state.dart';

class VerseBloc extends Bloc<VerseEvent, VerseState> {
  VerseBloc() : super(VerseState.initial());

  @override
  Stream<VerseState> mapEventToState(
    VerseEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is VerseEventSearchVerse) {
      yield* _mapSearchVerseToState(event);
    }
  }

  Stream<VerseState> _mapSearchVerseToState(
      VerseEventSearchVerse event) async* {
    try {
      final verses = await VerseRepo().searchVerses(query: event.query ?? '');

      yield state.copyWith(verseStatus: VerseStatus.loaded, verses: verses);
    } catch (e) {
      yield state.copyWith(
          verseStatus: VerseStatus.error,
          failure: Failure(message: "failed to load verses"));
    }
  }
}
