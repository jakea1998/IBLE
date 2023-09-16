import 'package:ible/models/bible_version.dart';

abstract class BaseVersionRepo {
  Future<void> initializeBibleVersion();
  Future<BibleVersionModel> getBibleVersionModelList();
  BibleVersionModel getOnlyVersionsByLanguage(
      {required BibleVersionModel bibleVersionModel, required String language});
  Future<void> saveBibleVersion(
      {required String userId, required Data savedVersion});
  Stream<Data> fetchSavedBibleVersion({required String userId});
  Future<bool> checkIfVersionExists({required String userId});
}
