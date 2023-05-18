import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ible/blocs/repos/base_verse_repo.dart';
import 'package:ible/blocs/repos/version_repo.dart';
import 'package:ible/blocs/utils/constants.dart';
import 'package:ible/blocs/utils/paths.dart';
import 'package:ible/models/bible_version.dart';
import 'package:ible/models/category_model.dart';
import 'package:ible/models/passage_model.dart';
import 'package:ible/models/verse_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class VerseRepo extends BaseVerseRepo {
  FirebaseFirestore _fs = FirebaseFirestore.instance;
  FirebaseDatabase _firebaseDb = FirebaseDatabase.instance;
  /*  @override
  Stream<List<Passage>> getVerses({required String userId}) {
    return _fs
        .collection(Paths.verses_collection)
        .doc(userId)
        .collection(Paths.verses_subcollection)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => Passage.fromJson(e.data())).toList());
  } */

  @override
  Future<List<Passage>> searchVerses({required String query,required Data bibleVersion}) async {
    // TODO: implement searchVerses
    String bibleVersionID = 'de4e12af7f28f599-01';
    //https://api.scripture.api.bible/v1/bibles/version='de4e12af7f28f599-01'/search?query="John"&offset=0
    String offset = "0";
    final query2 = query.replaceAll(" ", "%20");
    String url =
        'https://api.scripture.api.bible/v1/bibles/${bibleVersion.id.toString()}/search?query=${query2}&offset=${offset}';
    print('repo');
    http.Response r1 =
        await http.get(Uri.parse(url), headers: {'api-key': Constants.api_key});

    final json1 = _returnResponse(r1);
    if (json1['data']['total'] == '0') {
      print(json1['data']['total']);
      return [];
    } else {
      final verses = json1['data']['passages'];
      print(verses);
      final mapped = verses.map<Passage>((e) => Passage.fromJson(e)).toList();

      print(mapped);
      return mapped;
    }
  }

  @override
  Future<void> saveVerses(
      {required bool isNew,
      required Category category,
      required Data bibleVersion,
      required List<Passage> verses,
      required String userId}) async {
    // TODO: implement saveVerses
    //final batch = _fs.batch();
    /*  if (isNew)
      await _firebaseDb.ref()
          .child(Paths.categories_collection)
          .child(userId)
          .child(Paths.categories_subcollection)
          .child(category.id ?? "")
          .set(category.toJson()); */
    for (int i = 0; i < verses.length; i++) {
      verses[i].categoryId = category.id;
      verses[i].bibleVersion = bibleVersion;
    }
    print('save');
    category.verses = [];

    category.verses?.addAll(verses);
    print(category.verses?[0]);
    if (category.parent == "null" || category.parent == null) {
      print('save2');
      print(category.id);
      print(category.toJson());
      await _firebaseDb
          .ref()
          .child(Paths.categories_collection)
          .child(userId)
          .child(Paths.categories_subcollection)
          .child(category.id.toString())
          .set(category.toJson());
    } else {
      await _firebaseDb
          .ref()
          .child(Paths.categories_collection)
          .child(userId)
          .child(Paths.categories_subcollection)
          .child(category.parent ?? "")
          .child(Paths.sub_categories_collection)
          .child(category.id ?? "")
          .set(category.toJson());
    }

    // batch.commit();
  }
  @override
  Future<void> deleteVerse(
      {required Category category,
      required Passage verse,
      required String userId}) async {
    // TODO: implement deleteVerse
    if (category.parent == "null" || category.parent == null) {
     
      await _firebaseDb
          .ref()
          .child(Paths.categories_collection)
          .child(userId)
          .child(Paths.categories_subcollection)
          .child(category.id ?? "")
          .child(Paths.verses_collection)
          .child(verse.id?.replaceAll(".", " ") ?? "")
          .remove();
    } else {
     
      await _firebaseDb
          .ref()
          .child(Paths.categories_collection)
          .child(userId)
          .child(Paths.categories_subcollection)
          .child(category.parent ?? "")
          .child(Paths.sub_categories_collection)
          .child(category.id ?? "")
          .child(Paths.verses_collection)
          .child(verse.id?.replaceAll(".", " ") ?? "")
          .remove();
    }
  }
}

dynamic _returnResponse(http.Response response) {
  var responseReturn;

  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body);

      responseReturn = responseJson;

      break;
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
  return responseReturn;
}
