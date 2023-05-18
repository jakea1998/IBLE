import 'package:ible/models/bible_version.dart';

class Passage {
  String? id;
  String? orgId;
  String? bookId;
  String? bibleId;
  //List<String>? chapterIds;
  Data? bibleVersion;
  String? reference;
  String? categoryId;
  String? content;
  String? verseCount;
  String? copyright;
  Passage(
      {this.id,
      this.orgId,
      this.bookId,
      this.bibleId,
      this.bibleVersion,
      // this.chapterIds,
      this.categoryId,
      this.reference,
      this.content,
      this.verseCount,
      this.copyright});
  factory Passage.empty() {
    return Passage(
        id: '',
        orgId: '',
        bookId: '',
        bibleId: '',
        bibleVersion: null,
        // chapterIds: [],
        categoryId: '',
        reference: '',
        content: '',
        verseCount: '',
        copyright: '');
  }
  factory Passage.fromJson(Map<dynamic, dynamic> json) {
    List<String>? chapterIdsList = [];
    //json['chapterIds'].forEach((e) => chapterIdsList.add(e));
    return Passage(
        id: json['id'],
        orgId: json['orgId'],
        bibleId: json['bibleId'],
        bookId: json['bookId'],
        bibleVersion: Data.fromJson(
            json['bibleVersion'] as Map<String, dynamic>),
        // chapterIds: chapterIdsList,
        categoryId: json['categoryId'],
        reference: json['reference'].toString(),
        content: json['content'].toString(),
        verseCount: json['verseCount'].toString(),
        copyright: json['copyright'].toString());
  }
  Map<dynamic, dynamic> toJson() {
    final data = Map<dynamic, dynamic>();

    data['id'] = id;
    data['orgId'] = orgId;
    data['bookId'] = bookId;
    data['bibleId'] = bibleId;
    data['bibleVersion'] = bibleVersion?.toJson();
    // data['chapterIds'] = chapterIds;
    data['reference'] = reference;
    data['content'] = content.toString();
    data['categoryId'] = categoryId;
    data['verseCount'] = verseCount;
    data['copyright'] = copyright.toString();
    return data;
  }
}
