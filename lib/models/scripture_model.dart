import 'package:ible/models/category_model.dart';

class Scripture {
  int? id;
  String? title;
  String? text;
  int? book;

  String? bookName;

  ///[Version] abbreviation. To be displayed
  String? version;
  String? categoryName;
  int? chapter;
  int? startVerse;
  int? endVerse;
  int? category;
  int? cross;

  List<Category>? crossRefs;

  Scripture({
    this.id,
    this.title,
    this.text,
    this.book,
    this.bookName,
    this.chapter,
    this.startVerse,
    this.endVerse,
    this.category,
    this.categoryName,
    this.cross,
    this.version,
  });

  Scripture copyWith({
    int? id,
    String? title,
    String? text,
    int? book,
    String? bookName,
    int? chapter,
    int? startVerse,
    int? endVerse,
    int? category,
    int? categoryName,
    int? cross,
    int? version,
  }) {
    return Scripture(
      id: id ?? this.id,
      title: title ?? this.title,
      text: text ?? this.text,
      book: book ?? this.book,
      bookName: bookName ?? this.bookName,
      chapter: chapter ?? this.chapter,
      startVerse: startVerse ?? this.startVerse,
      endVerse: endVerse ?? this.endVerse,
      category: category ?? this.category,
      categoryName: categoryName as String? ?? this.categoryName,
      cross: cross ?? this.cross,
      version: version as String? ?? this.version,
    );
  }

// @override
// TODO: implement props
// List<Object> get props => [id, title, text];

  factory Scripture.fromJson(Map<String, dynamic> json) {
    return Scripture(
        id: json['id'],
        title: json['title'],
        text: json['text'],
        book: json['book'],
        bookName: json['bookName'],
        chapter: json['chapter'],
        startVerse: json['startVerse'],
        endVerse: json['endVerse'],
        category: json['category'],
        categoryName: json['categoryName'],
        cross: json['cross'],
        version: json['version']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['text'] = this.text;

    data['book'] = this.book;
    data['bookName'] = this.bookName;
    data['chapter'] = this.chapter;
    data['startVerse'] = this.startVerse;
    data['endVerse'] = this.endVerse;
    data['category'] = this.category;
    data['categoryName'] = this.categoryName;
    data['cross'] = this.cross;
    data['version'] = this.version;
    return data;
  }

  @override
  String toString() {
    return 'Scripture: ID $id \n'
        'Book ID $book \n'
        'Book Name: $bookName'
        '\nChapter $chapter'
        '\nText: $text'
        '\nStart Verse $startVerse'
        '\nEnd Verse $endVerse';
  }

  String print() {
    return '${this.bookName} ${this.chapter}:${this.startVerse}${this.endVerse == null ? "" : "-${this.endVerse}"} \n'
        '${this.text}';
  }
}
