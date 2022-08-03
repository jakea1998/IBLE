part of 'scriptures_bloc.dart';

enum ScripturesStatus { loading, loaded, initial, error }

class ScripturesState extends Equatable {
  final ScripturesStatus? status;
  final Category? selectedCategory;
  final List<Passage>? allScriptures;
  final List<Passage>? displayedScriptures;
  const ScripturesState(
      {this.status,
      this.selectedCategory,
      this.allScriptures,
      this.displayedScriptures});
  factory ScripturesState.initial() {
    return ScripturesState(
        status: ScripturesStatus.initial,
        selectedCategory: Category(
          id: 2,
          title: 'Favorites',
        ),
        allScriptures: [],
        displayedScriptures: []);
  }
  ScripturesState copyWith(
      {ScripturesStatus? status,
      Category? selectedCategory,
      List<Passage>? allScriptures,
      List<Passage>? displayedScriptures}) {
    return ScripturesState(
        status: status ?? this.status,
        selectedCategory: selectedCategory ?? this.selectedCategory,
        allScriptures: allScriptures ?? this.allScriptures,
        displayedScriptures: displayedScriptures ?? this.displayedScriptures);
  }

  @override
  List<Object?> get props => [status,selectedCategory,allScriptures,displayedScriptures];
}


