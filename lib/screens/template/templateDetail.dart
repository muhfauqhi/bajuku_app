import 'package:bajuku_app/screens/template/templateCategories.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TemplateDetail extends StatefulWidget {
  final String documentId;
  final String categories;
  final int idx;
  TemplateDetail({this.documentId, this.categories, this.idx});
  @override
  _TemplateDetailState createState() => _TemplateDetailState();
}

class _TemplateDetailState extends State<TemplateDetail> {
  @override
  Widget build(BuildContext context) {
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
                      Navigator.of(context).pop();
                      Navigator.push(context, new MaterialPageRoute(
                          builder: (BuildContext context) => new TemplateCategories(categories: widget.categories))
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
                  title: Text('Clothing Detail',
                    style: TextStyle(color: Hexcolor('#3F4D55'),
                    ),
                  ),
                ),
              ),
              ),
          ];
        },
        body: FutureBuilder(
          future: DatabaseService().getClothesDetail(),
          builder: (_, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              // print("Loading");
              return Text('Loading');
            }else{
              // print(snapshot.data.documents.data["image"]);
              return Card(
                child: Column(
                  children: [
                    Image.network(snapshot.data.documents[widget.idx].data['image'],
                    width: 800,
                    height: 300,),
                    Text(snapshot.data.documents[widget.idx].data['clothName']),
                    Text(snapshot.data.documents[widget.idx].data['price']),
                    Text(snapshot.data.documents[widget.idx].data['category']),
                    Text(snapshot.data.documents[widget.idx].data['season']),
                  ],
                )
              );
            }
          },
        ),
      ),
    );
  }
}