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

class ScripturesEventSelectCategory extends ScripturesEvent {
  final Category category;
  const ScripturesEventSelectCategory({required this.category});

  @override
  List<Object> get props => [category];
}
