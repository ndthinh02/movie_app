import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../features/landing/presentation/landing_page.dart';
import '../../my_home_page.dart';

class AuthWidget {
  static checkUser() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const MyHomePage();
        } else {
          return const LandingPage();
        }
      },
    );
  }
}
