import 'dart:io';

import 'package:bajuku_app/screens/home/home.dart';
import 'package:bajuku_app/screens/page/addItem/addItemDetail.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ImageEditor extends StatefulWidget {
  final File filePicture;
  ImageEditor({this.filePicture});

  @override
  _ImageEditorState createState() => _ImageEditorState();
}

class _ImageEditorState extends State<ImageEditor> {
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
                Navigator.pop(context);
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new AddItemDetail(
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
        child: Column(
          children: <Widget>[
            Container(
              constraints: BoxConstraints(
                  maxWidth: 450, maxHeight: 450, minWidth: 450, minHeight: 450),
              child: Image.file(
                widget.filePicture,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
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
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new Home()));
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
