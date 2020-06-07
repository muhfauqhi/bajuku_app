import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SustainablePage extends StatefulWidget {
  @override
  _SustainablePageState createState() => _SustainablePageState();
}

class _SustainablePageState extends State<SustainablePage> {
  CollectionReference userRef;
  String uid;
  @override
  initState(){
    super.initState();
    _getUserDoc();
    _getUid();
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
        stream: userRef.document(uid).snapshots(),
        builder: (context, snapshot){
          // print(snapshot.data.documents[0]['image']);
          if(!snapshot.hasData) return Text('Loading data...');
          else{
            String firstName = snapshot.data['firstName'];
            String lastName = snapshot.data['lastName'];
            String email = snapshot.data['email'];
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
 Future<void> _getUid() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();

    setState((){
      uid = firebaseUser.uid;
    });
 }
}

