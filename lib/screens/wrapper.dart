import 'package:bajuku_app/models/user.dart';
import 'package:bajuku_app/screens/home/home.dart';
import 'package:bajuku_app/screens/page/onboarding_login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    
    // return either the Home or Authenticate widget
    if (user == null){
      return OnboardLogin();
    } else {
      return Home();
    }
  }
}