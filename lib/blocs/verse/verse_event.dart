part of 'verse_bloc.dart';

abstract class VerseEvent extends Equatable {
  const VerseEvent();

  @override
  List<Object?> get props => [];
}

class VerseEventLoadVerses extends VerseEvent {}

class VerseEventUpdateVerses extends VerseEvent {
  final List<Verse>? verses;
  VerseEventUpdateVerses({this.verses});
  @override
  List<Object?> get props => [verses];
}

class VerseEventDeleteVerse extends VerseEvent {
  final Passage? verse;
  VerseEventDeleteVerse({this.verse});
  @override
  List<Object?> get props => [verse];
}

class VerseEventSearchVerse extends VerseEvent {
  final Data bibleVersion;
  final String? query;
  const VerseEventSearchVerse({this.query,required this.bibleVersion});
  @override
  List<Object?> get props => [query];
}

class VerseEventSaveScripture extends VerseEvent {
  final bool isNew;
  final List<Passage> verses;
  final Data bibleVersion;
  const VerseEventSaveScripture(
      {required this.verses, required this.isNew, required this.bibleVersion});
  @override
  List<Object?> get props => [verses];
}

class VerseEventUpdateCategory extends VerseEvent {
  final Category? category;
  const VerseEventUpdateCategory({required this.category});
  @override
  List<Object?> get props => [category];
}
