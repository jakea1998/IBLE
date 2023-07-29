import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ible/blocs/repos/version_repo.dart';
import 'package:ible/models/bible_version.dart';
import 'package:ible/models/failure_model.dart';
import 'package:meta/meta.dart';
import 'package:ible/models/bible_version.dart' as b;
part 'bible_version_event.dart';
part 'bible_version_state.dart';

class BibleVersionBloc extends Bloc<BibleVersionEvent, BibleVersionState> {
  final _bibleRepo = VersionRepo();
  StreamSubscription<b.Data>? _stream1;
  FirebaseAuth _auth = FirebaseAuth.instance;
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

    on<BibleVersionEventSaveBibleVersion>((event, emit) async {
      // emit(state.copyWith(status: BibleVersionStatus.loading));
      try {
        //final model = await _bibleRepo.get();
        await _bibleRepo.saveBibleVersion(
            userId: _auth.currentUser?.uid ?? "",
            savedVersion: event.data ?? Data.empty());
        //yield state.copyWith(
        //status: BibleVersionStatus.loaded,
        //savedVersion:  );
      } on Exception {
        emit(state.copyWith(
            status: BibleVersionStatus.error,
            failure: Failure(
                message: "Sorry, we couldn't save the bible version.")));
      }
    });
    on<BibleVersionFetchSavedBibleVersion>((event, emit) async {
      try {
        if (_stream1 != null) _stream1 == null;

        _stream1 = _bibleRepo
            .fetchSavedBibleVersion(userId: _auth.currentUser?.uid ?? "")
            .listen((event) {
          Data bibleData = event;
          if (event.id == null || event.id == "") {
            bibleData = Data.defaultVersion();
          }
         
          add(BibleVersionUpdateBibleVersion(data: bibleData));
        });
      } on Exception catch (e) {
        emit(state.copyWith(
            status: BibleVersionStatus.error,
            failure: Failure(
                message: "Sorry, we couldn't save the bible version.")));
      }
    });
    on<BibleVersionUpdateBibleVersion>((event, emit) {
      emit(state.copyWith(status: BibleVersionStatus.loading));
      emit(state.copyWith(
          status: BibleVersionStatus.loaded, savedVersion: event.data));
    });
  }
}
