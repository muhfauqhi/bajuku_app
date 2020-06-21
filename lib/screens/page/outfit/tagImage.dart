import 'dart:io';

import 'package:bajuku_app/screens/page/outfit/buildTags.dart';
import 'package:bajuku_app/screens/page/outfit/findSuggestionClothes.dart';
import 'package:bajuku_app/screens/page/outfit/imageEditorOutfit.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TagImage extends StatefulWidget {
  final File file;
  final List<Widget> children;

  TagImage({this.file, this.children});

  @override
  _TagImageState createState() => _TagImageState();
}

class _TagImageState extends State<TagImage> {
  GlobalKey key = GlobalKey();

  String documentId;
  String clothName;
  String category;
  String price;

  Rect myRect;
  List<Widget> children = [];
  Map<String, String> mapCloth = Map();
  List<String> clothNameList = [];
  List<double> priceList = [];

  void getPositon() {
    final RenderBox renderBox = key.currentContext.findRenderObject();
    final position = renderBox.localToGlobal(Offset.zero);
    print(position);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: Text(
                'Cancel',
                style: TextStyle(
                    color: Hexcolor('#3F4D55'),
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'You\'ve made changes to this image.',
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                              color: Hexcolor('#3F4D55'),
                              fontSize: 16),
                        ),
                        content: Text(
                          'Are you sure want to cancel?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              color: Hexcolor('#3F4D55'),
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                        actions: <Widget>[
                          Row(
                            children: <Widget>[
                              GestureDetector(
                                child: Container(
                                  child: Image.asset(
                                    'assets/images/keepWorkingButton.png',
                                    height: 62,
                                    width: 157.5,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                              GestureDetector(
                                child: Container(
                                  child: Image.asset(
                                    'assets/images/cancelButton.png',
                                    height: 62,
                                    width: 157.5,
                                  ),
                                ),
                                onTap: () {},
                              )
                            ],
                          )
                        ],
                      );
                    });
              },
            ),
            Container(
              margin: EdgeInsets.only(left: 40),
              child: Text(
                'Tag People',
                style: TextStyle(
                  color: Hexcolor('#3F4D55'),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              constraints: BoxConstraints(
                  minWidth: 20, minHeight: 20, maxHeight: 20, maxWidth: 20),
              child: GestureDetector(
                child: Image.asset('assets/images/helpicon.png'),
              ),
            ),
            GestureDetector(
              child: Text(
                'Save',
                style: TextStyle(
                    color: Hexcolor('#3F4D55'),
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
              onTap: () {
                if (widget.children != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => ImageEditorOutfit(
                        children: widget.children,
                        mapOfCloth: mapCloth,
                        filePicture: widget.file,
                        clothNameList: clothNameList,
                        priceList: priceList,
                      ),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => ImageEditorOutfit(
                        children: children,
                        mapOfCloth: mapCloth,
                        filePicture: widget.file,
                        clothNameList: clothNameList,
                        priceList: priceList,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Hexcolor('#FBFBFB'),
        child: GestureDetector(
          onTap: () {
            getPositon();
          },
          onTapDown: (TapDownDetails details) {
            var x = details.globalPosition.dx;
            var y = details.globalPosition.dy;
            setState(() {
              getClothesDetail(x, y);
            });
            print("tap down: " + x.toString() + y.toString());
          },
          child: Stack(
            children: [
              Container(
                key: key,
                constraints: BoxConstraints(
                    maxWidth: 450,
                    maxHeight: 450,
                    minWidth: 450,
                    minHeight: 450),
                child: Image.file(
                  widget.file,
                  fit: BoxFit.cover,
                ),
              ),
              Stack(
                children: validate(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> validate() {
    if (widget.children != null) {
      return widget.children;
    } else {
      return children;
    }
  }

  Future getClothesDetail(var x, var y) async {
    Map results = await Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (BuildContext context) => new SuggestionClothes(),
      ),
    );
    if (results != null) {
      clothName = results['clothName'];
      category = results['category'];
      documentId = results['documentId'];
      price = results['price'];
      setState(() {
        if (category.length > clothName.length) {
          myRect = Offset(x, y - 80) &
              Size(category.length * 6 / 1, category.length * 6 / 3);
        } else {
          myRect = Offset(x, y - 80) &
              Size(clothName.length * 6 / 1, clothName.length * 6 / 3);
        }
        double priceParse;
        priceParse = double.parse(price);
        clothNameList.add(clothName);
        priceList.add(priceParse);
        children.add(
          new TagsPositioned(
            myRect: myRect,
            category: category,
            clothName: clothName,
            documentId: documentId,
          ),
        );
        mapCloth.putIfAbsent(documentId, () => myRect.toString());
      });
    } else {}
    // print(clothName + '\n' + category + '\n' + documentId);
    print(mapCloth);
  }
}
