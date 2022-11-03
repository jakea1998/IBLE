class NoteModel {
  String? id;
  DateTime? createdAt;
  String? parentId;
  String? subParentId;
  String? title;
  String? description;
  NoteModel(
      {this.id,
      this.createdAt,
      this.parentId,
      this.subParentId,
      this.title,
      this.description});
  factory NoteModel.empty() {
    return NoteModel(
        id: null,
        createdAt: DateTime.now(),
        parentId: null,
        subParentId: null,
        title: "",
        description: "");
  }
  factory NoteModel.fromJson({Map<dynamic, dynamic>? json}) {
    return NoteModel(
        id: json?['id'],
        createdAt: DateTime.tryParse(json?['createdAt']),
        parentId: json?['parentId'],
        subParentId: json?['subParentId'],
        title: json?['title'],
        description: json?['description']);
  }
  Map<dynamic, dynamic> toJson() {
    final data = Map<dynamic, dynamic>();
    data['id'] = id;
    data['createdAt'] = createdAt?.toIso8601String();
    data['parentId'] = parentId;
    data['subParentId'] = subParentId;
    data['title'] = title;
    data['description'] = description;

    return data;
  }
}
