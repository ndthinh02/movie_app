import 'package:movie_app/features/setting/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    super.urlImage,
    super.email,
    super.username,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      urlImage: map['urlImage'] as String?,
      email: map['email'] as String?,
      username: map['username'] as String?,
    );
  }
}
