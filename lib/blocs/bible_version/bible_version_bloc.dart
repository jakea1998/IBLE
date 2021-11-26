import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ible/blocs/repos/version_repo.dart';
import 'package:ible/models/bible_version.dart';
import 'package:ible/models/failure_model.dart';
import 'package:meta/meta.dart';
import 'package:ible/models/bible_version.dart' as b;
part 'bible_version_event.dart';
part 'bible_version_state.dart';

class BibleVersionBloc extends Bloc<BibleVersionEvent, BibleVersionState> {
  final _bibleRepo = VersionRepo();
  BibleVersionBloc() : super(BibleVersionState.initial());

  @override
  Stream<BibleVersionState> mapEventToState(
    BibleVersionEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is BibleVersionEventFetchAllBibleVersions) {
      yield* _mapFetchAllVersionsToState(event);
    }
  }

  Stream<BibleVersionState> _mapFetchAllVersionsToState(
      BibleVersionEventFetchAllBibleVersions event) async* {
    yield state.copyWith(status: BibleVersionStatus.loading);
    try {
      final model = await _bibleRepo.getBibleVersionModelList();
      final model2 = _bibleRepo.getOnlyVersionsByLanguage(
          bibleVersionModel: model, language: "English");
      yield state.copyWith(status: BibleVersionStatus.loaded, model: model2);
    } on Exception {
      yield state.copyWith(
          status: BibleVersionStatus.error,
          failure:
              Failure(message: "Sorry, we couldn't load the bible versions."));
    }
  }

  Stream<BibleVersionState> _mapSaveVersionToState(
      BibleVersionEventSaveBibleVersion event) async* {
    yield state.copyWith(status: BibleVersionStatus.loading);
    try {
      //final model = await _bibleRepo.get();

      //yield state.copyWith(
      //status: BibleVersionStatus.loaded,
      //savedVersion:  );
    } on Exception {
      yield state.copyWith(
          status: BibleVersionStatus.error,
          failure:
              Failure(message: "Sorry, we couldn't save the bible version."));
    }
  }
}
