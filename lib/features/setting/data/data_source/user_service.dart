import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/features/setting/data/models/user_model.dart';

class UserService {
  Future<Either<FirebaseException, UserModel>> getUser() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      return right(
        UserModel.fromMap(querySnapshot.data()!),
      );
    } on FirebaseException catch (e) {
      return left(e);
    }
  }
}
