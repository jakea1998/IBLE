part of 'verse_bloc.dart';

class VerseState extends Equatable {
  final VerseStatus? verseStatus;
  final List<Passage>? verses;
  final Category? selectedCat;
  final Failure? failure;
  const VerseState({this.verseStatus, this.verses, this.failure,this.selectedCat});
  factory VerseState.initial() {
    return VerseState(
        verseStatus: VerseStatus.initial,
        verses: [],
        selectedCat: null,
        failure: Failure(message: ''));
  }
  VerseState copyWith(
      {VerseStatus? verseStatus, List<Passage>? verses, Failure? failure, Category? selectedCat}) {
    return VerseState(
        verseStatus: verseStatus ?? this.verseStatus,
        selectedCat: selectedCat ?? this.selectedCat,
        verses: verses ?? this.verses,
        failure: failure ?? this.failure);
  }

  @override
  List<Object?> get props => [verseStatus,selectedCat, verses, failure];
}

enum VerseStatus { initial, loading, loaded, error, no_matches_error }
