import 'package:flutter/material.dart';
import 'package:matrix_app/core/constants/app_sized.dart';
import 'package:matrix_app/core/dete_surce/prefs_manager.dart';
import 'package:matrix_app/features/auth/Sign_in_screen.dart';
import 'package:matrix_app/features/home/home_screen.dart';
import 'package:matrix_app/features/onboarding/onbording_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterSplash();
  }

  void _navigateAfterSplash() async {
    await Future.delayed(Duration(seconds: 3));
    final bool onboardingCompleted =
        PrefManger().getBool("onboarding_completed") ?? false;
    final bool isLogin = PrefManger().getBool("is_login") ?? false;
    if (!mounted) return;
    if (!onboardingCompleted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return OnbordingScreen();
          },
        ),
      );
    } else if (!isLogin) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return SignInScreen();
          },
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return HomeScreen();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff9ba3ff), Color(0xffdee2ff), Colors.white],
            stops: [0.0, 0.5, 0.8],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo_matrix.png',
                width: AppSized.w140,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
