import 'dart:io';

import 'package:bajuku_app/models/clothes.dart';
import 'package:bajuku_app/screens/home/home.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:bajuku_app/shared/loading.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class AddOutfitDetail extends StatefulWidget {
  final File fileUpload;
  final List<String> clothNameList;
  final Map mapOfCloth;
  final List<double> priceList;
  final List<Clothes> clothesList;
  final List<String> documentIdList;
  final Map<dynamic, dynamic> tagged;

  AddOutfitDetail({
    this.fileUpload,
    this.clothNameList,
    this.mapOfCloth,
    this.priceList,
    this.clothesList,
    this.documentIdList,
    this.tagged,
  });

  @override
  _AddOutfitDetailState createState() => _AddOutfitDetailState();
}

class _AddOutfitDetailState extends State<AddOutfitDetail> {
  final _formKey = GlobalKey<FormState>();
  String date;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    var now;
    var formatter;

    now = DateTime.now();
    formatter = new DateFormat('dd MMMM yyyy');
    date = formatter.format(now);
    totalCost = getTotalCost();
  }

  @override
  void dispose() {
    _myController.dispose();
    super.dispose();
  }

  String getTotalCost() {
    double total = 0.0;
    for (var i in widget.priceList) {
      total = total + i;
    }
    return total.toString();
  }

  int getTotalClothes() {
    return widget.clothNameList.length;
  }

  final DatabaseService databaseService = DatabaseService();

  String image;
  String name = '';
  String notes = '';
  String totalCost = '';

  final _myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: Text(
                "New Journal",
                style: TextStyle(
                  color: Hexcolor('#3f4d55'),
                  letterSpacing: 1,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                ),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Hexcolor('#3F4D55'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
            ),
            body: SingleChildScrollView(
              child: Container(
                child: Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    //Add Notes
                    buildInputNotes(),
                    Container(
                      child: Column(
                        children: <Widget>[
                          buildDate(),
                          _buildContainerTagging('Tagging'),
                          _buildContainerOutfit('Outfit Name'),
                          _buildContainerTotalCost('Total Cost'),
                          Container(
                            padding: EdgeInsets.only(
                                left: 8.0, right: 8.0, top: 25.0, bottom: 25.0),
                            margin: EdgeInsets.only(top: 200),
                            child: FlatButton(
                              child:
                                  Image.asset('assets/images/postButton.png'),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() => loading = true);
                                  image = await uploadPic();
                                  await databaseService.setOutfit(
                                    image,
                                    notes,
                                    name,
                                    totalCost,
                                    widget.tagged,
                                  );
                                  if (image != null) {
                                    setState(
                                      () {
                                        loading = false;
                                        for (var i in widget.tagged.values) {
                                          databaseService.updateUsedInOutfit(
                                              i['documentId']);
                                          databaseService.updatePoints(3);
                                        }
                                        showDialog(
                                          builder: (context) {
                                            Future.delayed(Duration(seconds: 3),
                                                () {
                                              Navigator.of(context).pop(true);
                                              Navigator.pop(context);
                                              Navigator.push(
                                                  context,
                                                  new MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          new Home()));
                                            });
                                            return Image.asset(
                                                'assets/images/outfitsaveddialog.png');
                                          },
                                          context: context,
                                        );
                                      },
                                    );
                                  } else {
                                    return null;
                                  }
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 80,
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ));
  }

  Container buildDate() {
    return Container(
      color: Hexcolor('#FFFFFF'),
      height: 40,
      margin: EdgeInsets.only(left: 25.0, right: 25.0),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 8.0),
            width: 135,
            child: Text(
              'Date',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
                color: Hexcolor('#3F4D55'),
              ),
            ),
          ),
          Container(
            child: Text(
              date,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
                color: Hexcolor('#3F4D55'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildInputNotes() {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: TextFormField(
          validator: (val) {
            if (val.isEmpty) {
              return "The notes field is required";
            } else {
              return null;
            }
          },
          maxLines: 5,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: const Color(0xF8F6F4))),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: const Color(0xF8F6F4))),
            filled: true,
            fillColor: Hexcolor('#F8F6F4'),
            contentPadding: EdgeInsets.fromLTRB(115, 30, 0, 0),
            hintText: 'Write your notes here',
            hintStyle: TextStyle(
              color: Hexcolor('#3f4d55'),
              letterSpacing: 1,
              fontSize: 12.0,
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.italic,
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.fromLTRB(21, 22, 24, 28),
              child: Card(
                child: Image.file(
                  widget.fileUpload,
                  height: 70.0,
                  width: 70.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          onChanged: (val) {
            setState(() => notes = val);
          }),
    );
  }

  Container _buildContainerTagging(String desc) {
    return Container(
      margin: EdgeInsets.only(left: 25.0, right: 25.0),
      // padding: EdgeInsets.all(14.0),
      height: 40,
      color: Hexcolor('#F8F6F4'),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 8.0),
            width: 135,
            child: Text(
              desc,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
                color: Hexcolor('#3F4D55'),
              ),
            ),
          ),
          Container(
            child: Text(
              getTotalClothes().toString() + ' clothes',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
                color: Hexcolor('#3F4D55'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildContainerTotalCost(String desc) {
    return Container(
      height: 40,
      margin: EdgeInsets.only(left: 25.0, right: 25.0),
      // padding: EdgeInsets.all(14.0),
      color: Hexcolor('#F8F6F4'),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 8.0),
            width: 135,
            child: Text(
              desc,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
                color: Hexcolor('#3F4D55'),
              ),
            ),
          ),
          Container(
            child: Text(
              '€ ' + totalCost,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
                color: Hexcolor('#3F4D55'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildContainerOutfit(String desc) {
    return Container(
      height: 40,
      margin: EdgeInsets.only(left: 25.0, right: 25.0),
      // padding: EdgeInsets.all(14.0),
      color: Hexcolor('#FFFFFF'),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 8.0),
            width: 135,
            child: Text(
              desc,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
                color: Hexcolor('#3F4D55'),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: TextFormField(
                  validator: (val) {
                    if (val.isEmpty) {
                      return "The name field is required";
                    } else {
                      return null;
                    }
                  },
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal,
                    color: Hexcolor('#3F4D55'),
                  ),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xFFFFFF))),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xFFFFFF))),
                    // filled: true,
                    // fillColor: Hexcolor('#FFFFFF'),
                  ),
                  onChanged: (val) {
                    this.name = val;
                  }),
            ),
          )
        ],
      ),
    );
  }

  Future<String> uploadPic() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference firebaseStrorageRef =
        FirebaseStorage.instance.ref().child('clothes/' + fileName);
    StorageUploadTask uploadTask =
        firebaseStrorageRef.putFile(widget.fileUpload);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    var imageURL = await taskSnapshot.ref.getDownloadURL();
    if (uploadTask.isComplete) {
      String img = imageURL.toString();
      return img;
    } else {
      return '';
    }
  }
}
