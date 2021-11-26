class Category {
  int? id;
  String? catId;
  int? parent;
  String? title;
  String? description;
  int? pinned;
  bool? shaded;
  String? noteTitle;
  DateTime? updated;
  List<Category>? children;
  Category(
      {this.id,
      this.catId,
      this.parent,
      this.title,
      this.description,
      this.pinned,
      this.shaded,
      this.noteTitle,
      this.children,
      this.updated});
  factory Category.favorite() {
    return Category(id: 2, title: 'Favorites', catId: 'Favorites');
  }
  factory Category.memory() {
    return Category(id: 1, title: 'Memories', catId: 'Memories');
  }
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      catId: json['catId'],
      parent: json['parent'],
      title: json['title'],
      description: json['description'],
      pinned: json['pinned'],
      shaded: json['shaded'],
      noteTitle: json['noteTitle'],
      updated: json['updated'],
    );
  }
  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['id'] = id;
    data['catId'] = catId;
    data['parent'] = parent;
    data['title'] = title;
    data['description'] = description;
    data['pinned'] = pinned;
    data['shaded'] = shaded;
    data['noteTitle'] = noteTitle;
    data['updated'] = updated;
    data['children'] = children?.map((e) => e.toJson()).toList();
    return data;
  }
}
