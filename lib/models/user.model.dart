class AppUser {
  String? id;
  String? firstname;
  String? lastname;
  String? username;
  String? email;
  String? country;
  String? timestamp;
  AppUser(
      {this.id,
      this.firstname,
      this.lastname,
      this.email,
      this.username,
      this.country,
      this.timestamp});
  factory AppUser.empty() {
    return AppUser(
        id: "",
        firstname: "",
        lastname: "",
        username: "",
        email: "",
        country: "",
        timestamp: "");
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['username'] = username;
    data['email'] = email;
    data['country'] = country;
    data['timestamp'] = timestamp;
    return data;
  }

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
        id: json['id'],
        firstname: json['firstname'],
        lastname: json['lastname'],
        username: json['username'],
        email: json['email'],
        country: json['country'],
        timestamp: json['timestamp']);
  }
  @override
  String toString() {
    return 'AppUser firstName:$firstname lastName:$lastname';
  }
}
