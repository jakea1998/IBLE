part of 'verse_bloc.dart';

abstract class VerseEvent extends Equatable {
  const VerseEvent();

  @override
  List<Object> get props => [];
}

class VerseEventSearchVerse extends VerseEvent {
  final String? query;
  const VerseEventSearchVerse({this.query});
}
