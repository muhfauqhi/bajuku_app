import 'dart:io';

import 'package:bajuku_app/screens/home/bottomnavigationbar.dart';
import 'package:bajuku_app/screens/home/home.dart';
import 'package:bajuku_app/screens/page/addItem/dialogChipsCategories.dart';
import 'package:bajuku_app/screens/page/addItem/dialogChipsFabrics.dart';
import 'package:bajuku_app/screens/page/imageEditor.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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

  @override
  void dispose() {
    _myController.dispose();
    super.dispose();
  }

  String itemName;
  String brand;
  String fabric;
  int worn = 0;
  String notes;
  String size;
  String season;
  String price;
  String cost;
  String dateBought;
  String color;
  String status = 'Available';
  int usedInOutfit = 0;
  String url;
  String image;
  static List<String> fabricsList;
  static String category;
  final _myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(),
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
                    builder: (BuildContext context) => new ImageEditor(
                          filePicture: widget.fileUpload,
                        )));
          },
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            constraints: BoxConstraints(
                minWidth: 25, minHeight: 25, maxHeight: 25, maxWidth: 25),
            child: GestureDetector(
              child: Image.asset('assets/images/helpicon.png'),
            ),
          )
        ],
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                //Add Notes
                buildInputNotes(),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        color: Hexcolor('#FFFFFF'),
                        height: 45,
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
                      ),
                      _buildContainerListDark('Name', "itemName"),
                      _buildContainerListLightFabric('Fabric', "fabric"),
                      _buildContainerListDark('Brand', "brand"),
                      _buildContainerListLight('Size', "size"),
                      _buildContainerListDark('Season', "season"),
                      _buildContainerListLightPrice('Price', "price"),
                      _buildContainerListDarkValueCost('Value Cost', "cost"),
                      _buildContainerListLightDate('Date bought', "dateBought"),
                      _buildColorPicker(),
                      _buildContainerListLightDisabled('Status', "status"),
                      _buildContainerListDarkDisabled(
                          'Used in Outfit', "usedInOutfit"),
                      _buildContainerListLightDisabled('Worn', "worn"),
                      _buildContainerListDarkCategory(
                          'Tags Category', "category1"),
                      _buildContainerListLight('URL', "url"),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: 8.0, right: 8.0, top: 25.0, bottom: 25.0),
                  child: FlatButton(
                    child: Image.asset('assets/images/buttonSave.png'),
                    onPressed: () async {
                      image = await uploadPic();
                      cost = price;
                      await DatabaseService().setClothes(
                          itemName,
                          brand,
                          fabricsList,
                          worn,
                          notes,
                          category,
                          size,
                          season,
                          price,
                          cost,
                          dateBought,
                          currentColor.toString(),
                          status,
                          usedInOutfit,
                          url,
                          image);
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) => new Home()));
                    },
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color currentColor = Colors.white;
  void changeColor(Color color) => setState(() => currentColor = color);

  Widget _buildContainerListLightDate(String desc, String data) {
    return Container(
      height: 50,
      margin: EdgeInsets.only(left: 25.0, right: 25.0),
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
          Container(
            height: 50,
            padding: EdgeInsets.only(top: 17),
            width: 135,
            child: GestureDetector(
              child: Text('Test'),
              onTap: () {},
            ),
          )
        ],
      ),
    );
  }

  Widget _buildContainerListDarkCategory(String desc, String data) {
    return Container(
      margin: EdgeInsets.only(left: 25.0, right: 25.0),
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
            height: 50,
            padding: EdgeInsets.only(top: 17),
            width: 135,
            child: GestureDetector(
              child: _buildTextCategory(),
              onTap: () {
                showDialog(
                  context: context,
                  child: DialogChipCategories(),
                ).then((value) {
                  setState(() {
                    category = DialogChipCategories().createState().getTags();
                  });
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTextCategory() {
    if (category != null) {
      return Text(
        category,
        style: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          color: Hexcolor('#3F4D55'),
        ),
      );
    } else {
      return Text(
        '',
        style: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          color: Hexcolor('#3F4D55'),
        ),
      );
    }
  }

  String getFabric() {
    String a = "";
    for (var t in fabricsList) {
      a = a + t + "; ";
    }
    return a;
  }

  Widget _buildTextFabric() {
    if (fabricsList != null) {
      return Text(
        getFabric(),
        style: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          color: Hexcolor('#3F4D55'),
        ),
      );
    } else {
      return Text(
        '',
        style: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          color: Hexcolor('#3F4D55'),
        ),
      );
    }
  }

  Widget _buildContainerListLightFabric(String desc, String data) {
    return Container(
      height: 50,
      margin: EdgeInsets.only(left: 25.0, right: 25.0),
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
          Container(
            height: 50,
            padding: EdgeInsets.only(top: 17),
            width: 135,
            child: GestureDetector(
              child: _buildTextFabric(),
              onTap: () {
                showDialog(
                  context: context,
                  child: DialogChipFabric(),
                ).then((value) {
                  setState(() {
                    fabricsList = DialogChipFabric().createState().getTags();
                  });
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Container _buildColorPicker() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(left: 25.0, right: 25.0),
      color: Hexcolor('#F8F6F4'),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 8.0),
            width: 135,
            child: Text(
              'Color',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
                color: Hexcolor('#3F4D55'),
              ),
            ),
          ),
          ButtonTheme(
            height: 20,
            padding: EdgeInsets.zero,
            minWidth: 20,
            buttonColor: currentColor,
            hoverColor: currentColor,
            child: RaisedButton(
              elevation: 0,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
                side: BorderSide(color: Colors.grey[500], width: 0.8),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Select a color'),
                      content: SingleChildScrollView(
                        child: BlockPicker(
                          pickerColor: Colors.red,
                          onColorChanged: changeColor,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          // GestureDetector(
          //   child: Container(
          //       color: currentColor,
          //       child: Icon(
          //         Icons.crop_square,
          //         color: currentColor,
          //       )),
          //   onTap: () {
          //     showDialog(
          //       context: context,
          //       builder: (BuildContext context) {
          //         return AlertDialog(
          //           title: Text('Select a color'),
          //           content: SingleChildScrollView(
          //             child: BlockPicker(
          //               pickerColor: Colors.red,
          //               onColorChanged: changeColor,
          //             ),
          //           ),
          //         );
          //       },
          //     );
          //   },
          // ),
        ],
      ),
    );
  }

  Container buildInputNotes() {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: TextFormField(
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

  Container _buildContainerListLightDisabled(String desc, String data) {
    return Container(
      margin: EdgeInsets.only(left: 25.0, right: 25.0),
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
                  enabled: false,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal,
                    color: Hexcolor('#3F4D55'),
                  ),
                  decoration: InputDecoration(
                    hintText: '',
                    hintStyle: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.normal,
                      color: Hexcolor('#3F4D55'),
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xF8F6F4))),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xF8F6F4))),
                    filled: true,
                    fillColor: Hexcolor('#FFFFFF'),
                  ),
                  onChanged: (val) {
                    if (data == "itemName") {
                      this.itemName = val;
                    } else if (data == "fabric") {
                      this.fabric = val;
                    } else if (data == "brand") {
                      this.brand = val;
                    } else if (data == "size") {
                      this.size = val;
                    } else if (data == "season") {
                      this.season = val;
                    } else if (data == "price") {
                      this.price = val;
                    } else if (data == "cost") {
                      this.cost = val;
                    } else if (data == "dateBought") {
                      this.dateBought = val;
                    } else if (data == "status") {
                      this.status = val;
                    } else if (data == "url") {
                      this.url = val;
                    }
                    setState(() => data = val);
                  }),
            ),
          )
        ],
      ),
    );
  }

  Container _buildContainerListDarkValueCost(String desc, String data) {
    return Container(
      margin: EdgeInsets.only(left: 25.0, right: 25.0),
      height: 50,
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
            width: 135,
            child: Text(
              '€ ' + _myController.text,
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

  Container _buildContainerListDarkDisabled(String desc, String data) {
    return Container(
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
          Expanded(
            child: Container(
              child: TextFormField(
                  enabled: false,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal,
                    color: Hexcolor('#3F4D55'),
                  ),
                  decoration: InputDecoration(
                    hintText: '',
                    hintStyle: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.normal,
                      color: Hexcolor('#3F4D55'),
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xF8F6F4))),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xF8F6F4))),
                    filled: true,
                    fillColor: Hexcolor('#F8F6F4'),
                  ),
                  onChanged: (val) {
                    if (data == "itemName") {
                      this.itemName = val;
                    } else if (data == "fabric") {
                      this.fabric = val;
                    } else if (data == "brand") {
                      this.brand = val;
                    } else if (data == "size") {
                      this.size = val;
                    } else if (data == "season") {
                      this.season = val;
                    } else if (data == "price") {
                      this.price = val;
                    } else if (data == "cost") {
                      this.cost = val;
                    } else if (data == "dateBought") {
                      this.dateBought = val;
                    } else if (data == "status") {
                      this.status = val;
                    } else if (data == "url") {
                      this.url = val;
                    }
                    setState(() => data = val);
                  }),
            ),
          )
        ],
      ),
    );
  }

  Container _buildContainerListDark(String desc, String data) {
    return Container(
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
          Expanded(
            child: Container(
              child: TextFormField(
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal,
                    color: Hexcolor('#3F4D55'),
                  ),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xF8F6F4))),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xF8F6F4))),
                    // filled: true,
                    // fillColor: Hexcolor('#FFFFFF'),
                  ),
                  onChanged: (val) {
                    if (data == "itemName") {
                      this.itemName = val;
                    } else if (data == "fabric") {
                      this.fabric = val;
                    } else if (data == "brand") {
                      this.brand = val;
                    } else if (data == "size") {
                      this.size = val;
                    } else if (data == "season") {
                      this.season = val;
                    } else if (data == "price") {
                      this.price = val;
                    } else if (data == "cost") {
                      this.cost = val;
                    } else if (data == "dateBought") {
                      this.dateBought = val;
                    } else if (data == "status") {
                      this.status = val;
                    } else if (data == "url") {
                      this.url = val;
                    }
                    setState(() => data = val);
                  }),
            ),
          )
        ],
      ),
    );
  }

  Container _buildContainerListLight(String desc, String data) {
    return Container(
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
                    if (data == "itemName") {
                      this.itemName = val;
                    } else if (data == "fabric") {
                      this.fabric = val;
                    } else if (data == "brand") {
                      this.brand = val;
                    } else if (data == "size") {
                      this.size = val;
                    } else if (data == "season") {
                      this.season = val;
                    } else if (data == "price") {
                      this.price = val;
                    } else if (data == "cost") {
                      this.cost = val;
                    } else if (data == "dateBought") {
                      this.dateBought = val;
                    } else if (data == "status") {
                      this.status = val;
                    } else if (data == "url") {
                      this.url = val;
                    }
                    setState(() => data = val);
                  }),
            ),
          )
        ],
      ),
    );
  }

  Container _buildContainerListLightPrice(String desc, String data) {
    return Container(
      margin: EdgeInsets.only(left: 25.0, right: 25.0),
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
          Container(
            child: Text(
              '€ ',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
                color: Hexcolor('#3F4D55'),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: TextFormField(
                  keyboardType: TextInputType.numberWithOptions(
                      signed: false, decimal: true),
                  controller: _myController,
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
                    if (data == "itemName") {
                      this.itemName = val;
                    } else if (data == "fabric") {
                      this.fabric = val;
                    } else if (data == "brand") {
                      this.brand = val;
                    } else if (data == "size") {
                      this.size = val;
                    } else if (data == "season") {
                      this.season = val;
                    } else if (data == "price") {
                      this.price = val;
                    } else if (data == "cost") {
                      this.cost = val;
                    } else if (data == "dateBought") {
                      this.dateBought = val;
                    } else if (data == "status") {
                      this.status = val;
                    } else if (data == "url") {
                      this.url = val;
                    }
                    setState(() => data = val);
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
    }
    // setState((){
    //   Scaffold.of(context).showSnackBar(SnackBar(content: Text("Profile Picture Uploaded")));
    // });
    return '';
  }
}
