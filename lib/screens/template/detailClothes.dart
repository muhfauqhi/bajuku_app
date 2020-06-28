import 'package:bajuku_app/models/clothes.dart';
import 'package:bajuku_app/screens/page/scaffold/myscaffold.dart';
import 'package:bajuku_app/screens/page/sustainability/sustainabilitygivesell/sustainabilityAddClothes.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class ClothesDetail extends StatefulWidget {
  final String title;
  final Clothes clothes;
  final bool buttonWorn;
  final String type;

  ClothesDetail({this.title, this.clothes, this.buttonWorn, this.type});

  @override
  _ClothesDetailState createState() => _ClothesDetailState();
}

class _ClothesDetailState extends State<ClothesDetail> {
  final DatabaseService databaseService = DatabaseService();

  final format = new DateFormat('dd MMMM yyyy');

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      titleStyle: false,
      leadingActive: true,
      title: widget.title,
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
              Container(
                width: 400,
                height: 300,
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Card(
                  elevation: 2.0,
                  child: Container(
                    child: Image.network(
                      widget.clothes.image,
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
                        widget.clothes.clothName,
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
                            widget.clothes.worn.toString() + ' times worn',
                            style: textStyle(16.0, '#859289'),
                          ),
                        ),
                        Container(
                          width: 185,
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Last worn ' +
                                DateTime.now().difference(widget.clothes.updateDate.toDate()).inDays.toString() +
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
              _buildField(
                  'Notes', widget.clothes.notes, '#F8F6F4', false, false),
              _buildField(
                  'Fabric',
                  widget.clothes.fabric.toString().substring(
                      1, widget.clothes.fabric.toString().length - 1),
                  '#FFFFFF',
                  false,
                  false),
              _buildField(
                  'Brand', widget.clothes.brand, '#F8F6F4', false, false),
              _buildField('Size', widget.clothes.size, '#FFFFFF', false, false),
              _buildField(
                  'Season',
                  widget.clothes.season.toString().substring(
                      1, widget.clothes.season.toString().length - 1),
                  '#F8F6F4',
                  false,
                  false),
              _buildField('Price', '€ ' + widget.clothes.price, '#FFFFFF',
                  false, false),
              _buildField('Value Cost', '€ ' + widget.clothes.cost, '#F8F6F4',
                  false, false),
              _buildField(
                  'Date Bought',
                  format.format(widget.clothes.dateBought.toDate()),
                  '#FFFFFF',
                  false,
                  false),
              _buildField('Color', widget.clothes.color.substring(10, 16),
                  '#F8F6F4', false, true),
              _buildField(
                  'Status', widget.clothes.status, '#FFFFFF', false, false),
              _buildField(
                  'Used in Outfit',
                  widget.clothes.usedInOutfit.toString(),
                  '#F8F6F4',
                  false,
                  false),
              _buildField(
                  'Tags Category',
                  widget.clothes.category.toString().substring(
                      1, widget.clothes.category.toString().length - 1),
                  '#FFFFFF',
                  false,
                  false),
              _buildField('URL', widget.clothes.url, '#F8F6F4', true, false),
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
    return widget.buttonWorn ? _buildButton('wornButton', context) : Text('');
  }

  Widget _buttonBottom(var context) {
    return widget.buttonWorn ? Text('') : _buildButton('next', context);
  }

  onTapWorn() {
    setState(() {
      widget.clothes.worn++;
    });
    databaseService.updateWorn(widget.clothes.documentId);
  }

  Widget _buildButton(var asset, var context) {
    return Container(
      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 25.0, bottom: 25.0),
      child: FlatButton(
        child: Image.asset('assets/images/$asset.png'),
        onPressed: () {
          return widget.buttonWorn
              ? onTapWorn()
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => SustainAddClothes(
                      clothes: widget.clothes,
                      title: widget.title,
                      type: widget.type,
                    ),
                  ),
                );
        },
      ),
    );
  }

  Widget _buildFieldURL(var data, var url) {
    print(widget.clothes.documentId);
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
        : Flexible(
            child: Container(
              child: Text(
                data,
                style: textStyle(12.0, '#3F4D55'),
                overflow: TextOverflow.clip,
                maxLines: 1,
                softWrap: false,
              ),
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
