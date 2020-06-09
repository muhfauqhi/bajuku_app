import 'package:bajuku_app/screens/authenticate/register.dart';
import 'package:bajuku_app/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  final String flag;
  Authenticate({this.flag});
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn;

  @override
  void initState() {
    super.initState();
    if (widget.flag == 'Login') {
      showSignIn = true;
    } else {
      showSignIn = false;
    }
  }

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
