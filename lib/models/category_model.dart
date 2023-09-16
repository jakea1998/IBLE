import 'package:ible/models/note_model.dart';
import 'package:ible/models/passage_model.dart';
import 'package:uuid/uuid.dart';

class Category {
  String? id;
  String? parent;
  String? title;
  String? description;
  DateTime? updated;
  Passage? pinned;
  List<NoteModel>? notes;

  List<Category>? subCategories;
  List<Passage>? verses;
  Category({
    this.id,
    this.parent,
    this.title,
    this.description,
    this.updated,
    this.pinned,
    this.notes,
    this.subCategories,
    this.verses,
  });
  factory Category.favorite() {
    return Category(
      id: "2",
      title: 'Favorites',
    );
  }
  factory Category.memory() {
    return Category(
      id: "1",
      title: 'Memory Verses',
    );
  }
  factory Category.fromJson(Map<dynamic, dynamic> json) {
    final Map<dynamic, dynamic>? map = json['verses'] ;
    List<Passage>? verses = [];
    if(map!=null){
      map.forEach((key, value) {
       verses.add(Passage.fromJson( json['verses'][key] ));
      });
    }
    final Map<dynamic, dynamic>? map2 = json['subCategories'] ;
    List<Category>? subCategories = [];
    if(map2!=null){
      map2.forEach((key, value) {
       subCategories.add(Category.fromJson( json['subCategories'][key] ));
      });
    }
    final Map<dynamic, dynamic>? map3 = json['notes'] ;
    List<NoteModel>? notes = [];
    if(map3!=null){
      map3.forEach((key, value) {
       notes.add(NoteModel.fromJson( json:json['notes'][key] ));
      });
    }
    return Category(
        id: json['id'].toString(),
        parent: json['parent'].toString(),
        description: json['description'].toString(),
        updated: json['updated'] != null
            ? DateTime.parse(json['updated'].toString())
            : null,
        title: json['title'].toString(),
        pinned:
            json['pinned'] != null ? Passage.fromJson(json['pinned']) : null,
        subCategories: json["subCategories"] == null
            ? null
            : subCategories,
        notes: json["notes"] == null
            ? null
            : notes,
        verses: json["verses"] == null
            ? null
            : verses);
  }
  Map<dynamic, dynamic> toJson() {
    Map<dynamic, dynamic> verses1 = Map<dynamic, dynamic>();
    Map<dynamic, dynamic> subCategories1 = Map<dynamic, dynamic>();
    Map<dynamic, dynamic> notes1 = Map<dynamic, dynamic>();
    verses?.forEach((element) {
      verses1[element.id?.replaceAll(".", " ") ?? Uuid().v1()] =
          element.toJson();
    });
    subCategories?.forEach((element) {
      subCategories1[element.id?.replaceAll(".", " ") ?? Uuid().v1()] =
          element.toJson();
    });
    notes?.forEach((element) {
      notes1[element.id?.replaceAll(".", " ") ?? Uuid().v1()] =
          element.toJson();
    });

    final data = Map<dynamic, dynamic>();
    data['id'] = id;
    data['parent'] = parent;
    data['title'] = title;
    data['updated'] = updated != null
        ? updated?.toIso8601String()
        : DateTime.now().toIso8601String();
    data['pinned'] = pinned != null ? pinned?.toJson() : null;
    data['description'] = description;
    data['verses'] = verses == null ? null : verses1;
    data['subCategories'] =  subCategories == null
        ? null :
        subCategories1 /* : List<dynamic>.from(subCategories?.map((x) => x.toJson()) ?? []) */;
    data['notes'] = notes == null
        ? null
        : notes1;

    return data;
  }
}
