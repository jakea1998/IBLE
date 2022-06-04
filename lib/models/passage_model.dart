class Passage {
  String? id;
  String? orgId;
  String? bookId;
  String? bibleId;
  List<String>? chapterIds;
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
      this.chapterIds,
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
        chapterIds: [],
        categoryId: '',
        reference: '',
        content: '',
        verseCount: '',
        copyright: '');
  }
  factory Passage.fromJson(Map<String, dynamic> json) {
    List<String>? chapterIdsList = [];
    json['chapterIds'].forEach((e) => chapterIdsList.add(e));
    return Passage(
        id: json['id'],
        orgId: json['orgId'],
        bibleId: json['bibleId'],
        bookId: json['bookId'],
        chapterIds: chapterIdsList,
        categoryId: json['categoryId'],
        reference: json['reference'].toString(),
        content: json['content'].toString(),
        verseCount: json['verseCount'].toString(),
        copyright: json['copyright'].toString());
  }
  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['id'] = id;
    data['orgId'] = orgId;
    data['bookId'] = bookId;
    data['bibleId'] = bibleId;
    data['chapterIds'] = chapterIds;
    data['reference'] = reference;
    data['content'] = content;
    data['categoryId'] = categoryId;
    data['verseCount'] = verseCount;
    data['copyright'] = copyright;
    return data;
  }
}
