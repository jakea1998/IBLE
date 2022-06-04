class Verse {
  String? id;
  String? orgId;
  String? bookId;
  String? bibleId;
  String? chapterId;
  String? categoryId;
  String? reference;
  String? text;
  Verse(
      {this.id,
      this.orgId,
      this.bookId,
      this.bibleId,
      this.chapterId,
      this.categoryId,
      this.reference,
      this.text});
  factory Verse.empty() {
    return Verse(
        id: '',
        orgId: '',
        bookId: '',
        bibleId: '',
        chapterId: '',
        categoryId: '',
        reference: '',
        text: '');
  }
  factory Verse.fromJson(Map<String, dynamic> json) {
    return Verse(
        id: json['id'],
        orgId: json['orgId'],
        bookId: json['bookId'],
        bibleId: json['bibleId'],
        chapterId: json['chapterId'],
        categoryId: json['categoryId'],
        reference: json['reference'],
        text: json['text']);
  }
  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['id'] = id;
    data['orgId'] = orgId;
    data['bookId'] = bookId;
    data['bibleId'] = bibleId;
    data['chapterId'] = chapterId;
    data['categoryId'] = categoryId;
    data['reference'] = reference;
    data['text'] = text;
    return data;
  }
}
