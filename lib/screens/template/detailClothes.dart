import 'package:bajuku_app/models/clothes.dart';
import 'package:bajuku_app/screens/page/scaffold/myscaffold.dart';
import 'package:bajuku_app/screens/page/sustainability/sustainabilitygivesell/sustainabilityAdd.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class ClothesDetail extends StatelessWidget {
  final String title;
  final Clothes clothes;
  final bool buttonWorn;

  ClothesDetail({this.title, this.clothes, this.buttonWorn});
  final DatabaseService databaseService = DatabaseService();
  final format = new DateFormat('dd MMMM yyyy');

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      titleStyle: false,
      leadingActive: true,
      title: title,
      headerWidget: [],
      body: Container(
        color: Hexcolor('#FBFBFB'),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 330),
                child: IconButton(
                    icon: new Image.asset('assets/images/edit.png'),
                    onPressed: () {}),
              ),
              // Image of Cloth detail
              Container(
                width: 400,
                height: 300,
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Card(
                  elevation: 2.0,
                  child: Container(
                    child: Image.network(
                      clothes.image,
                      fit: BoxFit.fitWidth,
                    ),
                    decoration: BoxDecoration(
                      color: Hexcolor('#FFFFFF'),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 355,
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        clothes.clothName,
                        style: textStyle(16.0, '#3F4D55', FontWeight.bold,
                            FontStyle.normal, 1.0),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 200,
                          padding: EdgeInsets.only(left: 30.0, top: 10.0),
                          child: Text(
                            clothes.worn.toString() + ' times worn',
                            style: textStyle(16.0, '#859289'),
                          ),
                        ),
                        Container(
                          width: 185,
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Last worn ' +
                                clothes.worn.toString().toString() +
                                ' days ago',
                            textAlign: TextAlign.right,
                            style: textStyle(12.0, '#859289'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _buttonMiddle(context),
              _buildField('Notes', clothes.notes, '#F8F6F4', false, false),
              _buildField(
                  'Fabric',
                  clothes.fabric
                      .toString()
                      .substring(1, clothes.fabric.toString().length - 1),
                  '#FFFFFF',
                  false,
                  false),
              _buildField('Brand', clothes.brand, '#F8F6F4', false, false),
              _buildField('Size', clothes.size, '#FFFFFF', false, false),
              _buildField(
                  'Season',
                  clothes.season
                      .toString()
                      .substring(1, clothes.season.toString().length - 1),
                  '#F8F6F4',
                  false,
                  false),
              _buildField(
                  'Price', '€ ' + clothes.price, '#FFFFFF', false, false),
              _buildField(
                  'Value Cost', '€ ' + clothes.cost, '#F8F6F4', false, false),
              _buildField(
                  'Date Bought',
                  format.format(clothes.dateBought.toDate()),
                  '#FFFFFF',
                  false,
                  false),
              _buildField('Color', clothes.color.substring(10, 16), '#F8F6F4',
                  false, true),
              _buildField('Used in Outfit', clothes.usedInOutfit.toString(),
                  '#FFFFFF', false, false),
              _buildField(
                  'Tags Category',
                  clothes.category
                      .toString()
                      .substring(1, clothes.category.toString().length - 1),
                  '#F8F6F4',
                  false,
                  false),
              _buildField('URL', clothes.url, '#FFFFFF', false, false),
              SizedBox(
                height: 50,
              ),
              _buttonBottom(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttonMiddle(var context) {
    return buttonWorn ? _buildButton('wornButton', context) : Text('');
  }

  Widget _buttonBottom(var context) {
    return buttonWorn ? Text('') : _buildButton('next', context);
  }

  Widget _buildButton(var asset, var context) {
    return Container(
      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 25.0, bottom: 25.0),
      child: FlatButton(
        child: Image.asset('assets/images/$asset.png'),
        onPressed: () {
          return buttonWorn
              ? databaseService.updateWorn(clothes.documentId)
              : Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SustainAdd(clothes: clothes, title: title,)));
        },
      ),
    );
  }

  Widget _buildFieldURL(var data, var url) {
    return url
        ? GestureDetector(
            child: Container(
              child: Text(
                data,
                style: textStyle(12.0, '#1169EE'),
              ),
            ),
            onTap: () async {
              if (await canLaunch('https://' + data)) {
                await launch('https://' + data);
              } else {
                throw 'Could not launch $data';
              }
            },
          )
        : Container(
            child: Text(
              data,
              style: textStyle(12.0, '#3F4D55'),
            ),
          );
  }

  Widget _buildField(
      String desc, String data, String color, bool url, bool colorField) {
    return Container(
      margin: EdgeInsets.only(left: 25.0, right: 25.0),
      padding: EdgeInsets.all(14.0),
      color: Hexcolor(color),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 8.0),
            width: 120,
            child: Text(
              desc,
              style: textStyle(12.0, '#3F4D55', FontWeight.bold),
            ),
          ),
          colorField
              ? Container(
                  color: Hexcolor(data),
                  child: Icon(
                    Icons.crop_square,
                    color: Hexcolor(data),
                  ),
                )
              : _buildFieldURL(data, url),
        ],
      ),
    );
  }

  TextStyle textStyle(var fontSize,
      [var color,
      FontWeight fontWeight,
      FontStyle fontStyle,
      var letterspacing]) {
    return TextStyle(
      letterSpacing: letterspacing,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: Hexcolor('$color'),
      fontStyle: fontStyle,
    );
  }
}
