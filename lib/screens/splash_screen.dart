import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_namaa/shared/Cache_Helper/cache_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String nextPage = "";
  @override
  void initState() {
    initNextPage();
    super.initState();
  }

  initNextPage() async {
    bool isonBoarding = CacheHelper().getData(key: "onBoarding") ?? false;
    bool isLogin = CacheHelper().getData(key: "Login") ?? false;

    if (isonBoarding) {
      if (FirebaseAuth.instance.currentUser != null) {
        nextPage = '/home';
      } else {
        nextPage = '/login';
      }
    } else {
      nextPage = '/onboard';
    }
    // if (isonBoarding) {
    //   if (FirebaseAuth.instance.currentUser != null) {
    //     // if (isLogin) {
    //     //   nextPage = '/home';
    //     // }
    //     //  else {
    //     // }
    //     nextPage = '/login';
    //   } else {
    //     // nextPage = '/onboard';
    //   }
    // } else {
    //   nextPage = '/login';
    // }

    // if (initscreen == 0 || initscreen == null) {
    //   nextPage = "/onboard";
    // } else {
    //   nextPage = '/login';
    // }

    await Future.delayed(
      const Duration(seconds: 4),
    );
    Navigator.pushReplacementNamed(context, nextPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Image.asset('asset/images/logo-no-background.png'),
        ),
      ),
    );
  }
}
