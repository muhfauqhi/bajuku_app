import 'package:bajuku_app/models/clothes.dart';
import 'package:bajuku_app/screens/home/home.dart';
import 'package:bajuku_app/screens/page/menu_burger/template/boxcolor.dart';
import 'package:bajuku_app/screens/page/scaffold/myscaffold.dart';
import 'package:bajuku_app/screens/page/sustainability/sustainabilitygivesell/sustainabilityAddClothes.dart';
import 'package:bajuku_app/screens/template/editItem.dart';
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
              widget.buttonWorn
                  ? Container(
                      margin: EdgeInsets.only(left: 330),
                      child: IconButton(
                          icon: Image.asset('assets/images/edit.png'),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditItemScreen(
                                        clothes: widget.clothes)));
                          }),
                    )
                  : Container(),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: ColorFiltered(
                        colorFilter: widget.clothes.status == 'Sold' ||
                                widget.clothes.status == 'Given'
                            ? ColorFilter.mode(Colors.grey, BlendMode.color)
                            : ColorFilter.mode(
                                Colors.transparent, BlendMode.color),
                        child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.clothes.image),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Container(
              //   width: MediaQuery.of(context).size.width * 0.90,
              //   height: 300,
              //   child: Card(
              //     elevation: 2.0,
              //     child: Container(
              //       child: Image.network(
              //         widget.clothes.image,
              //         fit: BoxFit.fitWidth,
              //       ),
              //       decoration: BoxDecoration(
              //         color: Hexcolor('#FFFFFF'),
              //         borderRadius: BorderRadius.circular(5.0),
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        widget.clothes.clothName,
                        style: textStyle(16.0, '#3F4D55', FontWeight.bold,
                            FontStyle.normal, 1.0),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      padding: EdgeInsets.only(top: 10.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Text(
                              widget.clothes.worn.toString() + ' times worn',
                              style: textStyle(16.0, '#859289'),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Text(
                              lastWornVal(),
                              textAlign: TextAlign.right,
                              style: textStyle(12.0, '#859289'),
                            ),
                          ),
                        ],
                      ),
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
                height: 20,
              ),
              _buttonDelete(context),
              _buttonBottom(context),
            ],
          ),
        ),
      ),
    );
  }

  String lastWornVal() {
    if (widget.clothes.worn > 0) {
      return 'Last worn ' +
          DateTime.now()
              .difference(widget.clothes.updateDate.toDate())
              .inDays
              .toString() +
          ' days ago';
    } else {
      return 'Last worn ' + '0 days ago';
    }
  }

  Widget _buttonMiddle(var context) {
    return widget.buttonWorn ? _buildButton('wornButton', context) : Text('');
  }

  Widget _buttonBottom(var context) {
    return widget.buttonWorn ? Text('') : _buildButton('next', context);
  }

  Widget _buttonDelete(var context) {
    return widget.buttonWorn ? _buildButtonDelete() : Text('');
  }

  onTapWorn() {
    setState(() {
      widget.clothes.worn++;
      showDialog(
        builder: (context) {
          Future.delayed(Duration(seconds: 3), () {
            Navigator.of(context).pop(true);
          });
          return Image.asset('assets/images/itemWorn.png');
        },
        context: context,
      );
    });
    databaseService.updateWorn(widget.clothes.documentId);
  }

  Future buildShowDialogCannotWorn(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            contentPadding: EdgeInsets.only(top: 0.0),
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 35),
                height: 100,
                child: Text(
                  "This item already " + widget.clothes.status.toString(),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          );
        });
  }

  Widget _buildButton(var asset, var context) {
    return Container(
      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 25.0, bottom: 25.0),
      child: FlatButton(
        child: Image.asset('assets/images/$asset.png'),
        onPressed: () {
          return widget.buttonWorn
              ? onTapWornVal()
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

  Future buildShowDialogDelete(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          contentPadding: EdgeInsets.only(top: 0.0),
          children: <Widget>[
            Container(
              color: Colors.transparent,
              width: 280,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 50, bottom: 50),
                    child: Text(
                      'Are you sure want \n   to delete this?',
                      style:
                          TextStyle(fontSize: 16, color: Hexcolor('#3F4D55')),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          child: Image.asset(
                            'assets/images/cancelbut.png',
                            width: 140,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        GestureDetector(
                          child: Image.asset(
                            'assets/images/deletebutton.png',
                            width: 140,
                          ),
                          onTap: () {
                            databaseService
                                .deleteClothes(widget.clothes.documentId);
                            showDialog(
                              builder: (context) {
                                Future.delayed(Duration(seconds: 3), () {
                                  Navigator.of(context).pop(true);
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              new Home()));
                                });
                                return Image.asset(
                                    'assets/images/deleteFeedback.png');
                              },
                              context: context,
                            );
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }

  Widget _buildButtonDelete() {
    return Container(
      margin: EdgeInsets.only(top: 0),
      child: GestureDetector(
        child: Text(
          'Delete this item',
          style: TextStyle(fontSize: 12, color: Hexcolor('#D96969')),
        ),
        onTap: () {
          return buildShowDialogDelete(context);
        },
      ),
    );
  }

  onTapWornVal() {
    if (widget.clothes.status == "Available") {
      return onTapWorn();
    } else {
      return buildShowDialogCannotWorn(context);
    }
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
              ? BoxColor(
                  color: data,
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
