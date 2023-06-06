import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ible/blocs/repos/base_category_repo.dart';
import 'package:ible/blocs/utils/paths.dart';
import 'package:ible/models/category_model.dart';

class CategoryRepo extends BaseCategoryRepo {
  FirebaseDatabase _firebaseDb = FirebaseDatabase.instance;
  @override
  Future<void> createCategory(
      {required Category category, required String userId}) async {
    // TODO: implement createCategory
    if (category.parent == "null" || category.parent == null)
      await _firebaseDb
          .reference()
          .child(Paths.categories_collection)
          .child(userId)
          .child(Paths.categories_subcollection)
          .child(category.id.toString())
          .set(category.toJson());
    else
      await _firebaseDb
          .reference()
          .child(Paths.categories_collection)
          .child(userId)
          .child(Paths.categories_subcollection)
          .child(category.parent.toString())
          .child("subCategories")
          .child(category.id.toString())
          .set(
            category.toJson(),
          );
  }

  @override
  Stream<List<Category>> getAllCategories({required String userId}) {
    // TODO: implement getAllCategories
    return _firebaseDb
        .reference()
        .child(Paths.categories_collection)
        .child(userId)
        .child(Paths.categories_subcollection)
        .onValue
        .map((e) {
      List<Category>? categories = [];
    
      if (e.snapshot.value != null) {
        Map<dynamic, dynamic> map = e.snapshot.value as Map<dynamic,dynamic>;
        map.forEach((key, value) {
          categories.add(Category.fromJson(
            value,
            
          ));
        });
      }
      return categories;
    });
  }

  @override
  Future<void> initializeCategories({required String userId}) async {
    // TODO: implement initializeCategories

    await _firebaseDb
        .reference().child(Paths.categories_collection)
        .child(userId)
        .child(Paths.categories_subcollection)
        .child(Category.favorite().id ?? "").set(Category.favorite().toJson());
   await _firebaseDb.reference()
        .child(Paths.categories_collection)
        .child(userId)
        .child(Paths.categories_subcollection)
        .child(Category.memory().id ?? "").set(Category.memory().toJson());
  
    
  }

  @override
  Future<void> deleteCategory(
      {required Category category, required String userId}) async {
    // TODO: implement deleteCategory
/* 
    // delete category
    await _firebaseFirestore
        .collection(Paths.categories_collection)
        .doc(userId)
        .collection(Paths.categories_subcollection)
        .doc(category.id)
        .delete();

    final batch = _firebaseFirestore.batch();
    // if category is a parent
    if (category.parent == null || category.parent == "null") {
      // get reference to any sub categories
      final fs1 = await _firebaseFirestore
          .collection(Paths.categories_collection)
          .doc(userId)
          .collection(Paths.categories_subcollection)
          .where("parent", isEqualTo: category.id)
          .get();
      // get reference to any notes connected to parent category
      final fs4 = await _firebaseFirestore
          .collection(Paths.notes_collection)
          .doc(userId)
          .collection(Paths.notes_subcollection)
          .where("parentId", isEqualTo: category.id)
          .get();
      // get reference to all verses contained in parent category
      final fs5 = await _firebaseFirestore
          .collection(Paths.verses_collection)
          .doc(userId)
          .collection(Paths.verses_subcollection)
          .where("categoryId", isEqualTo: category.id)
          .get();
      // delete all notes in parent category
      fs4.docs.forEach((element) {
        batch.delete(element.reference);
      });
      // delete all verses in parent category
      fs5.docs.forEach((element) {
        batch.delete(element.reference);
      });
      // loop through all sub categories
      fs1.docs.forEach((element) async {
        // get reference to notes under sub category and match it to id
        final fs3 = await _firebaseFirestore
            .collection(Paths.notes_collection)
            .doc(userId)
            .collection(Paths.notes_subcollection)
            .where("subParentId", isEqualTo: element["id"])
            .get();
        // get reference to verses under sub category
        final fs6 = await _firebaseFirestore
            .collection(Paths.verses_collection)
            .doc(userId)
            .collection(Paths.verses_subcollection)
            .where("categoryId", isEqualTo: element['id'])
            .get();
        // delete all notes corresponding to this sub category
        fs3.docs.forEach((element1) {
          batch.delete(element1.reference);
        });
        // delete all verses in sub category
        fs6.docs.forEach((element4) {
          batch.delete(element4.reference);
        });
        // delete all sub categories
        print(element["id"]);
        print(element.id);
        batch.delete(element.reference);
      });
    } else {
      // get reference to any notes connected to sub category
      final fs4 = await _firebaseFirestore
          .collection(Paths.notes_collection)
          .doc(userId)
          .collection(Paths.notes_subcollection)
          .where("subParentId", isEqualTo: category.id)
          .get();
      // get reference to all verses contained in parent category
      final fs5 = await _firebaseFirestore
          .collection(Paths.verses_collection)
          .doc(userId)
          .collection(Paths.verses_subcollection)
          .where("categoryId", isEqualTo: category.id)
          .get();
      // delete all notes in parent category
      fs4.docs.forEach((element) {
        batch.delete(element.reference);
      });
      // delete all verses in parent category
      fs5.docs.forEach((element) {
        batch.delete(element.reference);
      });
    }

    await batch.commit(); */
  }
}
