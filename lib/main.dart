import 'package:bajuku_app/screens/splash.dart';
import 'package:bajuku_app/screens/wrapper.dart';
import 'package:bajuku_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bajuku_app/models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: SplashScreen(),
        ),
    );
  }
}
