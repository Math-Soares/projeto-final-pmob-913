import 'package:flutter/material.dart';
import 'package:primeiroaplicativo/screens/main_aux.dart';
import 'package:primeiroaplicativo/screens/onboarding_page.dart';

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

  checkStatus() async {
    bool status = await prefs.getUserStatus();
    await Future.delayed(Duration(seconds: 3));

    if(status) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            if(prefs.getOnBoardSeen() == true) {
              return MainAux();
            } else {
              return OnboardingPage();
            }
          }
        )
      );
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) {
                return LoginPage();
              }
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.blue,
        ),
      ),
    );
  }
}
