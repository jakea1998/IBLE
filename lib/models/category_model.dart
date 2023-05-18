import 'package:ible/models/note_model.dart';
import 'package:ible/models/passage_model.dart';
import 'package:uuid/uuid.dart';

class Category {
  String? id;
  String? parent;
  String? title;
  String? description;
  Passage? pinned;
  bool? shaded;
  List<NoteModel>? notes;
  DateTime? updated;
  List<Category>? subCategories;
  List<Passage>? verses;
  Category(
      {this.id,
      this.parent,
      this.title,
      this.description,
      this.pinned,
      this.shaded,
      this.notes,
      this.subCategories,
      this.verses,
      this.updated});
  factory Category.favorite() {
    return Category(
      id: "2",
      title: 'Favorites',
    );
  }
  factory Category.memory() {
    return Category(
      id: "1",
      title: 'Memories',
    );
  }
  factory Category.fromJson(Map<dynamic, dynamic> json) {
    return Category(
        id: json['id'].toString(),
        parent: json['parent'].toString(),
        title: json['title'],
        description: json['description'],
        pinned: Passage.fromJson(json['pinned']),
        shaded: json['shaded'],
        updated: json['updated'],
        subCategories: json["subCategories"] == null
            ? null
            : List<Category>.from(
                json["subCategories"].map((x) => Category.fromJson(x ?? {}))),
        notes: json["notes"] == null
            ? null
            : List<NoteModel>.from(
                json["notes"].map((x) => NoteModel.fromJson(json: x))),
        verses: json["verses"] == null
            ? null
            : List<Passage>.from(
                json["verses"].map((x) => Passage.fromJson(x ?? {}))));
  }
  Map<dynamic, dynamic> toJson() {
    Map<dynamic, dynamic> verses1 = Map<dynamic, dynamic>();

    verses?.forEach((element) {
      
      verses1[element.id ?? Uuid().v1()] = element.toJson();
    });
    final data = Map<dynamic, dynamic>();
    data['id'] = id;
    data['parent'] = parent;
    data['title'] = title;
    data['description'] = description;
    data['pinned'] = pinned?.toJson();
    data['shaded'] = shaded;
    data['verses'] = verses == null ? null : verses1;
    data['subCategories'] = subCategories == null
        ? null
        : List<dynamic>.from(subCategories?.map((x) => x.toJson()) ?? []);
    data['notes'] = notes == null
        ? null
        : List<dynamic>.from(notes?.map((x) => x.toJson()) ?? []);
    ;

    data['updated'] = updated;

    return data;
  }
}
