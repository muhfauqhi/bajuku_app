import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }

  List<String> options = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
  ];

  void cariJumlahAlphabet() {
    List<String> alpha = [];
    for (int i = 0; i < options.length; i++) {
      if (alpha.any((e) => e.contains(options[i].substring(0, 1).toUpperCase()))) {
        alpha.add(options[i].substring(0, 1).toUpperCase());
      } else {
        print('huruf ini sudah ada');
      }
    }
    for (var alpha in alpha) {
      print(alpha);
    }
  }
  @override
  void setState(fn) {
    super.setState(fn);
    cariJumlahAlphabet();
  }

  // Row _buildBags() {
  //   return Row(
  //     children: <Widget>[
  //       Column(
  //         children: <Widget>[
  //           FutureBuilder(
  //               future: DatabaseService().getClothes('Bags'),
  //               builder: (context, snapshot) {
  //                 if (!snapshot.hasData) {
  //                   return Text('');
  //                 } else {
  //                   return Column(
  //                     children: <Widget>[
  //                       Padding(
  //                         padding: EdgeInsets.only(left: 50.0, right: 11),
  //                         child: GestureDetector(
  //                           child: new Card(
  //                             child: new Image.asset(
  //                               'assets/images/bags_asset.png',
  //                               fit: BoxFit.cover,
  //                               height: 150.0,
  //                               width: 150.0,
  //                             ),
  //                             elevation: 0.0,
  //                           ),
  //                           onTap: () {
  //                             Navigator.of(context).pop();
  //                             Navigator.push(
  //                                 context,
  //                                 new MaterialPageRoute(
  //                                     builder: (BuildContext context) =>
  //                                         new TemplateCategories(
  //                                           categories: "Bags",
  //                                         )));
  //                           },
  //                         ),
  //                       ),
  //                       Container(
  //                         width: 150,
  //                         margin: EdgeInsets.only(left: 50.0),
  //                         child: Text(
  //                           'Bags',
  //                           style: TextStyle(
  //                             fontStyle: FontStyle.normal,
  //                             letterSpacing: 1.0,
  //                             fontWeight: FontWeight.bold,
  //                             fontSize: 16.0,
  //                             color: Hexcolor('#3F4D55'),
  //                           ),
  //                         ),
  //                       ),
  //                       Container(
  //                         width: 150,
  //                         margin: EdgeInsets.only(left: 50.0),
  //                         child: Text(
  //                           snapshot.data.documents.length.toString() +
  //                               " Pieces",
  //                           style: TextStyle(
  //                             fontStyle: FontStyle.normal,
  //                             letterSpacing: 1.0,
  //                             fontWeight: FontWeight.normal,
  //                             fontSize: 16.0,
  //                             color: Hexcolor('#859289'),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   );
  //                 }
  //               }),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  // Row _buildAccessoriesAndTops() {
  //   return Row(
  //     children: <Widget>[
  //       Column(
  //         children: <Widget>[
  //           FutureBuilder(
  //               future: DatabaseService().getClothes('Accessories'),
  //               builder: (context, snapshot) {
  //                 if (!snapshot.hasData) {
  //                   return Text('');
  //                 } else {
  //                   return Column(
  //                     children: <Widget>[
  //                       Padding(
  //                         padding: EdgeInsets.only(left: 50.0, right: 11),
  //                         child: GestureDetector(
  //                           child: new Card(
  //                             child: new Image.asset(
  //                               'assets/images/tops_asset.png',
  //                               fit: BoxFit.cover,
  //                               height: 150.0,
  //                               width: 150.0,
  //                             ),
  //                             elevation: 0.0,
  //                           ),
  //                           onTap: () {
  //                             Navigator.of(context).pop();
  //                             Navigator.push(
  //                                 context,
  //                                 new MaterialPageRoute(
  //                                     builder: (BuildContext context) =>
  //                                         new TemplateCategories(
  //                                           categories: "Accessories",
  //                                         )));
  //                           },
  //                         ),
  //                       ),
  //                       Container(
  //                         width: 150,
  //                         margin: EdgeInsets.only(left: 50.0),
  //                         child: Text(
  //                           'Accessories',
  //                           style: TextStyle(
  //                             fontStyle: FontStyle.normal,
  //                             letterSpacing: 1.0,
  //                             fontWeight: FontWeight.bold,
  //                             fontSize: 16.0,
  //                             color: Hexcolor('#3F4D55'),
  //                           ),
  //                         ),
  //                       ),
  //                       Container(
  //                         width: 150,
  //                         margin: EdgeInsets.only(left: 50.0),
  //                         child: Text(
  //                           snapshot.data.documents.length.toString() +
  //                               " Pieces",
  //                           style: TextStyle(
  //                             fontStyle: FontStyle.normal,
  //                             letterSpacing: 1.0,
  //                             fontWeight: FontWeight.normal,
  //                             fontSize: 16.0,
  //                             color: Hexcolor('#859289'),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   );
  //                 }
  //               }),
  //         ],
  //       ),
  //       Column(
  //         children: <Widget>[
  //           FutureBuilder(
  //               future: DatabaseService().getClothes('Tops'),
  //               builder: (context, snapshot) {
  //                 if (!snapshot.hasData) {
  //                   return Text('');
  //                 } else {
  //                   return Column(
  //                     children: <Widget>[
  //                       Padding(
  //                         padding: EdgeInsets.only(),
  //                         child: GestureDetector(
  //                           child: new Card(
  //                             child: new Image.asset(
  //                               'assets/images/tops_asset.png',
  //                               fit: BoxFit.cover,
  //                               height: 150.0,
  //                               width: 150.0,
  //                             ),
  //                             elevation: 0.0,
  //                           ),
  //                           onTap: () {
  //                             Navigator.of(context).pop();
  //                             Navigator.push(
  //                                 context,
  //                                 new MaterialPageRoute(
  //                                     builder: (BuildContext context) =>
  //                                         new TemplateCategories(
  //                                           categories: "Tops",
  //                                         )));
  //                           },
  //                         ),
  //                       ),
  //                       Container(
  //                         width: 150,
  //                         margin: EdgeInsets.only(left: 15.0),
  //                         child: Text(
  //                           'Tops',
  //                           style: TextStyle(
  //                             fontStyle: FontStyle.normal,
  //                             letterSpacing: 1.0,
  //                             fontWeight: FontWeight.bold,
  //                             fontSize: 16.0,
  //                             color: Hexcolor('#3F4D55'),
  //                           ),
  //                         ),
  //                       ),
  //                       Container(
  //                         width: 150,
  //                         margin: EdgeInsets.only(left: 15.0),
  //                         child: Text(
  //                           snapshot.data.documents.length.toString() +
  //                               " Pieces",
  //                           style: TextStyle(
  //                             fontStyle: FontStyle.normal,
  //                             letterSpacing: 1.0,
  //                             fontWeight: FontWeight.normal,
  //                             fontSize: 16.0,
  //                             color: Hexcolor('#859289'),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   );
  //                 }
  //               }),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  // Row _buildSocksAndFootwear() {
  //   return Row(
  //     children: <Widget>[
  //       Column(
  //         children: <Widget>[
  //           FutureBuilder(
  //               future: DatabaseService().getClothes('Socks'),
  //               builder: (context, snapshot) {
  //                 if (!snapshot.hasData) {
  //                   return Text('');
  //                 } else {
  //                   return Column(
  //                     children: <Widget>[
  //                       Padding(
  //                         padding: EdgeInsets.only(left: 50.0, right: 11),
  //                         child: GestureDetector(
  //                           child: new Card(
  //                             child: new Image.asset(
  //                               'assets/images/tops_asset.png',
  //                               fit: BoxFit.cover,
  //                               height: 150.0,
  //                               width: 150.0,
  //                             ),
  //                             elevation: 0.0,
  //                           ),
  //                           onTap: () {
  //                             Navigator.of(context).pop();
  //                             Navigator.push(
  //                                 context,
  //                                 new MaterialPageRoute(
  //                                     builder: (BuildContext context) =>
  //                                         new TemplateCategories(
  //                                           categories: "Socks",
  //                                         )));
  //                           },
  //                         ),
  //                       ),
  //                       Container(
  //                         width: 150,
  //                         margin: EdgeInsets.only(left: 50.0),
  //                         child: Text(
  //                           'Socks',
  //                           style: TextStyle(
  //                             fontStyle: FontStyle.normal,
  //                             letterSpacing: 1.0,
  //                             fontWeight: FontWeight.bold,
  //                             fontSize: 16.0,
  //                             color: Hexcolor('#3F4D55'),
  //                           ),
  //                         ),
  //                       ),
  //                       Container(
  //                         width: 150,
  //                         margin: EdgeInsets.only(left: 50.0),
  //                         child: Text(
  //                           snapshot.data.documents.length.toString() +
  //                               " Pieces",
  //                           style: TextStyle(
  //                             fontStyle: FontStyle.normal,
  //                             letterSpacing: 1.0,
  //                             fontWeight: FontWeight.normal,
  //                             fontSize: 16.0,
  //                             color: Hexcolor('#859289'),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   );
  //                 }
  //               }),
  //         ],
  //       ),
  //       Column(
  //         children: <Widget>[
  //           FutureBuilder(
  //               future: DatabaseService().getClothes('Footwear'),
  //               builder: (context, snapshot) {
  //                 if (!snapshot.hasData) {
  //                   return Text('');
  //                 } else {
  //                   return Column(
  //                     children: <Widget>[
  //                       Padding(
  //                         padding: EdgeInsets.only(),
  //                         child: GestureDetector(
  //                           child: new Card(
  //                             child: new Image.asset(
  //                               'assets/images/tops_asset.png',
  //                               fit: BoxFit.cover,
  //                               height: 150.0,
  //                               width: 150.0,
  //                             ),
  //                             elevation: 0.0,
  //                           ),
  //                           onTap: () {
  //                             Navigator.of(context).pop();
  //                             Navigator.push(
  //                                 context,
  //                                 new MaterialPageRoute(
  //                                     builder: (BuildContext context) =>
  //                                         new TemplateCategories(
  //                                           categories: "Footwear",
  //                                         )));
  //                           },
  //                         ),
  //                       ),
  //                       Container(
  //                         width: 150,
  //                         margin: EdgeInsets.only(left: 15),
  //                         child: Text(
  //                           'Footwear',
  //                           style: TextStyle(
  //                             fontStyle: FontStyle.normal,
  //                             letterSpacing: 1.0,
  //                             fontWeight: FontWeight.bold,
  //                             fontSize: 16.0,
  //                             color: Hexcolor('#3F4D55'),
  //                           ),
  //                         ),
  //                       ),
  //                       Container(
  //                         width: 150,
  //                         margin: EdgeInsets.only(left: 15),
  //                         child: Text(
  //                           snapshot.data.documents.length.toString() +
  //                               " Pieces",
  //                           style: TextStyle(
  //                             fontStyle: FontStyle.normal,
  //                             letterSpacing: 1.0,
  //                             fontWeight: FontWeight.normal,
  //                             fontSize: 16.0,
  //                             color: Hexcolor('#859289'),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   );
  //                 }
  //               }),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  // Row _buildOuterwearAndInnerwear() {
  //   return Row(
  //     children: <Widget>[
  //       Column(
  //         children: <Widget>[
  //           FutureBuilder(
  //               future: DatabaseService().getClothes('Outerwear'),
  //               builder: (context, snapshot) {
  //                 if (!snapshot.hasData) {
  //                   return Text('');
  //                 } else {
  //                   return Column(
  //                     children: <Widget>[
  //                       Padding(
  //                         padding: EdgeInsets.only(left: 50.0, right: 11),
  //                         child: GestureDetector(
  //                           child: new Card(
  //                             child: new Image.asset(
  //                               'assets/images/jacket_asset.png',
  //                               fit: BoxFit.cover,
  //                               height: 150.0,
  //                               width: 150.0,
  //                             ),
  //                             elevation: 0.0,
  //                           ),
  //                           onTap: () {
  //                             Navigator.of(context).pop();
  //                             Navigator.push(
  //                                 context,
  //                                 new MaterialPageRoute(
  //                                     builder: (BuildContext context) =>
  //                                         new TemplateCategories(
  //                                           categories: "Outerwear",
  //                                         )));
  //                           },
  //                         ),
  //                       ),
  //                       Container(
  //                         width: 150,
  //                         margin: EdgeInsets.only(left: 50.0),
  //                         child: Text(
  //                           'Outerwear',
  //                           style: TextStyle(
  //                             fontStyle: FontStyle.normal,
  //                             letterSpacing: 1.0,
  //                             fontWeight: FontWeight.bold,
  //                             fontSize: 16.0,
  //                             color: Hexcolor('#3F4D55'),
  //                           ),
  //                         ),
  //                       ),
  //                       Container(
  //                         width: 150,
  //                         margin: EdgeInsets.only(left: 50.0),
  //                         child: Text(
  //                           snapshot.data.documents.length.toString() +
  //                               " Pieces",
  //                           style: TextStyle(
  //                             fontStyle: FontStyle.normal,
  //                             letterSpacing: 1.0,
  //                             fontWeight: FontWeight.normal,
  //                             fontSize: 16.0,
  //                             color: Hexcolor('#859289'),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   );
  //                 }
  //               }),
  //         ],
  //       ),
  //       Column(
  //         children: <Widget>[
  //           FutureBuilder(
  //               future: DatabaseService().getClothes('Innerwear'),
  //               builder: (context, snapshot) {
  //                 if (!snapshot.hasData) {
  //                   return Text('');
  //                 } else {
  //                   return Column(
  //                     children: <Widget>[
  //                       Padding(
  //                         padding: EdgeInsets.only(),
  //                         child: GestureDetector(
  //                           child: new Card(
  //                             child: new Image.asset(
  //                               'assets/images/tops_asset.png',
  //                               fit: BoxFit.cover,
  //                               height: 150.0,
  //                               width: 150.0,
  //                             ),
  //                             elevation: 0.0,
  //                           ),
  //                           onTap: () {
  //                             Navigator.of(context).pop();
  //                             Navigator.push(
  //                                 context,
  //                                 new MaterialPageRoute(
  //                                     builder: (BuildContext context) =>
  //                                         new TemplateCategories(
  //                                           categories: "Innerwear",
  //                                         )));
  //                           },
  //                         ),
  //                       ),
  //                       Container(
  //                         width: 150,
  //                         margin: EdgeInsets.only(left: 15.0),
  //                         child: Text(
  //                           'Innerwear',
  //                           style: TextStyle(
  //                             fontStyle: FontStyle.normal,
  //                             letterSpacing: 1.0,
  //                             fontWeight: FontWeight.bold,
  //                             fontSize: 16.0,
  //                             color: Hexcolor('#3F4D55'),
  //                           ),
  //                         ),
  //                       ),
  //                       Container(
  //                         width: 150,
  //                         margin: EdgeInsets.only(left: 15.0),
  //                         child: Text(
  //                           snapshot.data.documents.length.toString() +
  //                               " Pieces",
  //                           style: TextStyle(
  //                             fontStyle: FontStyle.normal,
  //                             letterSpacing: 1.0,
  //                             fontWeight: FontWeight.normal,
  //                             fontSize: 16.0,
  //                             color: Hexcolor('#859289'),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   );
  //                 }
  //               }),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  // Row _buildBottomsAndFullBodyWear() {
  //   return Row(
  //     children: <Widget>[
  //       Column(
  //         children: <Widget>[
  //           FutureBuilder(
  //               future: DatabaseService().getClothes('Bottoms'),
  //               builder: (context, snapshot) {
  //                 if (!snapshot.hasData) {
  //                   return Text('');
  //                 } else {
  //                   return Column(
  //                     children: <Widget>[
  //                       Padding(
  //                         padding: EdgeInsets.only(left: 50.0, right: 11),
  //                         child: GestureDetector(
  //                           child: new Card(
  //                             child: new Image.asset(
  //                               'assets/images/jeans_asset.png',
  //                               fit: BoxFit.cover,
  //                               height: 150.0,
  //                               width: 150.0,
  //                             ),
  //                             elevation: 0.0,
  //                           ),
  //                           onTap: () {
  //                             Navigator.of(context).pop();
  //                             Navigator.push(
  //                                 context,
  //                                 new MaterialPageRoute(
  //                                     builder: (BuildContext context) =>
  //                                         new TemplateCategories(
  //                                           categories: "Bottoms",
  //                                         )));
  //                           },
  //                         ),
  //                       ),
  //                       Container(
  //                         width: 150,
  //                         margin: EdgeInsets.only(left: 50.0),
  //                         child: Text(
  //                           'Bottoms',
  //                           style: TextStyle(
  //                             fontStyle: FontStyle.normal,
  //                             letterSpacing: 1.0,
  //                             fontWeight: FontWeight.bold,
  //                             fontSize: 16.0,
  //                             color: Hexcolor('#3F4D55'),
  //                           ),
  //                         ),
  //                       ),
  //                       Container(
  //                         width: 150,
  //                         margin: EdgeInsets.only(left: 50.0),
  //                         child: Text(
  //                           snapshot.data.documents.length.toString() +
  //                               " Pieces",
  //                           style: TextStyle(
  //                             fontStyle: FontStyle.normal,
  //                             letterSpacing: 1.0,
  //                             fontWeight: FontWeight.normal,
  //                             fontSize: 16.0,
  //                             color: Hexcolor('#859289'),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   );
  //                 }
  //               }),
  //         ],
  //       ),
  //       Column(
  //         children: <Widget>[
  //           FutureBuilder(
  //               future: DatabaseService().getClothes('Full Body Wear'),
  //               builder: (context, snapshot) {
  //                 if (!snapshot.hasData) {
  //                   return Text('');
  //                 } else {
  //                   return Column(
  //                     children: <Widget>[
  //                       Padding(
  //                         padding: EdgeInsets.only(),
  //                         child: GestureDetector(
  //                           child: new Card(
  //                             child: new Image.asset(
  //                               'assets/images/tops_asset.png',
  //                               fit: BoxFit.cover,
  //                               height: 150.0,
  //                               width: 150.0,
  //                             ),
  //                             elevation: 0.0,
  //                           ),
  //                           onTap: () {
  //                             Navigator.of(context).pop();
  //                             Navigator.push(
  //                                 context,
  //                                 new MaterialPageRoute(
  //                                     builder: (BuildContext context) =>
  //                                         new TemplateCategories(
  //                                           categories: "Full Body Wear",
  //                                         )));
  //                           },
  //                         ),
  //                       ),
  //                       Container(
  //                         width: 150,
  //                         margin: EdgeInsets.only(left: 15.0),
  //                         child: Text(
  //                           'Full Body Wear',
  //                           style: TextStyle(
  //                             fontStyle: FontStyle.normal,
  //                             letterSpacing: 1.0,
  //                             fontWeight: FontWeight.bold,
  //                             fontSize: 16.0,
  //                             color: Hexcolor('#3F4D55'),
  //                           ),
  //                         ),
  //                       ),
  //                       Container(
  //                         width: 150,
  //                         margin: EdgeInsets.only(left: 15.0),
  //                         child: Text(
  //                           snapshot.data.documents.length.toString() +
  //                               " Pieces",
  //                           style: TextStyle(
  //                             fontStyle: FontStyle.normal,
  //                             letterSpacing: 1.0,
  //                             fontWeight: FontWeight.normal,
  //                             fontSize: 16.0,
  //                             color: Hexcolor('#859289'),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   );
  //                 }
  //               }),
  //         ],
  //       ),
  //     ],
  //   );
  // }
}