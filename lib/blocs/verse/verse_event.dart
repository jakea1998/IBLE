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
  final String? query;
  const VerseEventSearchVerse({this.query});
  @override
  List<Object?> get props => [query];
}

class VerseEventSaveScripture extends VerseEvent {
  final bool isNew;
  final List<Passage> verses;
  const VerseEventSaveScripture({required this.verses,required this.isNew});
  @override
  List<Object?> get props => [verses];
}

class VerseEventUpdateCategory extends VerseEvent {
  final Category? category;
  const VerseEventUpdateCategory({required this.category});
  @override
  List<Object?> get props => [category];
}
