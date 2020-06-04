import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SustainablePage extends StatefulWidget {
  @override
  _SustainablePageState createState() => _SustainablePageState();
}

class _SustainablePageState extends State<SustainablePage> {
  CollectionReference userRef;
  @override
  initState(){
    super.initState();
    _getUserDoc();
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Sustainable'),
        backgroundColor: Colors.red,
      ),
      body: 
      StreamBuilder(
        stream: userRef.snapshots(),
        builder: (context, snapshot){
          // print(snapshot.data.documents[0]['image']);
          if(!snapshot.hasData) return Text('Loading data...');
          else{
            String firstName = snapshot.data.documents[0]['firstName'];
            String lastName = snapshot.data.documents[0]['lastName'];
            String email = snapshot.data.documents[0]['email'];
            return Text(firstName+ ' ' +lastName+'\n'+ email);
          }
        },
      ),
    );
  }
  Future<void> _getUserDoc() async {
    final Firestore _firestore = Firestore.instance;

    setState((){
      userRef = _firestore.collection('users');
    });
 }
}

