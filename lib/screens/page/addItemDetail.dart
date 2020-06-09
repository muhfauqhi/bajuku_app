import 'dart:io';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:bajuku_app/screens/home/homescreen.dart';
import 'package:bajuku_app/screens/page/imageEditor.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:bajuku_app/shared/categories.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  // GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<Category>>();
  Category selected;
  String date;
  AutoCompleteTextField<Category> textField;

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
  String price;
  String cost;
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
                    builder: (BuildContext context) => new ImageEditor(filePicture: widget.fileUpload,)));
          },
        ),
        centerTitle: true,
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
                        color: Hexcolor('#F8F6F4'),
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
                      _buildContainerListLight('Fabric', 'fabric'),
                      _buildContainerListDark('Brand', 'brand'),
                      _buildContainerListLight('Size', 'fabric'),
                      _buildContainerListDark('Season', 'season'),
                      _buildContainerListLight('Price', 'price'),
                      _buildContainerListDark('Value Cost', 'cost'),
                      _buildContainerListLight('Date bought', 'dateBought'),
                      _buildColorPicker(),
                      _buildContainerListLight('Status', 'status'),
                      _buildContainerListDark('Used in Outfit', 'userInOutfit'),
                      _buildContainerListLight('Worn', 'worn'),
                      _buildContainerListDark('Tags Category', 'category1'),
                      _buildContainerListLight('URL', 'url'),
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
                          color.toString().substring(1, 4),
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
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                // RaisedButton(
                //   padding: EdgeInsets.zero,
                //   onPressed: () async {
                //     image = await uploadPic();
                //     cost = price;
                //     await DatabaseService().setClothes(
                //         name,
                //         brand,
                //         fabric,
                //         worn,
                //         notes,
                //         category1,
                //         category2,
                //         size,
                //         season,
                //         price,
                //         cost,
                //         dateBought,
                //         color,
                //         status,
                //         usedInOutfit,
                //         url,
                //         image);
                //     Navigator.push(
                //         context,
                //         new MaterialPageRoute(
                //             builder: (BuildContext context) =>
                //                 new HomeScreen()));
                //   },
                //   child: Image.asset(
                //     'assets/images/buttonSave.png',
                //     height: 50,
                //     width: 300,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color currentColor = Colors.white;
  void changeColor(Color color) => setState(() => currentColor = color);

  Container _buildColorPicker() {
    return Container(
      height: 50,
      padding: EdgeInsets.only(left: 2.0),
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
          GestureDetector(
            child: Container(
                color: currentColor,
                child: Icon(
                  Icons.crop_square,
                  color: currentColor,
                )),
            onTap: () {
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
        ],
      ),
    );
  }

  Column buildTextField() {
    return new Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16),
          child: textField,
        ),
        Container(
            padding: EdgeInsets.only(top: 64),
            child: selected != null
                ? new Column(
                    children: <Widget>[
                      new ListTile(
                        title: new Text(selected.categoryName),
                        trailing: new Text(selected.subCategoryName),
                      )
                    ],
                  )
                : new Icon(Icons.cancel)),
      ],
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
                    setState(() => data = val);
                  }),
            ),
          )
        ],
      ),
    );
  }

  // List<Category> categories = [
  //   new Category(categoryName: 'Accessories', subCategoryName: 'Caps and Hats'),
  //   new Category(categoryName: 'Accessories', subCategoryName: 'Headbands'),
  //   new Category(
  //       categoryName: 'Accessories', subCategoryName: 'Head Tie/Scarves'),
  //   new Category(categoryName: 'Accessories', subCategoryName: 'Belts'),
  //   new Category(categoryName: 'Accessories', subCategoryName: 'Eyewear'),
  //   new Category(
  //       categoryName: 'Accessories', subCategoryName: 'Wallets & Card Holder'),
  //   new Category(categoryName: 'Accessories', subCategoryName: 'Jewelry'),
  //   new Category(categoryName: 'Accessories', subCategoryName: 'Scarves'),
  //   new Category(categoryName: 'Accessories', subCategoryName: 'Ties'),
  //   new Category(categoryName: 'Accessories', subCategoryName: 'Watches'),
  //   new Category(categoryName: 'Accessories', subCategoryName: 'Others'),
  //   new Category(categoryName: 'Tops', subCategoryName: 'T-Shirts'),
  //   new Category(categoryName: 'Tops', subCategoryName: 'Blouses'),
  //   new Category(categoryName: 'Tops', subCategoryName: 'Tube top'),
  //   new Category(categoryName: 'Tops', subCategoryName: 'Crop Tops'),
  //   new Category(categoryName: 'Tops', subCategoryName: 'Sweaters'),
  //   new Category(
  //       categoryName: 'Full Body Wear', subCategoryName: 'Dresses / Gowns'),
  //   new Category(categoryName: 'Full Body Wear', subCategoryName: 'Activewear'),
  //   new Category(categoryName: 'Full Body Wear', subCategoryName: 'Rompers'),
  //   new Category(categoryName: 'Bottoms', subCategoryName: 'Pants/Trousers'),
  //   new Category(categoryName: 'Bottoms', subCategoryName: 'Skirts'),
  //   new Category(categoryName: 'Bottoms', subCategoryName: 'Shorts'),
  //   new Category(categoryName: 'Bottoms', subCategoryName: 'Sarong'),
  //   new Category(
  //       categoryName: 'Bottoms', subCategoryName: 'Tights and Leggings'),
  //   new Category(categoryName: 'Bottoms', subCategoryName: 'Jeans'),
  //   new Category(
  //       categoryName: 'Innerwear', subCategoryName: 'Long / Thermal Underwear'),
  //   new Category(categoryName: 'Innerwear', subCategoryName: 'Tank Top'),
  //   new Category(
  //       categoryName: 'Innerwear', subCategoryName: 'Underwear / Underpants'),
  //   new Category(categoryName: 'Innerwear', subCategoryName: 'Bras'),
  //   new Category(
  //       categoryName: 'Innerwear', subCategoryName: 'Corsets and Body Shapers'),
  //   new Category(categoryName: 'Innerwear', subCategoryName: 'Slip'),
  //   new Category(
  //       categoryName: 'Innerwear', subCategoryName: 'Panties / Underwear'),
  //   new Category(categoryName: 'Outerwear', subCategoryName: 'Coats'),
  //   new Category(
  //       categoryName: 'Outerwear', subCategoryName: 'Jackets and Hoodies'),
  //   new Category(categoryName: 'Outerwear', subCategoryName: 'Vest/Waistcoat'),
  //   new Category(
  //       categoryName: 'Outerwear', subCategoryName: 'Robes and CLoaks'),
  //   new Category(categoryName: 'Outerwear', subCategoryName: 'Poncho'),
  //   new Category(
  //       categoryName: 'Outerwear', subCategoryName: 'Scarves and Shawls'),
  //   new Category(categoryName: 'Outerwear', subCategoryName: 'Windbreaker'),
  //   new Category(categoryName: 'Outerwear', subCategoryName: 'Gloves'),
  //   new Category(categoryName: 'Footwear', subCategoryName: 'Shoes'),
  //   new Category(categoryName: 'Footwear', subCategoryName: 'Sandals'),
  //   new Category(categoryName: 'Footwear', subCategoryName: 'Boots'),
  //   new Category(categoryName: 'Footwear', subCategoryName: 'Sneakers'),
  //   new Category(categoryName: 'Footwear', subCategoryName: 'Wedges'),
  //   new Category(categoryName: 'Footwear', subCategoryName: 'Loafers'),
  //   new Category(categoryName: 'Footwear', subCategoryName: 'Flats'),
  //   new Category(categoryName: 'Socks', subCategoryName: ''),
  //   new Category(categoryName: 'Bags', subCategoryName: 'Shoulder'),
  //   new Category(categoryName: 'Bags', subCategoryName: 'Briefcase'),
  //   new Category(categoryName: 'Bags', subCategoryName: 'Backpack'),
  //   new Category(categoryName: 'Bags', subCategoryName: 'Clutch'),
  //   new Category(categoryName: 'Bags', subCategoryName: 'Tote'),
  //   new Category(categoryName: 'Bags', subCategoryName: 'Crossbody'),
  //   new Category(categoryName: 'Bags', subCategoryName: 'Luggage and Travel'),
  // ];

  // _AddItemDetailState() {
  //   textField = new AutoCompleteTextField<Category>(
  //     decoration: new InputDecoration(
  //         hintText: "Category"),
  //     itemSubmitted: (item) => setState(() => selected = item),
  //     key: key,
  //     suggestions: categories,
  //     itemBuilder: (context, suggestion) => new Padding(
  //         child: new ListTile(
  //             title: new Text(suggestion.categoryName),
  //             trailing: new Text(suggestion.subCategoryName)),
  //         padding: EdgeInsets.all(8.0)),
  //     itemSorter: null,
  //     itemFilter: (suggestion, input) =>
  //         suggestion.categoryName.toLowerCase().startsWith(input.toLowerCase()),
  //   );
  // }

  Future<String> uploadPic() async {
    String fileName = name + DateTime.now().millisecondsSinceEpoch.toString();
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
