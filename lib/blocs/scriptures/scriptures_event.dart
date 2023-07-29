part of 'scriptures_bloc.dart';

abstract class ScripturesEvent extends Equatable {
  const ScripturesEvent();

  @override
  List<Object> get props => [];
}

class ScripturesEventLoadScriptures extends ScripturesEvent {}

class ScripturesEventUpdateScriptures extends ScripturesEvent {
  final List<Passage> scriptures;
  const ScripturesEventUpdateScriptures({required this.scriptures});

  @override
  List<Object> get props => [scriptures];
}

class ScripturesEventMoveVerse extends ScripturesEvent {
  final Category oldCategory;
  final Passage verse;
  final Category newCategory;
  const ScripturesEventMoveVerse(
      {required this.oldCategory, required this.newCategory, required this.verse});
  @override
  List<Object> get props => [verse,oldCategory,newCategory];
}

/* class ScripturesEventSelectCategory extends ScripturesEvent {
  final Category category;
  const ScripturesEventSelectCategory({required this.category});

  @override
  List<Object> get props => [category];
} */

class ScripturesEventDeleteVerse extends ScripturesEvent {
  final Category category;
  final Passage verse;
  const ScripturesEventDeleteVerse({required this.category,required this.verse});

  @override
  List<Object> get props => [category,verse];
}