class BibleVersionModel {
  List<Data>? data;

  BibleVersionModel({this.data});
  factory BibleVersionModel.empty() {
    return BibleVersionModel(data: []);
  }
  BibleVersionModel.fromJson(Map<dynamic, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(new Data.fromJson(v));
      });
    }
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data1 = new Map<String, dynamic>();
    if (data != null) {
      data1['data'] = data?.map((v) => v.toJson()).toList();
    }
    return data1;
  }
}

class Data {
  String? id;
  String? dblId;
  String? relatedDbl;
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
  
  Data.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'] == null ? '' : json['id'].toString();
    dblId = json['dblId'] == null ? '' : json['dblId'].toString();
    relatedDbl = json['relatedDbl'] == null ? '' : json['relatedDbl'].toString();
    name = json['name'] == null ? '' : json['name'].toString();
    nameLocal = json['nameLocal'] == null ? '' : json['nameLocal'].toString();
    abbreviation = json['abbreviation'] == null ? '' : json['abbreviation'].toString();
    abbreviationLocal = json['abbreviationLocal'] == null ? '' : json['abbreviationLocal'].toString();
    description = json['description'] == null ? '' : json['description'].toString();
    descriptionLocal = json['descriptionLocal'] == null ? '' : json['descriptionLocal'].toString();
    language = json['language'] != null
        ? new Language.fromJson(json['language'])
        : null;
    if (json['countries'] != null) {
      countries = [];
      json['countries'].forEach((v) {
        countries?.add(new Countries.fromJson(v));
      });
    }
    type = json['type'] == null ? '' : json['type'].toString();
    updatedAt = json['updatedAt'] == null ? '' : json['updatedAt'].toString();
    if (json['audioBibles'] != null) {
      audioBibles = [];
      json['audioBibles'].forEach((v) {
        audioBibles?.add(new AudioBibles.fromJson(v));
      });
    }
  }
  
  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = id.toString();
    data['dblId'] = dblId.toString();
    data['relatedDbl'] = relatedDbl.toString();
    data['name'] = name.toString();
    data['nameLocal'] = nameLocal.toString();
    data['abbreviation'] = abbreviation.toString();
    data['abbreviationLocal'] = abbreviationLocal.toString();
    data['description'] = description.toString();
    data['descriptionLocal'] = descriptionLocal.toString();
    if (language != null) {
      data['language'] = language?.toJson();
    }
    if (countries != null) {
      data['countries'] = countries?.map((v) => v.toJson()).toList();
    }
    data['type'] = type.toString();
    data['updatedAt'] = updatedAt.toString();
    if (audioBibles != null) {
      data['audioBibles'] = audioBibles?.map((v) => v.toJson()).toList();
    }
    return data;
  }

  factory Data.empty() {
    return Data(
        abbreviation: '',
        dblId: '',
        relatedDbl: '',
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
  factory Data.defaultVersion() {
    return Data(
        abbreviation: 'KJV',
        dblId: null,
        relatedDbl: null,
        name: 'King James (Authorised) Version',
        nameLocal: null,
        id: 'de4e12af7f28f599-02',
        abbreviationLocal: null,
        description: null,
        descriptionLocal: null,
        language: Language.empty(),
        countries: [],
        type: null,
        updatedAt: null,
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
        id: null, name: null, nameLocal: null, script: null, scriptDirection: null);
  }
  Language.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'] == null ? null : json['id'].toString();
    name = json['name'] == null ? null : json['name'].toString();
    nameLocal = json['nameLocal'] == null ? null : json['nameLocal'].toString();
    script = json['script'] == null ? null : json['script'].toString();
    scriptDirection = json['scriptDirection'] == null
        ? null
        : json['scriptDirection'].toString();
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = id.toString();
    data['name'] = name.toString();
    data['nameLocal'] = nameLocal.toString();
    data['script'] = script.toString();
    data['scriptDirection'] = scriptDirection.toString();
    return data;
  }
}

class Countries {
  String? id;
  String? name;
  String? nameLocal;

  Countries({this.id, this.name, this.nameLocal});

  Countries.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'] == null ? null : json['id'].toString();
    name = json['name'] == null ? null : json['name'].toString();
    nameLocal = json['nameLocal'] == null ? null : json['nameLocal'].toString();
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = id.toString();
    data['name'] = name.toString();
    data['nameLocal'] = nameLocal.toString();
    return data;
  }
}

class AudioBibles {
  String? id;
  String? name;
  String? nameLocal;
  String? dblId;

  AudioBibles({this.id, this.name, this.nameLocal, this.dblId});

  AudioBibles.fromJson(Map<dynamic, dynamic> json) {
    id = json['id']  == null ? '' : json['id'].toString();
    name = json['name'] == null ? '' : json['name'].toString();
    nameLocal = json['nameLocal'] == null ? '' : json['nameLocal'].toString();
    dblId = json['dblId'] == null ? '' : json['dblId'].toString();
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = id.toString();
    data['name'] = name.toString();
    data['nameLocal'] = nameLocal.toString();
    data['dblId'] = dblId.toString();
    return data;
  }
}
