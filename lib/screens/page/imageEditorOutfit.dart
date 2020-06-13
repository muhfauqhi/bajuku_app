import 'dart:io';

import 'package:bajuku_app/screens/home/home.dart';
import 'package:bajuku_app/screens/page/addItemDetail.dart';
import 'package:bajuku_app/screens/page/addOutfitDetail.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ImageEditorOutfit extends StatefulWidget {
  final File filePicture;
  ImageEditorOutfit({this.filePicture});

  @override
  _ImageEditorOutfitState createState() => _ImageEditorOutfitState();
}

class _ImageEditorOutfitState extends State<ImageEditorOutfit> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
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
                    color: Colors.black,
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
            Text(
              'Import Image',
              style: TextStyle(color: Colors.black),
            ),
            GestureDetector(
              child: Text(
                'Save',
                style: TextStyle(
                    color: Colors.black,
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
      body: SingleChildScrollView(
        child: Container(
          color: Hexcolor('#FBFBFB'),
          child: Column(
            children: <Widget>[
              Container(
                height: 550,
                width: 500,
                child: Image.file(
                  widget.filePicture,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
