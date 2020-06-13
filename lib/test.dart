import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }

  List<String> options = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
  ];

  void cariJumlahAlphabet() {
    List<String> alpha = [];
    for (int i = 0; i < options.length; i++) {
      if (alpha.any((e) => e.contains(options[i].substring(0, 1).toUpperCase()))) {
        alpha.add(options[i].substring(0, 1).toUpperCase());
      } else {
        print('huruf ini sudah ada');
      }
    }
    for (var alpha in alpha) {
      print(alpha);
    }
  }
  @override
  void setState(fn) {
    super.setState(fn);
    cariJumlahAlphabet();
  }
}