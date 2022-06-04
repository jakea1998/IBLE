import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ible/blocs/repos/language_repo.dart';
import 'package:ible/blocs/repos/version_repo.dart';
import 'package:ible/models/failure_model.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageState.initial()) {
    on<LanguageEventFetchLanguages>((event, emit)async {
     emit(state.copyWith(languageStatus: LanguageStatus.loading));
    try {
      final bibleVersions = await VersionRepo().getBibleVersionModelList();
      print(bibleVersions);
      final languages =
          LanguageRepo().getLanguages(bibleVersionModel: bibleVersions);
      print(languages);
      final languagesList = languages.toList();
      languagesList.sort((a, b) => a.compareTo(b));
      emit(state.copyWith(
          languageStatus: LanguageStatus.loaded, languagesList: languagesList));
    } catch (e) {
      emit(state.copyWith(
          languageStatus: LanguageStatus.error,
          failure: Failure(message: 'Failed to load languages.')));
    }
    });
  }

 
}
