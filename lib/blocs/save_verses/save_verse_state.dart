part of 'save_verse_bloc.dart';

class SaveVerseState extends Equatable {
  final SaveVerseStatus? verseStatus;
  final List<Passage>? verses;
  final Failure? failure;
  const SaveVerseState({this.verseStatus,this.verses,this.failure});
  factory SaveVerseState.initial() {
    return SaveVerseState(verseStatus: SaveVerseStatus.initial,verses: [],failure: Failure(message: ''));
  }
  SaveVerseState copyWith({SaveVerseStatus? verseStatus, List<Passage>? verses,Failure? failure}){
    return SaveVerseState(verseStatus: verseStatus ?? this.verseStatus,verses: verses ?? this.verses,failure: failure ?? this.failure);
  }
  @override
  List<Object?> get props => [verseStatus,verses,failure];
}

enum SaveVerseStatus { initial, loading, loaded, error }
