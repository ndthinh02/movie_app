// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dartz/dartz.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class FavoriteService {
//   Future<Either<FirebaseException, List<Favori>>> getListFav() async {
//     try {
//       QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//           .collection("Favorite")
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .collection("My Favorite Movie")
//           .get();
//       return right(querySnapshot);
//     } on FirebaseException catch (e) {
//       return left(e);
//     }
//   }
// }
