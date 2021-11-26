import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'inbox_event.dart';
part 'inbox_state.dart';

class InboxBloc extends Bloc<InboxEvent, InboxState> {
  InboxBloc() : super(InboxInitial());

  @override
  Stream<InboxState> mapEventToState(
    InboxEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
