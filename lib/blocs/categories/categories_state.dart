part of 'categories_bloc.dart';

enum CategoriesStatus { loading, loaded, error, initial }

class CategoriesState extends Equatable {
  final CategoriesStatus? status;
  final List<Category>? categories;
  const CategoriesState({this.status, this.categories});
  factory CategoriesState.initial() {
    return CategoriesState(categories: [], status: CategoriesStatus.initial);
  }
  CategoriesState copyWith({CategoriesStatus? status,
   List<Category>? categories}) {
    return CategoriesState(
        categories: categories ?? this.categories,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [categories,status];
}
