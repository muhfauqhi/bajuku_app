import 'dart:io';
import 'dart:ui';

import 'package:bajuku_app/models/clothes.dart';
import 'package:bajuku_app/screens/page/addItem/addOutfitDetail.dart';
import 'package:bajuku_app/screens/page/outfit/navbarOutfit.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ImageEditorOutfit extends StatefulWidget {
  final File filePicture;
  final Map mapOfCloth;
  final List<Widget> children;
  final List<String> clothNameList;
  final List<double> priceList;
  final Map<dynamic, dynamic> tagged;
  final List<Clothes> clothesList;

  ImageEditorOutfit(
      {this.filePicture,
      this.mapOfCloth,
      this.children,
      this.clothNameList,
      this.priceList,
      this.tagged,
      this.clothesList});

  @override
  _ImageEditorOutfitState createState() => _ImageEditorOutfitState();
}

class _ImageEditorOutfitState extends State<ImageEditorOutfit> {
  GlobalKey key = GlobalKey();

  String documentId;
  String clothName;
  String category;

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
                'Import Image',
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
                if (widget.mapOfCloth != null) {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new AddOutfitDetail(
                                tagged: widget.tagged,
                                fileUpload: widget.filePicture,
                                clothNameList: widget.clothNameList,
                                mapOfCloth: widget.mapOfCloth,
                                priceList: widget.priceList,
                              )));
                } else {
                  return showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SimpleDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          contentPadding: EdgeInsets.only(top: 0.0),
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 35),
                              height: 100,
                              child: Text(
                                "Please Tag At Least One Item ",
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        );
                      });
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
                  widget.filePicture,
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
      bottomNavigationBar: CustomNavbarOutfit(
        clothesList: widget.clothesList,
        file: widget.filePicture,
        children: widget.children,
      ),
    );
  }

  List<Widget> validate() {
    if (widget.children != null) {
      return widget.children;
    } else {
      return [];
    }
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
