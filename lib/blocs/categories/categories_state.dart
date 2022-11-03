part of 'categories_bloc.dart';

enum CategoriesStatus { loading, loaded, error, initial }

class CategoriesState extends Equatable {
  final CategoriesStatus? status;
  final Category? selectedCategory;
  final Category? favoriteCategory;
  final Category? memoryVersesCategory;
  final List<Category>? categories;
  const CategoriesState({this.status, this.selectedCategory,this.favoriteCategory,this.memoryVersesCategory, this.categories});
  factory CategoriesState.initial() {
    return CategoriesState(
        categories: [],
        selectedCategory: Category.favorite(),
        favoriteCategory: Category.favorite(),
        memoryVersesCategory: Category.memory(),
        status: CategoriesStatus.initial);
  }
  CategoriesState copyWith(
      {CategoriesStatus? status,
      Category? selectedCategory,
      Category? favoriteCategory,
      Category? memoryVersesCategory,
      List<Category>? categories}) {
    return CategoriesState(
        categories: categories ?? this.categories,
        favoriteCategory: favoriteCategory ?? this.favoriteCategory,
        memoryVersesCategory: memoryVersesCategory ?? this.memoryVersesCategory,
        selectedCategory: selectedCategory ?? this.selectedCategory,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [categories, favoriteCategory,memoryVersesCategory,selectedCategory, status];
}
