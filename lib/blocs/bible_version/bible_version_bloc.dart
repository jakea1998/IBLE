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
  BibleVersionBloc() : super(BibleVersionState.initial()) {
    on<BibleVersionEventFetchAllBibleVersions>((event, emit) async {
      emit(state.copyWith(status: BibleVersionStatus.loading));
      try {
        final model = await _bibleRepo.getBibleVersionModelList();
        final model2 = _bibleRepo.getOnlyVersionsByLanguage(
            bibleVersionModel: model, language: "English");
        emit(state.copyWith(status: BibleVersionStatus.loaded, model: model2));
      } on Exception {
        emit(state.copyWith(
            status: BibleVersionStatus.error,
            failure: Failure(
                message: "Sorry, we couldn't load the bible versions.")));
      }
    });
    on<BibleVersionEventSaveBibleVersion>((event, emit) {
    emit( state.copyWith(status: BibleVersionStatus.loading));
    try {
      //final model = await _bibleRepo.get();

      //yield state.copyWith(
      //status: BibleVersionStatus.loaded,
      //savedVersion:  );
    } on Exception {
      emit(state.copyWith(
          status: BibleVersionStatus.error,
          failure:
              Failure(message: "Sorry, we couldn't save the bible version.")));
    }
    });
  }

  
}
