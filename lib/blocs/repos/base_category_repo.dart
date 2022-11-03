import 'package:ible/models/category_model.dart';

abstract class BaseCategoryRepo {
  Future<void> initializeCategories({required String userId});
  Future<void> createCategory(
      {required Category category, required String userId});
  Future<void> deleteCategory(
      {required Category category, required String userId});
  Stream<List<Category>> getAllCategories({required String userId});
}
