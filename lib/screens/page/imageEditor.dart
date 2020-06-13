import 'dart:io';

import 'package:bajuku_app/screens/home/home.dart';
import 'package:bajuku_app/screens/page/addItemDetail.dart';
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
                          FlatButton(
                            child: Image.asset(
                              'assets/images/keepWorkingButton.png',
                              height: 62,
                              width: 135,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          FlatButton(
                            child: Image.asset(
                              'assets/images/cancelButton.png',
                              height: 62,
                              width: 135,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          new Home()));
                            },
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
                        minWidth: 20,
                        minHeight: 20,
                        maxHeight: 20,
                        maxWidth: 20),
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
}
