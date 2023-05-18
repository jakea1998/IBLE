import 'package:ible/models/bible_version.dart';
import 'package:ible/models/category_model.dart';
import 'package:ible/models/passage_model.dart';
import 'package:ible/models/verse_model.dart';

abstract class BaseVerseRepo {
  Future<void> saveVerses(
      {required bool isNew,
      required Category category,
      required Data bibleVersion,
      required List<Passage> verses,
      required String userId});
  // Stream<List<Passage>> getVerses({required String userId});
  Future<List<Passage>> searchVerses({
    required String query,
    required Data bibleVersion,
  });
  Future<void> deleteVerse(
      {required Category category,
      required Passage verse,
      required String userId});
}
