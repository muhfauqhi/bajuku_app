import 'dart:io';

import 'package:bajuku_app/screens/page/image_editor/imageEditorCloth.dart';
import 'package:bajuku_app/screens/page/image_editor/imageEditorOutfits.dart';
import 'package:flutter/material.dart';

class PreviewImage extends StatelessWidget {
  final File image;
  final String flag;

  const PreviewImage({Key key, this.image, this.flag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.only(right: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: Text(
                  'Retake',
                  style: TextStyle(
                      color: Color(0xff3F4D55),
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Text(
                  'Import Image',
                  style: TextStyle(
                    color: Color(0xff3F4D55),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              GestureDetector(
                child: Text(
                  'Use Photo',
                  style: TextStyle(
                      color: Color(0xff3F4D55),
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
                onTap: () {
                  if (flag == 'Wardrobe') {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => ImageEditor(filePicture: image)));
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageEditorOutifts(
                          image: image,
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        child: AspectRatio(
          aspectRatio: 0.85,
          child: Image(
            fit: BoxFit.cover,
            image: FileImage(image),
          ),
        ),
      ),
    );
  }
}
