
// import 'dart:io';
// import 'package:bajuku_app/screens/home/homescreen.dart';
// import 'package:bajuku_app/services/database.dart';
// import 'package:bajuku_app/shared/constants.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:intl/intl.dart';
// import 'package:path/path.dart';


// class AddItem extends StatefulWidget {
//   final File fileUpload;
//   AddItem({this.fileUpload});
//   @override
//   _AddItemState createState() => _AddItemState();
// }

// class _AddItemState extends State<AddItem> {
//   final _formKey = GlobalKey<FormState>();

//   String itemName;
//   String worn;
//   String notes;
//   String size;
//   String season;
//   String price;
//   String valueCost;
//   String colors;
//   String status;
//   String usedInOutfits;
//   String category;
//   String url;
//   String dateBought;
//   String date;
//   String image;

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//     resizeToAvoidBottomPadding: false,
//     appBar: new AppBar(
//       leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           color: Hexcolor('#3F4D55'),
//           onPressed: (){
//             Navigator.of(context).pop();
//             Navigator.push(context, new MaterialPageRoute(
//                       builder: (BuildContext context) => new HomeScreen())
//             );
//           },
//         ),
//       iconTheme: IconThemeData(
//         color: Colors.black,
//       ),
//       title: new Text('Add Item', 
//       style: TextStyle(color: Colors.black)),
//       centerTitle: true,
//       backgroundColor: Colors.white,
//     ),
//     body: SingleChildScrollView(
//           child: Container(
//           padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: <Widget>[
//                 _buildName(),
//                 _buildNotes(),
//                 _buildSeason(),
//                 _buildPrice(),
//                 _buildCategory(),
//                 _buildSize(),
//                 _buildDateBought(),
//                 _buildColor(),
//                 // _buildStatus(),
//                 _buildUrl(),
//                 RaisedButton(
//                   onPressed: () async {
//                     image = await uploadPic();
//                     var now;
//                     var formatter;
//                     now = DateTime.now();
//                     formatter = new DateFormat('yyyy-MM-dd');
//                     date = formatter.format(now);
//                     //image = "https://stockx.imgix.net/products/streetwear/Supreme-x-Louis-Vuitton-Box-Logo-Hooded-Sweatshirt-Red.png?fit=fill&bg=FFFFFF&w=700&h=500&auto=format,compress&q=90&trim=color&updated_at=1553700708&w=1000";
//                     worn = '0';
//                     status = 'Available';

//                     double prices = double.tryParse(price);
//                     int worns = int.tryParse(worn);
//                     double value = prices / worns;
//                     valueCost = price;
//                     usedInOutfits = '0';
//                     await DatabaseService().setClothes(itemName, worn, notes, category, size, season, price, valueCost, dateBought, colors, status, usedInOutfits, url, date, date, image);
//                     Navigator.push(context, new MaterialPageRoute(
//                         builder: (BuildContext context) => new HomeScreen())
//                     );
//                   },
//                   child: Text('Submit'),
//                   ),
//                 SizedBox(height: 10.0),
//               ]
//             ),
//           ),
//       ),
//     ),
//   );
//   }

//   TextFormField _buildSize() {
//     return TextFormField(
//               decoration: textInputDecoration.copyWith(hintText: 'Size'),
//               onChanged: (val){
//                 setState(() => size = val);
//               }
//             );
//   }

//   TextFormField _buildStatus() {
//     return TextFormField(
//               decoration: textInputDecoration.copyWith(hintText: 'Status'),
//               onChanged: (val){
//                 setState(() => status = val);
//               }
//             );
//   }

//   TextFormField _buildUrl() {
//     return TextFormField(
//               decoration: textInputDecoration.copyWith(hintText: 'Url'),
//               onChanged: (val){
//                 setState(() => url = val);
//               }
//             );
//   }

//   TextFormField _buildColor() {
//     return TextFormField(
//               decoration: textInputDecoration.copyWith(hintText: 'Color'),
//               onChanged: (val){
//                 setState(() => colors = val);
//               }
//             );
//   }

//   TextFormField _buildCategory() {
//     return TextFormField(
//               decoration: textInputDecoration.copyWith(hintText: 'Category'),
//               onChanged: (val){
//                 setState(() => category = val);
//               }
//             );
//   }

//   TextFormField _buildDateBought() {
//     return TextFormField(
//               decoration: textInputDecoration.copyWith(hintText: 'Date Bought'),
//               keyboardType: TextInputType.datetime,
//               onChanged: (val){
//                 setState(() => dateBought = val);
//               }
//             );
//   }

//   TextFormField _buildPrice() {
//     return TextFormField(
//               decoration: textInputDecoration.copyWith(hintText: 'Price'),
//               keyboardType: TextInputType.number,
//               validator: (val){
//                 int prices = int.tryParse(val);
//                 // validasi
//                 if(prices == null || prices < 0){
//                   return 'Price must be valid';
//                 }else{
//                   return val;
//                 }
//               },
//               onChanged: (val){
//                 setState(() => price = val);
//               }
//             );
//   }

//   TextFormField _buildNotes() {
//     return TextFormField(
//               decoration: textInputDecoration.copyWith(hintText: 'Notes'),
//               onChanged: (val){
//                 setState(() => notes = val);
//               }
//             );
//   }

//   TextFormField _buildSeason() {
//     return TextFormField(
//               decoration: textInputDecoration.copyWith(hintText: 'Season'),
//               onChanged: (val){
//                 setState(() => season = val);
//               }
//             );
//   }

//   TextFormField _buildName() {
//     return TextFormField(
//               decoration: textInputDecoration.copyWith(hintText: 'Cloth Name'),
//               onChanged: (val){
//                 setState(() => itemName = val);
//               }
//             );
//   }
//   Future <String> uploadPic() async{
//     String fileName = itemName+DateTime.now().millisecondsSinceEpoch.toString();
//     StorageReference firebaseStrorageRef = FirebaseStorage.instance.ref().child('clothes/'+fileName);
//     StorageUploadTask uploadTask = firebaseStrorageRef.putFile(widget.fileUpload);
//     StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
//     var imageURL = await taskSnapshot.ref.getDownloadURL();
//     if(uploadTask.isComplete){
//       String img = imageURL.toString();
//       return img;
//     }
//     // setState((){
//     //   Scaffold.of(context).showSnackBar(SnackBar(content: Text("Profile Picture Uploaded")));
//     // });
//     return '';
//   }
// }