
import 'package:firebase_database/firebase_database.dart';
import 'package:ible/blocs/repos/base_notes_repo.dart';
import 'package:ible/blocs/utils/paths.dart';
import 'package:ible/models/note_model.dart';

class NotesRepo extends BaseNotesRepo {
  
  FirebaseDatabase _firebaseDb = FirebaseDatabase.instance;
  @override
  Future<void> saveNote(
      {required NoteModel note, required String userId}) async {
    // TODO: implement createCategory
    if (note.subParentId == "null" || note.subParentId == null)
      await _firebaseDb
          .reference()
          .child(Paths.categories_collection)
          .child(userId)
          .child(Paths.categories_subcollection)
          .child(note.parentId ?? "")
          .child(Paths.notes_collection)
          .child(note.id ?? "")
          .set(note.toJson());
    else
      await _firebaseDb
          .reference()
          .child(Paths.categories_collection)
          .child(userId)
          .child(Paths.categories_subcollection)
          .child(note.parentId ?? "")
          .child(Paths.sub_categories_collection)
          .child(note.subParentId ?? "")
          .child(Paths.notes_collection)
          .child(note.id ?? "")
          .set(note.toJson());
  }

  /*  @override
  Stream<List<NoteModel>> getAllNotes({required String userId}) {
    // TODO: implement getAllCategories
    return _firebaseFirestore
        .collection(Paths.notes_collection)
        .doc(userId)
        .collection(Paths.notes_subcollection)
        .snapshots()
        .map((snap) =>
            snap.docs.map((e) => NoteModel.fromJson(json:e.data())).toList());
  } */

  @override
  Future<void> deleteNote(
      {required NoteModel note, required String userId}) async {
    // TODO: implement deleteCategory
    if (note.subParentId == "null" || note.subParentId == null)
      await _firebaseDb
          .reference()
          .child(Paths.categories_collection)
          .child(userId)
          .child(Paths.categories_subcollection)
          .child(note.parentId ?? "")
          .child(Paths.notes_collection)
          .child(note.id ?? "")
          .remove();
    else
      await _firebaseDb
          .reference()
          .child(Paths.categories_collection)
          .child(userId)
          .child(Paths.categories_subcollection)
          .child(note.parentId ?? "")
          .child(Paths.sub_categories_collection)
          .child(note.subParentId ?? "")
          .child(Paths.notes_collection)
          .child(note.id ?? "")
          .remove();
  }
}
