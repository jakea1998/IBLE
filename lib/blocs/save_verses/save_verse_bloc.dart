import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ible/models/failure_model.dart';
import 'package:ible/models/passage_model.dart';
import 'package:ible/models/verse_model.dart';

part 'save_verse_event.dart';
part 'save_verse_state.dart';

class SaveVerseBloc extends Bloc<SaveVerseEvent, SaveVerseState> {
  SaveVerseBloc() : super(SaveVerseState.initial()) {
    on<SaveVerseEventLoadVerses>((event, emit) {
      // TODO: implement event handler
      try {

      } catch (e) {

      }
    });
    on<SaveVerseEventUpdateVerses>((event, emit) {
      // TODO: implement event handler
      try {

      } catch (e) {

      }
    });
    on<SaveVerseEventAddVerse>((event, emit) {
      try {

      } catch (e) {

      }
    });
  }
}
