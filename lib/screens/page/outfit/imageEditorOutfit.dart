import 'dart:io';
import 'dart:ui';

import 'package:bajuku_app/screens/home/home.dart';
import 'package:bajuku_app/screens/page/addOutfitDetail.dart';
import 'package:bajuku_app/screens/page/outfit/buildTags.dart';
import 'package:bajuku_app/screens/page/outfit/findSuggestionClothes.dart';
import 'package:bajuku_app/screens/page/outfit/navbarOutfit.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ImageEditorOutfit extends StatefulWidget {
  final File filePicture;

  ImageEditorOutfit({this.filePicture});

  @override
  _ImageEditorOutfitState createState() => _ImageEditorOutfitState();
}

class _ImageEditorOutfitState extends State<ImageEditorOutfit> {
  GlobalKey key = GlobalKey();

  String documentId;
  String clothName;
  String category;

  Rect myRect;
  List<Widget> children = [];

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
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              new Home()));
                                },
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
                Navigator.pop(context);
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new AddOutfitDetail(
                              fileUpload: widget.filePicture,
                            )));
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
          // onTapDown: (TapDownDetails details) {
            // var x = details.globalPosition.dx;
            // var y = details.globalPosition.dy;
            // setState(() {
            //   myRect = Offset(x, y - 80) & Size(50, 20);
            //   children.add(
            //     new TagsPositioned(
            //       myRect: myRect,
            //       category: category,
            //       clothName: clothName,
            //       documentId: documentId,
            //     ),
            //   );
            // });
            // print("tap down: " + x.toString() + y.toString());
          // },
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
                children: children,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavbarOutfit(file: widget.filePicture,),
    );
  }

  // Future getClothesDetail() async {
  //   Map results = await Navigator.push(
  //     context,
  //     new MaterialPageRoute(
  //       builder: (BuildContext context) => new SuggestionClothes(),
  //     ),
  //   );
  //   if (results.containsKey('clothName') &&
  //       results.containsKey('category') &&
  //       results.containsKey('documentId')) {
  //     clothName = results['clothName'];
  //     category = results['category'];
  //     documentId = results['documentId'];
  //   } else {
  //     Navigator.pop(context);
  //   }
  //   print(clothName + '\n' + category + '\n' + documentId);
  // }

}
