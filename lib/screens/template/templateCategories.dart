import 'package:bajuku_app/screens/home/homescreen.dart';
import 'package:bajuku_app/screens/template/templateDetail.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TemplateCategories extends StatefulWidget {
  final String categories;
  TemplateCategories({this.categories});

  @override
  _TemplateCategoriesState createState() => _TemplateCategoriesState();
}

class _TemplateCategoriesState extends State<TemplateCategories> {
  DocumentReference userRef;

  @override
  initState(){ 
    super.initState();
    _getUserDoc();
  } 

  @override
  Widget build(BuildContext context) {
    if(userRef != null){
      return Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
            return <Widget>[
              Container(
                child: SliverAppBar(
                  centerTitle: true,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Hexcolor('#3F4D55'),
                    onPressed: (){
                      Navigator.push(context, new MaterialPageRoute(
                                builder: (BuildContext context) => new HomeScreen())
                      );
                    },
                  ),
                  iconTheme: IconThemeData(
                    color: Hexcolor('#3F4D55'),
                  ),
                  backgroundColor: Colors.white,
                  expandedHeight: 50.0,
                  floating: false,
                  pinned: false,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(widget.categories,
                      style: TextStyle(color: Hexcolor('#3F4D55'),
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: FutureBuilder(
            future: DatabaseService().getClothes(widget.categories),
            builder: (_, snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Container(
                  child: Text('Loading'),
                );
              }else{
                return GridView.builder(
                  itemCount: snapshot.data.documents.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0), 
                  itemBuilder: (context, index){
                    return GestureDetector(
                      child: Card(
                        child: Image.network(snapshot.data.documents[index].data['image'])
                      ),
                      onTap: (){ 
                        print(snapshot.data.documents[index].documentID);
                        Navigator.of(context).pop();
                        Navigator.push(context, new MaterialPageRoute(
                          builder: (BuildContext context) => new TemplateDetail(documentId:snapshot.data.documents[index].documentID, categories: widget.categories, idx: index))
                        );
                      },
                    );
                  },
                );
              }
            },
          ),
        ),
      );
    }else{
      return Container(
        child: Text('Test'),
      );
    }
  }

  Future<void> _getUserDoc() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Firestore _firestore = Firestore.instance;

    FirebaseUser user = await _auth.currentUser();
    setState((){
      userRef = _firestore.collection('users').document(user.uid);
    });
 }

}