import 'package:bajuku_app/models/user.dart';
import 'package:bajuku_app/screens/authenticate/authenticate.dart';
import 'package:bajuku_app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  final String flag;
  Wrapper({this.flag});
  
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    
    // return either the Home or Authenticate widget
    if (user == null){
      return Authenticate(flag: flag,);
    } else {
      return Home();
    }
  }
}