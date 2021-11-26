part of 'verse_bloc.dart';

class VerseState extends Equatable {
  final VerseStatus? verseStatus;
  final List<Passage>? verses;
  final Failure? failure;
  const VerseState({this.verseStatus,this.verses,this.failure});
  factory VerseState.initial() {
    return VerseState(verseStatus: VerseStatus.initial,verses: [],failure: Failure(message: ''));
  }
  VerseState copyWith({VerseStatus? verseStatus, List<Passage>? verses,Failure? failure}){
    return VerseState(verseStatus: verseStatus ?? this.verseStatus,verses: verses ?? this.verses,failure: failure ?? this.failure);
  }
  @override
  List<Object?> get props => [verseStatus,verses,failure];
}

enum VerseStatus { initial, loading, loaded, error }
