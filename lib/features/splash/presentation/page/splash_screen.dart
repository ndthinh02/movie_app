import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_app/commom/auth/auth_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (ctx) => AuthWidget.checkUser(),
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/lotties/splash.json',
          width: 200,
          height: 200,
          fit: BoxFit.cover,
          repeat: true,
        ),
      ),
    );
  }
}
