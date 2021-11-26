class BibleVersionModel {
  List<Data>? data;

  BibleVersionModel({this.data});
  factory BibleVersionModel.empty() {
    return BibleVersionModel(data: []);
  }
  BibleVersionModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? dblId;
  Null relatedDbl;
  String? name;
  String? nameLocal;
  String? abbreviation;
  String? abbreviationLocal;
  String? description;
  String? descriptionLocal;
  Language? language;
  List<Countries>? countries;
  String? type;
  String? updatedAt;
  List<AudioBibles>? audioBibles;

  Data(
      {this.id,
      this.dblId,
      this.relatedDbl,
      this.name,
      this.nameLocal,
      this.abbreviation,
      this.abbreviationLocal,
      this.description,
      this.descriptionLocal,
      this.language,
      this.countries,
      this.type,
      this.updatedAt,
      this.audioBibles});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dblId = json['dblId'];
    relatedDbl = json['relatedDbl'];
    name = json['name'];
    nameLocal = json['nameLocal'];
    abbreviation = json['abbreviation'];
    abbreviationLocal = json['abbreviationLocal'];
    description = json['description'];
    descriptionLocal = json['descriptionLocal'];
    language = json['language'] != null
        ? new Language.fromJson(json['language'])
        : null;
    if (json['countries'] != null) {
      countries = [];
      json['countries'].forEach((v) {
        countries?.add(new Countries.fromJson(v));
      });
    }
    type = json['type'];
    updatedAt = json['updatedAt'];
    if (json['audioBibles'] != null) {
      audioBibles = [];
      json['audioBibles'].forEach((v) {
        audioBibles?.add(new AudioBibles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dblId'] = this.dblId;
    data['relatedDbl'] = this.relatedDbl;
    data['name'] = this.name;
    data['nameLocal'] = this.nameLocal;
    data['abbreviation'] = this.abbreviation;
    data['abbreviationLocal'] = this.abbreviationLocal;
    data['description'] = this.description;
    data['descriptionLocal'] = this.descriptionLocal;
    if (this.language != null) {
      data['language'] = this.language?.toJson();
    }
    if (this.countries != null) {
      data['countries'] = this.countries?.map((v) => v.toJson()).toList();
    }
    data['type'] = this.type;
    data['updatedAt'] = this.updatedAt;
    if (this.audioBibles != null) {
      data['audioBibles'] = this.audioBibles?.map((v) => v.toJson()).toList();
    }
    return data;
  }

  factory Data.empty() {
    return Data(
        abbreviation: '',
        dblId: '',
        relatedDbl: null,
        name: '',
        nameLocal: '',
        id: '',
        abbreviationLocal: '',
        description: '',
        descriptionLocal: '',
        language: Language.empty(),
        countries: [],
        type: '',
        updatedAt: '',
        audioBibles: []);
  }
}

class Language {
  String? id;
  String? name;
  String? nameLocal;
  String? script;
  String? scriptDirection;

  Language(
      {this.id, this.name, this.nameLocal, this.script, this.scriptDirection});
  factory Language.empty() {
    return Language(
        id: '', name: '', nameLocal: '', script: '', scriptDirection: '');
  }
  Language.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameLocal = json['nameLocal'];
    script = json['script'];
    scriptDirection = json['scriptDirection'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['nameLocal'] = this.nameLocal;
    data['script'] = this.script;
    data['scriptDirection'] = this.scriptDirection;
    return data;
  }
}

class Countries {
  String? id;
  String? name;
  String? nameLocal;

  Countries({this.id, this.name, this.nameLocal});

  Countries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameLocal = json['nameLocal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['nameLocal'] = this.nameLocal;
    return data;
  }
}

class AudioBibles {
  String? id;
  String? name;
  String? nameLocal;
  String? dblId;

  AudioBibles({this.id, this.name, this.nameLocal, this.dblId});

  AudioBibles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameLocal = json['nameLocal'];
    dblId = json['dblId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['nameLocal'] = this.nameLocal;
    data['dblId'] = this.dblId;
    return data;
  }
}
