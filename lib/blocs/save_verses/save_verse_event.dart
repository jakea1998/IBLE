part of 'save_verse_bloc.dart';

abstract class SaveVerseEvent extends Equatable {
  const SaveVerseEvent();

  @override
  List<Object?> get props => [];
}

class SaveVerseEventAddVerse extends SaveVerseEvent {
  final Verse? verse;
  SaveVerseEventAddVerse({required this.verse});
  @override
  List<Object?> get props => [verse];
}

class SaveVerseEventLoadVerses extends SaveVerseEvent {}

class SaveVerseEventUpdateVerses extends SaveVerseEvent {
  final List<Verse>? verses;
  SaveVerseEventUpdateVerses({this.verses});
  @override
  List<Object?> get props => [verses];
}