class User {
  final String email;
  final String id;
  final String?  name;
  final String? password;


  User({
    required this.email,
    required this.id,
    // this.username,
    this.password,
    this.name,

  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'id': id,
      // 'username': username,
      'password': password,
      'name': name,
    };
  }


  // String toJson() => json.encode(toMap());


  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        // username: json["username"],
        password: json["password"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        // "username": username,
        "password": password,
        "name": name,
      };

}
