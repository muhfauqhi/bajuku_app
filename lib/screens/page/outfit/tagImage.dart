import 'dart:io';

import 'package:bajuku_app/models/clothes.dart';
import 'package:bajuku_app/screens/page/image_editor/imageEditorOutfit.dart';
import 'package:bajuku_app/screens/page/outfit/buildTags.dart';
import 'package:bajuku_app/screens/page/outfit/findSuggestionClothes.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TagImage extends StatefulWidget {
  final File file;
  final List<Widget> children;
  final List<Clothes> clothesList;

  TagImage({this.file, this.children, this.clothesList});

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
  Map mapCloth = Map();
  List<String> clothNameList = [];
  List<double> priceList = [];
  String rect;
  List<String> documentIdList = [];

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
                buildShowDialogCancelFeedback(context);
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
                Navigator.pop(context);
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
                        documentIdList: documentIdList,
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
                        documentIdList: documentIdList,
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
          onTapDown: (TapDownDetails details) {
            var x = details.globalPosition.dx;
            var y = details.globalPosition.dy;
            setState(() {
              getClothesDetail(x, y);
            });
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
    var results = await Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (BuildContext context) => new SuggestionClothes(
          clothesList: widget.clothesList,
        ),
      ),
    );
    if (results != null) {
      clothName = results.clothName;
      category = results.category
          .toString()
          .substring(1, results.category.toString().length - 1);
      documentId = results.documentId;
      price = results.price;
      setState(() {
        if (category.length > clothName.length) {
          myRect = Offset(x, y - 80) &
              Size(category.length * 6 / 1, category.length * 7 / 3);
        } else {
          myRect = Offset(x, y - 80) &
              Size(clothName.length * 6 / 1, clothName.length * 7 / 3);
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
        documentIdList.add(documentId);
        mapCloth.putIfAbsent(
            category,
            () =>
                myRect.center.dx.toString() +
                ',' +
                myRect.center.dy.toString() +
                ',' +
                myRect.size.toString());
      });
    } else {}
  }

  Future buildShowDialogCancelFeedback(BuildContext context) {
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
                    margin: EdgeInsets.only(top: 30, bottom: 40),
                    child: Image.asset(
                      'assets/images/textCancelFeedback.png',
                      width: 240,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          child: Image.asset(
                            'assets/images/keepWorkingButton.png',
                            width: 140,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        GestureDetector(
                          child: Image.asset(
                            'assets/images/cancelButton.png',
                            width: 140,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
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
}
