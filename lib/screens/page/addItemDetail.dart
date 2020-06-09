import 'dart:io';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:bajuku_app/screens/home/homescreen.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:bajuku_app/shared/categories.dart';
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
  // final _formKey = GlobalKey<FormState>();
  GlobalKey keyTest = new GlobalKey<AutoCompleteTextFieldState<Category>>();
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
      body: buildTextField(),
      // body: SingleChildScrollView(
      //   child: Container(
      //     child: Form(
      //       // key: _formKey,
      //       child: Column(
      //         children: <Widget>[
      //           //Add Notes
      //           buildInputNotes(),
      //           Container(
      //             child: Column(
      //               children: <Widget>[
      //                 Container(
      //                   color: Hexcolor('#F8F6F4'),
      //                   height: 45,
      //                   margin: EdgeInsets.only(left: 25.0, right: 25.0),
      //                   child: Row(
      //                     children: <Widget>[
      //                       Container(
      //                         padding: EdgeInsets.only(left: 8.0),
      //                         width: 135,
      //                         child: Text(
      //                           'Date',
      //                           style: TextStyle(
      //                             fontSize: 12.0,
      //                             fontWeight: FontWeight.bold,
      //                             fontStyle: FontStyle.normal,
      //                             color: Hexcolor('#3F4D55'),
      //                           ),
      //                         ),
      //                       ),
      //                       Container(
      //                         child: Text(
      //                           date,
      //                           style: TextStyle(
      //                             fontSize: 12.0,
      //                             fontWeight: FontWeight.normal,
      //                             fontStyle: FontStyle.normal,
      //                             color: Hexcolor('#3F4D55'),
      //                           ),
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //                 _buildContainerListLight('Fabric', 'fabric'),
      //                 _buildContainerListDark('Brand', 'brand'),
      //                 _buildContainerListLight('Size', 'fabric'),
      //                 _buildContainerListDark('Season', 'season'),
      //                 _buildContainerListLight('Price', 'price'),
      //                 _buildContainerListDark('Value Cost', 'cost'),
      //                 _buildContainerListLight('Date bought', 'dateBought'),
      //                 _buildContainerListDark('Color', 'color'),
      //                 _buildContainerListLight('Status', 'status'),
      //                 _buildContainerListDark('Used in Outfit', 'userInOutfit'),
      //                 _buildContainerListLight('Worn', 'worn'),
      //                 // _buildContainerListDark('Tags Category', 'category1'),

      //                 _buildContainerListLight('URL', 'url'),
      //               ],
      //             ),
      //           ),
      //           RaisedButton(
      //             padding: EdgeInsets.zero,
      //             onPressed: () async {
      //               image = await uploadPic();
      //               cost = price;
      //               await DatabaseService().setClothes(
      //                   name,
      //                   brand,
      //                   fabric,
      //                   worn,
      //                   notes,
      //                   category1,
      //                   category2,
      //                   size,
      //                   season,
      //                   price,
      //                   cost,
      //                   dateBought,
      //                   color,
      //                   status,
      //                   usedInOutfit,
      //                   url,
      //                   image);
      //               Navigator.push(
      //                   context,
      //                   new MaterialPageRoute(
      //                       builder: (BuildContext context) =>
      //                           new HomeScreen()));
      //             },
      //             child: Image.asset(
      //               'assets/images/buttonSave.png',
      //               height: 50,
      //               width: 300,
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  Column buildTextField() {
    return new Column(
      children: <Widget>[
        Container(
          child: textField,
        ),
        Container(
          child: selected != null ? new Column(
            children: <Widget>[
              new ListTile(
                title: new Text(
                  selected.categoryName
                ),
                trailing: new Text(
                  selected.subCategoryName
                ),
              )
            ],
          )
          : new Icon(
            Icons.cancel
          ) 
        ),
      ],
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
          double prices = double.tryParse(val);
          // validasi
          if (prices == null || prices < 0.0) {
            return 'Price must be valid';
          } else {
            return val;
          }
        },
        onSaved: (val) {
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

  List<Category> categories = <Category>[
    Category(categoryName: 'Accessories', subCategoryName: 'Caps and Hats'),
    Category(categoryName: 'Accessories', subCategoryName: 'Headbands'),
    Category(categoryName: 'Accessories', subCategoryName: 'Head Tie/Scarves'),
    Category(categoryName: 'Accessories', subCategoryName: 'Belts'),
    Category(categoryName: 'Accessories', subCategoryName: 'Eyewear'),
    Category(
        categoryName: 'Accessories', subCategoryName: 'Wallets & Card Holder'),
    Category(categoryName: 'Accessories', subCategoryName: 'Jewelry'),
    Category(categoryName: 'Accessories', subCategoryName: 'Scarves'),
    Category(categoryName: 'Accessories', subCategoryName: 'Ties'),
    Category(categoryName: 'Accessories', subCategoryName: 'Watches'),
    Category(categoryName: 'Accessories', subCategoryName: 'Others'),
    Category(categoryName: 'Tops', subCategoryName: 'T-Shirts'),
    Category(categoryName: 'Tops', subCategoryName: 'Blouses'),
    Category(categoryName: 'Tops', subCategoryName: 'Tube top'),
    Category(categoryName: 'Tops', subCategoryName: 'Crop Tops'),
    Category(categoryName: 'Tops', subCategoryName: 'Sweaters'),
    Category(
        categoryName: 'Full Body Wear', subCategoryName: 'Dresses / Gowns'),
    Category(categoryName: 'Full Body Wear', subCategoryName: 'Activewear'),
    Category(categoryName: 'Full Body Wear', subCategoryName: 'Rompers'),
    Category(categoryName: 'Bottoms', subCategoryName: 'Pants/Trousers'),
    Category(categoryName: 'Bottoms', subCategoryName: 'Skirts'),
    Category(categoryName: 'Bottoms', subCategoryName: 'Shorts'),
    Category(categoryName: 'Bottoms', subCategoryName: 'Sarong'),
    Category(categoryName: 'Bottoms', subCategoryName: 'Tights and Leggings'),
    Category(categoryName: 'Bottoms', subCategoryName: 'Jeans'),
    Category(
        categoryName: 'Innerwear', subCategoryName: 'Long / Thermal Underwear'),
    Category(categoryName: 'Innerwear', subCategoryName: 'Tank Top'),
    Category(
        categoryName: 'Innerwear', subCategoryName: 'Underwear / Underpants'),
    Category(categoryName: 'Innerwear', subCategoryName: 'Bras'),
    Category(
        categoryName: 'Innerwear', subCategoryName: 'Corsets and Body Shapers'),
    Category(categoryName: 'Innerwear', subCategoryName: 'Slip'),
    Category(categoryName: 'Innerwear', subCategoryName: 'Panties / Underwear'),
    Category(categoryName: 'Outerwear', subCategoryName: 'Coats'),
    Category(categoryName: 'Outerwear', subCategoryName: 'Jackets and Hoodies'),
    Category(categoryName: 'Outerwear', subCategoryName: 'Vest/Waistcoat'),
    Category(categoryName: 'Outerwear', subCategoryName: 'Robes and CLoaks'),
    Category(categoryName: 'Outerwear', subCategoryName: 'Poncho'),
    Category(categoryName: 'Outerwear', subCategoryName: 'Scarves and Shawls'),
    Category(categoryName: 'Outerwear', subCategoryName: 'Windbreaker'),
    Category(categoryName: 'Outerwear', subCategoryName: 'Gloves'),
    Category(categoryName: 'Footwear', subCategoryName: 'Shoes'),
    Category(categoryName: 'Footwear', subCategoryName: 'Sandals'),
    Category(categoryName: 'Footwear', subCategoryName: 'Boots'),
    Category(categoryName: 'Footwear', subCategoryName: 'Sneakers'),
    Category(categoryName: 'Footwear', subCategoryName: 'Wedges'),
    Category(categoryName: 'Footwear', subCategoryName: 'Loafers'),
    Category(categoryName: 'Footwear', subCategoryName: 'Flats'),
    Category(categoryName: 'Socks', subCategoryName: ''),
    Category(categoryName: 'Bags', subCategoryName: 'Shoulder'),
    Category(categoryName: 'Bags', subCategoryName: 'Briefcase'),
    Category(categoryName: 'Bags', subCategoryName: 'Backpack'),
    Category(categoryName: 'Bags', subCategoryName: 'Clutch'),
    Category(categoryName: 'Bags', subCategoryName: 'Tote'),
    Category(categoryName: 'Bags', subCategoryName: 'Crossbody'),
    Category(categoryName: 'Bags', subCategoryName: 'Luggage and Travel'),
  ];

  _AddItemDetailState() {
    textField = new AutoCompleteTextField<Category>(
      itemSubmitted: (item) => setState(() => selected = item),
      key: keyTest,
      suggestions: categories,
      itemBuilder: (context, suggestion) => new Container(
          child: new ListTile(
        title: new Text(suggestion.categoryName),
        trailing: new Text(suggestion.subCategoryName),
      )),
      itemSorter: null,
      itemFilter: (suggestion, input) =>
          suggestion.categoryName.toLowerCase().startsWith(input.toUpperCase()),
    );
  }

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
