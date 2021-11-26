import 'package:ible/models/bible_version.dart';

abstract class BaseLanguageRepo {
  Future<void> initializeLanguage();
  Future<void> saveLanguage(
      {required Language language, required String userId});
  Future<Language> fetchSavedLanguage({required String userId});

  Set<String> getLanguages({required BibleVersionModel bibleVersionModel});
}
