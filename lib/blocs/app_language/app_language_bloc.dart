import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_language_event.dart';
part 'app_language_state.dart';

class AppLanguageBloc extends Bloc<AppLanguageEvent, AppLanguageState> {
  AppLanguageBloc() : super(AppLanguageInitial());

  @override
  Stream<AppLanguageState> mapEventToState(
    AppLanguageEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
