import 'package:ible/models/note_model.dart';

abstract class BaseNotesRepo {
  
  Future<void> saveNote(
      {required NoteModel note, required String userId});
  Future<void> deleteNote(
      {required NoteModel note, required String userId});
  //Stream<List<NoteModel>> getAllNotes({required String userId});
}