import 'package:bajuku_app/screens/authenticate/register.dart';
import 'package:bajuku_app/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  final bool showSignIn = true;

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView: toggleView);
    } else{
      return Register(toggleView: toggleView);
    }

  }
}