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
        automaticallyImplyLeading: false,
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
                    color: Hexcolor('#3F4D55'),
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
              onTap: () {
                if (widget.method == 'Camera') {
                } else {}
              },
            ),
            Container(
              margin: EdgeInsets.only(left: 15),
              child: Text(
                'Import Image',
                style: TextStyle(
                  color: Hexcolor('#3F4D55'),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            GestureDetector(
              child: Text(
                'Use Photo',
                style: TextStyle(
                    color: Hexcolor('#3F4D55'),
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
              onTap: () {
                Navigator.pop(context);
<<<<<<< HEAD
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
=======
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new ImageEditor(
                              filePicture: widget.fileImage,
                            )));
>>>>>>> f0fac72ea1f932111fb9c3286d32d33bac8751ec
              },
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Hexcolor('#FBFBFB'),
        child: Container(
<<<<<<< HEAD
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
=======
          constraints: BoxConstraints(
              maxWidth: 450, maxHeight: 450, minWidth: 450, minHeight: 450),
          child: Image.file(widget.fileImage, fit: BoxFit.cover),
>>>>>>> f0fac72ea1f932111fb9c3286d32d33bac8751ec
        ),
      ),
    );
  }
}
