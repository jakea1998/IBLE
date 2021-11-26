part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  

  @override
  List<Object> get props => [];
}
class CategoriesEventInitCategories extends CategoriesEvent{}
class CategoriesEventLoadCategories extends CategoriesEvent{}
class CategoriesEventUpdateCategories extends CategoriesEvent{}
class CategoriesEventSaveCategories extends CategoriesEvent{}