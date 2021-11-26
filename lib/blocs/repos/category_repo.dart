import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ible/blocs/repos/base_category_repo.dart';
import 'package:ible/blocs/utils/paths.dart';
import 'package:ible/models/category_model.dart';

class CategoryRepo extends BaseCategoryRepo {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  @override
  Future<void> createCategory(
      {required Category category, required String userId}) async {
    // TODO: implement createCategory
    await _firebaseFirestore
        .collection(Paths.categories_collection)
        .doc(userId)
        .collection(Paths.categories_subcollection)
        .doc(category.id.toString())
        .set(category.toJson(), SetOptions(merge: true));
  }

  @override
  Stream<List<Category>> getAllCategories({required String userId}) {
    // TODO: implement getAllCategories
    return _firebaseFirestore
        .collection(Paths.categories_collection)
        .doc(userId)
        .collection(Paths.categories_subcollection)
        .snapshots()
        .map((snap) => snap.docs.map((e) => Category.fromJson(e.data())).toList());
  }

  @override
  Future<void> initializeCategories({required String userId}) async {
    // TODO: implement initializeCategories

    final favdoc = _firebaseFirestore
        .collection(Paths.categories_collection)
        .doc(userId)
        .collection(Paths.categories_subcollection)
        .doc(Category.favorite().catId);
    final memdoc = _firebaseFirestore
        .collection(Paths.categories_collection)
        .doc(userId)
        .collection(Paths.categories_subcollection)
        .doc(Category.memory().catId);
    final batch = _firebaseFirestore.batch();
    batch.set(favdoc, Category.favorite().toJson());
    batch.set(memdoc, Category.memory().toJson());
    await batch.commit();
  }
}
