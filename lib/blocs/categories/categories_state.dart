part of 'categories_bloc.dart';

enum CategoriesStatus { loading, loaded, error, initial }

class CategoriesState extends Equatable {
  final CategoriesStatus? status;
  final Category? selectedCategory;
  final Category? favoriteCategory;
  final Category? memoryVersesCategory;
  final List<Category>? categories;
  final List<Category>? categoriesAndSubCategories;
  final List<String>? categoriesAndSubCategoriesTitles;
  final List<String>? subCategoriesTitles;
  const CategoriesState(
      {this.status,
      this.selectedCategory,
      this.favoriteCategory,
      this.categoriesAndSubCategories,
      this.categoriesAndSubCategoriesTitles,
      this.subCategoriesTitles,
      this.memoryVersesCategory,
      this.categories});
  factory CategoriesState.initial() {
    return CategoriesState(
        categories: [],
        categoriesAndSubCategories: [],
        categoriesAndSubCategoriesTitles: [],
        subCategoriesTitles: [],
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
      List<Category>? categoriesAndSubCategories,
      List<String>? categoriesAndSubCategoriesTitles,
      List<String>? subCategoriesTitles,
      List<Category>? categories}) {
    return CategoriesState(
        categories: categories ?? this.categories,
        categoriesAndSubCategories: categoriesAndSubCategories ?? this.categoriesAndSubCategories,
        categoriesAndSubCategoriesTitles: categoriesAndSubCategoriesTitles ?? this.categoriesAndSubCategoriesTitles,
        subCategoriesTitles: subCategoriesTitles ?? this.subCategoriesTitles,
        favoriteCategory: favoriteCategory ?? this.favoriteCategory,
        memoryVersesCategory: memoryVersesCategory ?? this.memoryVersesCategory,
        selectedCategory: selectedCategory ?? this.selectedCategory,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [
        categories,
        categoriesAndSubCategories,
        categoriesAndSubCategoriesTitles,
        subCategoriesTitles,
        favoriteCategory,

        memoryVersesCategory,
        selectedCategory,
        status
      ];
}
