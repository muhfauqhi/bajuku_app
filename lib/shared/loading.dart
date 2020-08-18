import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      child: Center(
        child: SpinKitChasingDots(
          color: Hexcolor('#3F4D55'),
          size: 50.0,
        ),
      ),
    );
  }
}