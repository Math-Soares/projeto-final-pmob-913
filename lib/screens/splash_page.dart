import 'package:flutter/material.dart';
import 'package:albedo/screens/main_aux.dart';
import 'package:albedo/screens/onboarding_page.dart';

import '../db/shared_prefs.dart';
import 'login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SharedPrefs prefs = SharedPrefs();

  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  void checkStatus() async {
    try {
      final onboardingSeen = await prefs.getOnBoardSeen();
      bool status = await prefs.getUserStatus();
      await Future.delayed(Duration(seconds: 3));

      if (!mounted) return;

      if (status) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              if (onboardingSeen == true) {
                return MainAux();
              } else {
                return OnboardingPage();
              }
            },
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return LoginPage();
            },
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator(color: Colors.blue)),
    );
  }
}
