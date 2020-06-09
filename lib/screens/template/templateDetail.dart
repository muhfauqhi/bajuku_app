import 'package:bajuku_app/screens/template/templateCategories.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

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
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            Container(
              child: SliverAppBar(
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Hexcolor('#3F4D55'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new TemplateCategories(
                                    categories: widget.categories)));
                  },
                ),
                iconTheme: IconThemeData(
                  color: Hexcolor('#3F4D55'),
                ),
                backgroundColor: Hexcolor('FBFBFB'),
                expandedHeight: 50.0,
                floating: false,
                pinned: false,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    'Clothing Detail',
                    style: TextStyle(
                      color: Hexcolor('#3F4D55'),
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: DatabaseService().getClothesDetail(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('');
              } else {
                DateTime dt = DateTime.parse(snapshot
                    .data.documents[widget.idx].data['dateBought']
                    .toString());
                String date = new DateFormat('dd MMMM yyyy').format(dt);
                return Container(
                  color: Hexcolor('#FBFBFB'),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 330),
                        child: IconButton(
                            icon: new Image.asset('assets/images/edit.png'),
                            onPressed: () {}),
                      ),
                      Container(
                        height: 300,
                        width: 400,
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: ClipRRect(
                          child: Card(
                            child: Image.network(
                              snapshot.data.documents[widget.idx].data['image'],
                              fit: BoxFit.fitWidth,
                            ),
                            elevation: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 355,
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                snapshot.data.documents[widget.idx]
                                    .data['clothName'],
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Hexcolor('#3F4D55'),
                                  letterSpacing: 1.0,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 200,
                                  padding:
                                      EdgeInsets.only(left: 30.0, top: 10.0),
                                  child: Text(
                                    snapshot.data.documents[widget.idx]
                                            .data['worn']
                                            .toString() +
                                        ' times worn',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.normal,
                                      color: Hexcolor('#859289'),
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 185,
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    'Last worn ' +
                                        snapshot.data.documents[widget.idx]
                                            .data['worn'].toString()
                                            .toString() +
                                        ' days ago',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.normal,
                                      color: Hexcolor('#859289'),
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 25.0, bottom: 25.0),
                        child: FlatButton(
                          child: Image.asset('assets/images/wornButton.png'),
                          onPressed: () {},
                        ),
                      ),
                      _buildContainerListDark('Notes', snapshot.data.documents[widget.idx].data['notes']),
                      _buildContainerListLight('Fabric', 'Cotton; Nylon'),
                      _buildContainerListDark('Brand', ''),
                      _buildContainerListLight('Size',
                          snapshot.data.documents[widget.idx].data['size']),
                      _buildContainerListDark('Season',
                          snapshot.data.documents[widget.idx].data['season']),
                      _buildContainerListLight(
                          'Price',
                          snapshot.data.documents[widget.idx].data['price']
                              .toString()),
                      _buildContainerListDark(
                          'Value Cost',
                          snapshot.data.documents[widget.idx].data['cost']
                              .toString()),
                      _buildContainerListLight('Date Bought', date),
                      _buildContainerListDarkColor('Color', snapshot.data.documents[widget.idx].data['color'].toString()),
                      _buildContainerListLight('Status',
                          snapshot.data.documents[widget.idx].data['status']),
                      _buildContainerListDark(
                          'Used in Outfit',
                          snapshot
                              .data.documents[widget.idx].data['usedInOutfit']
                              .toString()),
                      _buildContainerListLight(
                          'Tags Category',
                          snapshot.data.documents[widget.idx]
                                  .data['category']['topCategory']
                                  .toString() +
                              '; ' +
                              snapshot.data.documents[widget.idx]
                                  .data['category']['subCategory']
                                  .toString()),

                      _buildContainerListDarkURL('URL',
                          snapshot.data.documents[widget.idx].data['url']),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Container _buildContainerListDarkColor(String desc, String snapshot) {
    return Container(
      margin: EdgeInsets.only(left: 25.0, right: 25.0),
      padding: EdgeInsets.all(14.0),
      color: Hexcolor('#F8F6F4'),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 8.0),
            width: 120,
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
            // color: Hexcolor(snapshot),
            child: Icon(
              Icons.crop_square,
              // color: Hexcolor(snapshot),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildContainerListDark(String desc, String snapshot) {
    return Container(
      margin: EdgeInsets.only(left: 25.0, right: 25.0),
      padding: EdgeInsets.all(14.0),
      color: Hexcolor('#F8F6F4'),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 8.0),
            width: 120,
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
          // Container(
          //   color: Hexcolor('$snapshot'),
          //   child: Icon(
          //     Icons.crop_square,
          //     color: Hexcolor('$snapshot'),
          //   ),
          // ),
          Container(
            child: Text(
              snapshot,
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

  Container _buildContainerListDarkURL(String desc, String snapshot) {
    return Container(
      margin: EdgeInsets.only(left: 25.0, right: 25.0),
      padding: EdgeInsets.all(14.0),
      color: Hexcolor('#F8F6F4'),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 8.0),
            width: 120,
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
          GestureDetector(
            child: Text(
              snapshot,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
                color: Colors.blue,
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Container _buildContainerListLight(String desc, String snapshot) {
    return Container(
      margin: EdgeInsets.only(left: 25.0, right: 25.0),
      padding: EdgeInsets.all(14.0),
      color: Hexcolor('#FFFFFF'),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 8.0),
            width: 120,
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
              snapshot,
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
}
