import 'package:ible/models/bible_version.dart';

abstract class BaseVersionRepo {
  Future<void> initializeBibleVersion();
  Future<BibleVersionModel> getBibleVersionModelList();
  BibleVersionModel getOnlyVersionsByLanguage(
      {required BibleVersionModel bibleVersionModel, required String language});
  Future<void> saveBibleVersion(
      {required String userId, required Data savedVersion});
  Future<Data> fetchSavedBibleVersion({required String userId});
}
