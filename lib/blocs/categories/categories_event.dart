part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CategoriesEventInitCategories extends CategoriesEvent {}

class CategoriesEventLoadCategories extends CategoriesEvent {}

class CategoriesEventUpdateCategories extends CategoriesEvent {
  final List<Category> categories;
  CategoriesEventUpdateCategories({required this.categories});
  @override
  List<Object> get props => [categories];
}

class CategoriesEventAddCategory extends CategoriesEvent {
  final Category category;
  CategoriesEventAddCategory({required this.category});
  @override
  List<Object> get props => [category];
}
class CategoriesEventSelectCategory extends CategoriesEvent {
  final Category category;
  CategoriesEventSelectCategory({required this.category});
  @override
  List<Object> get props => [category];
}
class CategoriesEventRenameCategory extends CategoriesEvent {
  final Category category;
  CategoriesEventRenameCategory({required this.category});
  @override
  List<Object> get props => [category];
}
class CategoriesEventDeleteCategory extends CategoriesEvent {
  final Category category;
  CategoriesEventDeleteCategory({required this.category});
  @override
  List<Object> get props => [category];
}

class CategoriesEventPinOrUnpinVerse extends CategoriesEvent {
  final bool pinOrUnpin;
  final Passage? verse;
  CategoriesEventPinOrUnpinVerse({required this.pinOrUnpin,this.verse});
  @override
  List<Object?> get props => [pinOrUnpin,verse];
}