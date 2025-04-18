import 'package:epsp_sige/controllers/UserController.dart';
import 'package:epsp_sige/utils/Routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    var userCtrl = context.read<UserController>();

    Timer(Duration(seconds: 2), () {
      if(userCtrl.isFirstTimeBienvenue){
        Navigator.pushReplacementNamed(context, Routes.LoginPageRoutes);
      } else {
        Navigator.pushReplacementNamed(context, Routes.OnBoardingPageRoutes);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 70,
              child: Image.asset(
                'assets/logoesig.png',
                width: 300,
                height: 300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
