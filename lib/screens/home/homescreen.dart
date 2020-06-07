import 'package:bajuku_app/screens/home/home.dart';
import 'package:bajuku_app/screens/page/add.dart';
import 'package:bajuku_app/screens/page/addItem.dart';
import 'package:bajuku_app/screens/page/journal.dart';
import 'package:bajuku_app/screens/page/sustainable.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  
  final List<Widget> _children = [
    new Home(currentIndex: 0),
    new Home(currentIndex: 1),
    new SustainablePage(),
 ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: 
        _buildBottomNavigationBar(),
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: Hexcolor('#3F4D55'),
      unselectedItemColor: Hexcolor('#3F4D55'),
      items: [
       BottomNavigationBarItem(
         icon: Icon(Icons.home),
         title: Text(''),
       ),
       BottomNavigationBarItem(
         icon: Icon(Icons.add_circle_outline),
         title: Text(''),
       ),
       BottomNavigationBarItem(
         icon: Icon(Icons.person),
         title: Text('')
       ),
      ],
      onTap: onTabTapped,
      );
  }
        
    void onTabTapped(int value) {
      setState(() {
        _currentIndex = value;
      });
  }
}