part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  @override
  List<Object> get props => [];
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
class CategoriesEventDeleteCategory extends CategoriesEvent {
  final Category category;
  CategoriesEventDeleteCategory({required this.category});
  @override
  List<Object> get props => [category];
}