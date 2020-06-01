import 'dart:async';
import 'package:bajuku_app/screens/page/onboarding_login.dart';
import 'package:bajuku_app/screens/wrapper.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  startSplashScreen() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_){
        return Wrapper();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/splashscreen@3x.png'), 
        fit: BoxFit.cover),
      ),
    );
  }
}