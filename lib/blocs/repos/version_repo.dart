import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:ible/blocs/repos/base_version_repo.dart';
import 'package:ible/blocs/utils/paths.dart';
import 'package:ible/models/bible_version.dart';
import 'dart:async';
import 'dart:convert';

class VersionRepo extends BaseVersionRepo {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  @override
  Future<BibleVersionModel> getBibleVersionModelList() async {
    String key = '89d62a2b302639cf4656679406a616b3';

    String url = 'https://api.scripture.api.bible/v1/bibles';

    http.Response r1 =
        await http.get(Uri.parse(url), headers: {'api-key': key});

    final json1 = _returnResponse(r1);

    BibleVersionModel result = BibleVersionModel.fromJson(json1);
    return result;
  }

  @override
  BibleVersionModel getOnlyVersionsByLanguage(
      {required BibleVersionModel bibleVersionModel,
      required String language}) {
    // TODO: implement getOnlyVersionsByLanguage
    bibleVersionModel.data
        ?.removeWhere((element) => element.language?.name != language);
    return bibleVersionModel;
  }

  @override
  Stream<Data> fetchSavedBibleVersion({required String userId})  {
    // TODO: implement fetchSavedBibleVersion
    return _firebaseFirestore
        .collection(Paths.version_collection)
        .doc(userId)
        .snapshots().map((event) => Data.fromJson(event.data() ?? {}));
    
  }

  @override
  Future<void> initializeBibleVersion() {
    // TODO: implement initializeBibleVersion
    throw UnimplementedError();
  }

  @override
  Future<void> saveBibleVersion(
      {required String userId, required Data savedVersion}) async {
    // TODO: implement saveBibleVersion
    await _firebaseFirestore
        .collection(Paths.version_collection)
        .doc(userId)
        .set(savedVersion.toJson(), SetOptions(merge: true));
  }
}

class AppException implements Exception {
  final _message;
  final _prefix;
  AppException([this._message, this._prefix]);
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException(String? message)
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  InvalidInputException(String? message) : super(message, "Invalid Input: ");
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
