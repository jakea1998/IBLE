import 'package:ible/models/passage_model.dart';
import 'package:ible/models/verse_model.dart';

abstract class BaseVerseRepo {
  Future<void> saveVerse({required String verseId, required String userId});
  Future<dynamic> getVerses({required String userId});
  Future<List<Passage>> searchVerses({required String query});
}
