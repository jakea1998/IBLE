import 'package:ible/blocs/repos/base_verse_repo.dart';
import 'package:ible/blocs/repos/version_repo.dart';
import 'package:ible/blocs/utils/constants.dart';
import 'package:ible/models/passage_model.dart';
import 'package:ible/models/verse_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class VerseRepo extends BaseVerseRepo {
  @override
  Future<dynamic> getVerses({required String userId}) async {
    throw UnimplementedError();
  }

  @override
  Future<void> saveVerse({required String verseId, required String userId}) {
    // TODO: implement saveVerse
    throw UnimplementedError();
  }

  @override
  Future<List<Passage>> searchVerses({required String query}) async {
    // TODO: implement searchVerses
    String bibleVersionID = 'de4e12af7f28f599-01';
    //https://api.scripture.api.bible/v1/bibles/version='de4e12af7f28f599-01'/search?query="John"&offset=0
    String offset = "0";
    final query2 = query.replaceAll(" ", "%20");
    String url =
        'https://api.scripture.api.bible/v1/bibles/${bibleVersionID}/search?query=${query2}&offset=${offset}';
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
