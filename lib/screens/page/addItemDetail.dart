import 'dart:io';
import 'package:bajuku_app/screens/home/homescreen.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class AddItemDetail extends StatefulWidget {
  final File fileUpload;
  AddItemDetail({this.fileUpload});

  @override
  _AddItemDetailState createState() => _AddItemDetailState();
}

class _AddItemDetailState extends State<AddItemDetail> {
  final _formKey = GlobalKey<FormState>();
  String date;

  @override
  void initState() {
    super.initState();
    var now;
    var formatter;

    setState(() {
      now = DateTime.now();
      formatter = new DateFormat('dd MMMM yyyy');
      date = formatter.format(now);
    });
  }

  String name;
  String brand;
  String fabric;
  int worn = 0;
  String notes;
  String category1;
  String category2;
  String size;
  String season;
  double price;
  double cost;
  String dateBought;
  String color;
  String status = 'Available';
  int usedInOutfit = 0;
  String url;
  String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "Item Detail",
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
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => new HomeScreen()));
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            child: Column(
              children: <Widget>[
                //Add Notes
                buildInputNotes(),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                            labelText: date,
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: const Color(0xFFFFFF))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: const Color(0xFFFFFF))),
                            filled: true,
                            fillColor: Hexcolor('#FFFFFF'),
                          ),
                          onChanged: (val) {
                            setState(() => name = val);
                          }),
                      buildInputItemName(),
                      buildInputSize(),
                      buildInputSeason(),
                      buildInputPrice(),
                      buildInputDateBought(),
                      buildInputColor(),
                      buildInputCategory(),
                      buildInputURL(),
                    ],
                  ),
                ),
                RaisedButton(
                  padding: EdgeInsets.zero,
                  onPressed: () async {
                    image = await uploadPic();
                    cost = price;
                    await DatabaseService().setClothes(
                        name,
                        brand,
                        fabric,
                        worn,
                        notes,
                        category1,
                        category2,
                        size,
                        season,
                        price,
                        cost,
                        dateBought,
                        color,
                        status,
                        usedInOutfit,
                        url,
                        image);
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new HomeScreen()));
                  },
                  child: Image.asset(
                    'assets/images/buttonSave.png',
                    height: 50,
                    width: 300,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildInputURL() {
    return TextFormField(
        decoration: InputDecoration(
          hintText: 'URL',
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: const Color(0xFFFFFF))),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: const Color(0xFFFFFF))),
          filled: true,
          fillColor: Hexcolor('#FFFFFF'),
        ),
        onChanged: (val) {
          setState(() => url = val);
        });
  }

  TextFormField buildInputCategory() {
    return TextFormField(
        decoration: InputDecoration(
          // prefixText: 'Date',
          hintText: 'Category',
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: const Color(0xF8F6F4))),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: const Color(0xF8F6F4))),
          filled: true,
          fillColor: Hexcolor('#F8F6F4'),
        ),
        onChanged: (val) {
          setState(() => category1 = val);
        });
  }

  TextFormField buildInputColor() {
    return TextFormField(
        decoration: InputDecoration(
          hintText: 'Color',
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: const Color(0xFFFFFF))),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: const Color(0xFFFFFF))),
          filled: true,
          fillColor: Hexcolor('#FFFFFF'),
        ),
        onChanged: (val) {
          setState(() => color = val);
        });
  }

  TextFormField buildInputDateBought() {
    return TextFormField(
        decoration: InputDecoration(
          // prefixText: 'Date',
          hintText: 'Date Bought',
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: const Color(0xF8F6F4))),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: const Color(0xF8F6F4))),
          filled: true,
          fillColor: Hexcolor('#F8F6F4'),
        ),
        keyboardType: TextInputType.datetime,
        onChanged: (val) {
          setState(() => dateBought = val);
        });
  }

  TextFormField buildInputPrice() {
    return TextFormField(
        decoration: InputDecoration(
          // prefixText: 'Size',
          hintText: 'Price',
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: const Color(0xFFFFFF))),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: const Color(0xFFFFFF))),
          filled: true,
          fillColor: Hexcolor('#FFFFFF'),
        ),
        keyboardType: TextInputType.number,
        validator: (val) {
          int prices = int.tryParse(val);
          // validasi
          if (prices == null || prices < 0) {
            return 'Price must be valid';
          } else {
            return val;
          }
        },
        onChanged: (val) {
          setState(() => price = double.tryParse(val));
        });
  }

  TextFormField buildInputSeason() {
    return TextFormField(
        decoration: InputDecoration(
          // prefixText: 'Date',
          hintText: 'Season',
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: const Color(0xF8F6F4))),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: const Color(0xF8F6F4))),
          filled: true,
          fillColor: Hexcolor('#F8F6F4'),
        ),
        onChanged: (val) {
          setState(() => season = val);
        });
  }

  TextFormField buildInputSize() {
    return TextFormField(
        decoration: InputDecoration(
          // prefixText: 'Size',
          hintText: 'Size',
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: const Color(0xFFFFFF))),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: const Color(0xFFFFFF))),
          filled: true,
          fillColor: Hexcolor('#FFFFFF'),
        ),
        onChanged: (val) {
          setState(() => size = val);
        });
  }

  TextFormField buildInputItemName() {
    return TextFormField(
        decoration: InputDecoration(
          // prefixText: 'Date',
          hintText: 'Item Name',
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: const Color(0xF8F6F4))),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: const Color(0xF8F6F4))),
          filled: true,
          fillColor: Hexcolor('#F8F6F4'),
        ),
        onChanged: (val) {
          setState(() => name = val);
        });
  }

  TextFormField buildInputNotes() {
    return TextFormField(
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
        });
  }

  Future<String> uploadPic() async {
    String fileName =
        name + DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference firebaseStrorageRef =
        FirebaseStorage.instance.ref().child('clothes/' + fileName);
    StorageUploadTask uploadTask =
        firebaseStrorageRef.putFile(widget.fileUpload);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    var imageURL = await taskSnapshot.ref.getDownloadURL();
    if (uploadTask.isComplete) {
      String img = imageURL.toString();
      return img;
    }
    // setState((){
    //   Scaffold.of(context).showSnackBar(SnackBar(content: Text("Profile Picture Uploaded")));
    // });
    return '';
  }
}
