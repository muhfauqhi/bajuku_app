import 'package:bajuku_app/screens/home/bottomnavigationbar.dart';
import 'package:bajuku_app/screens/page/scaffold/myscaffold.dart';
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
  initState() {
    super.initState();
    _getUserDoc();
  }

  @override
  Widget build(BuildContext context) {
    if (userRef != null) {
      return MyScaffold(
        title: 'Your Wardrobe',
        headerWidget: [
          buildHeader(),
        ],
        bottomNavigationBar: CustomBottomNavigationBar(),
        body: buildBody(),
      );
    } else {
      return Container(
        child: Text('Test'),
      );
    }
  }

  Widget buildHeader() {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 23.0, right: 22.0, top: 14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  widget.categories,
                  style: TextStyle(
                    color: Hexcolor('#3F4D55'),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Image.asset('assets/images/searchIcon.png'),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Image.asset('assets/images/filterIcon.png'),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 23),
                child: FutureBuilder(
                  future: DatabaseService().getClothes(widget.categories),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text('');
                    } else {
                      return Text(
                        snapshot.data.documents.length.toString() + " Items",
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.normal,
                          fontSize: 12.0,
                          color: Hexcolor('#859289'),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildBody() {
    return FutureBuilder(
      future: DatabaseService().getClothes(widget.categories),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('');
        } else {
          return GridView.builder(
            padding: EdgeInsets.only(left: 15, right: 15, top: 9, bottom: 120),
            shrinkWrap: true,
            itemCount: snapshot.data.documents.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 15.0),
            itemBuilder: (context, index) {
              return Container(
                // color: Colors.black,
                width: 150,
                height: 150,
                child: GestureDetector(
                  child: ClipRRect(
                    child: Card(
                      child: Image.network(
                        snapshot.data.documents[index].data['image'],
                        fit: BoxFit.fitWidth,
                      ),
                      elevation: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new TemplateDetail(
                                    documentId: snapshot
                                        .data.documents[index].documentID,
                                    categories: widget.categories,
                                    idx: index)));
                  },
                ),
              );
            },
          );
        }
      },
    );
  }

  Future<void> _getUserDoc() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Firestore _firestore = Firestore.instance;

    FirebaseUser user = await _auth.currentUser();
    setState(() {
      userRef = _firestore.collection('users').document(user.uid);
    });
  }
}
