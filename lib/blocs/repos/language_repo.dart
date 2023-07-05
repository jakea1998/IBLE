import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ible/blocs/repos/base_language_repo.dart';
import 'package:ible/blocs/utils/paths.dart';
import 'package:ible/models/bible_version.dart';

class LanguageRepo extends BaseLanguageRepo {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  @override
  Future<Language> fetchSavedLanguage({required String userId}) async {
    // TODO: implement fetchSavedLanguage
    final doc = await _firebaseFirestore
        .collection(Paths.language_collection)
        .doc(userId)
        .get();
    return Language.fromJson(doc.data() ?? {});
  }

  @override
  Future<void> saveLanguage(
      {required Language language, required String userId}) async {
    // TODO: implement saveLanguage
    Map<String, dynamic> data = Map<String, dynamic>();
    for (var item in language.toJson().keys) {
      data[item.toString()] = language.toJson()[item];
    }
    await _firebaseFirestore
        .collection(Paths.language_collection)
        .doc(userId)
        .set(data, SetOptions(merge: true));
  }

  @override
  Set<String> getLanguages({required BibleVersionModel bibleVersionModel}) {
    // TODO: implement getLanguages
    Set<String> languages = {};
    bibleVersionModel.data?.forEach((element) {
      languages.add(element.language?.name ?? '');
    });

    return languages;
  }

  @override
  Future<void> initializeLanguage() {
    // TODO: implement initializeLanguage
    throw UnimplementedError();
  }
}
