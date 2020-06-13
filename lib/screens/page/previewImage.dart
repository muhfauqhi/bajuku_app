import 'dart:io';

import 'package:bajuku_app/screens/home/bottomnavigationbar.dart';
import 'package:bajuku_app/screens/page/imageEditor.dart';
import 'package:bajuku_app/screens/page/imageEditorOutfit.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class PreviewImage extends StatefulWidget {
  final File fileImage;
  final String method;
  final String flagAdd;
  PreviewImage({this.fileImage, this.method, this.flagAdd});

  @override
  _PreviewImageState createState() => _PreviewImageState();
}

class _PreviewImageState extends State<PreviewImage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      bottomNavigationBar: CustomBottomNavigationBar(),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: Text(
                'Retake',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
              onTap: () {
                if (widget.method == 'Camera') {
                } else {}
              },
            ),
            Text(
              'Import Image',
              style: TextStyle(color: Colors.black),
            ),
            GestureDetector(
              child: Text(
                'Use Photo',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
              onTap: () {
                Navigator.pop(context);
                if (widget.flagAdd == 'Wardrobe') {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new ImageEditor(
                                filePicture: widget.fileImage,
                              )));
                } else {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new ImageEditorOutfit(
                                filePicture: widget.fileImage,
                              )));
                }
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
                width: 500,
                height: 550,
                child: Image.file(widget.fileImage, fit: BoxFit.fill),
              ),
              // RaisedButton(
              //     child: Text("Save"),
              //     onPressed: () {
              //       showDialog(
              //           context: context,
              //           builder: (context) {
              //             return AlertDialog(
              //               title: Text("Are you sure?"),
              //               actions: <Widget>[
              //                 FlatButton(
              //                   child: Text("No"),
              //                   onPressed: () {
              //                     Navigator.pop(context);
              //                   },
              //                 ),
              //                 FlatButton(
              //                   child: Text("Yes"),
              //                   onPressed: () {
              //                     Navigator.pop(context);
              //                     Navigator.push(
              //                         context,
              //                         new MaterialPageRoute(
              //                             builder: (BuildContext context) =>
              //                                 new AddItem(
              //                                   fileUpload: widget.fileImage,
              //                                 )));
              //                   },
              //                 )
              //               ],
              //             );
              //           });
              //     })
            ],
          ),
        ),
      ),
    );
  }
}
