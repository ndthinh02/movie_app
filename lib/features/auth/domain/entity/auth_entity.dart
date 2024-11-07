class AuthEntity {
  String? email;
  String? password;
  String? username;
  String? urlImage;

  AuthEntity({
    this.password,
    this.email,
    this.username,
    this.urlImage,
  });
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'username': username,
      'urlImage': urlImage,
    };
  }
}
