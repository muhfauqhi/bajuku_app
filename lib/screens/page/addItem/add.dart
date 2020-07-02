import 'dart:io';

import 'package:bajuku_app/models/clothes.dart';
import 'package:bajuku_app/screens/home/home.dart';
import 'package:bajuku_app/screens/page/previewImage.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

class AddItemDialog extends StatefulWidget {
  final String flagAdd;
  final List<Clothes> clothesList;
  AddItemDialog({this.flagAdd, this.clothesList});
  @override
  _AddItemDialogState createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  File _image;

  Future getImageGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      if (_image != null) {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => new PreviewImage(
                      flagAdd: widget.flagAdd,
                      fileImage: _image,
                      method: 'Gallery',
                      clothesList: widget.clothesList,
                    )));
      } else {
        Navigator.of(context).pop();
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => new Home()));
      }
    });
  }

  Future getImageCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
      if (_image != null) {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => new PreviewImage(
                      flagAdd: widget.flagAdd,
                      fileImage: _image,
                      method: 'Camera',
                      clothesList: widget.clothesList,
                    )));
      } else {
        Navigator.of(context).pop();
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => new Home()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Hexcolor('#E1C8B4'),
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Column(
            children: <Widget>[
              SimpleDialogOption(
                onPressed: getImageCamera,
                child: Text(
                  'Take a picture',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal,
                    color: Hexcolor('#3F4D55'),
                  ),
                ),
              ),
              Divider(
                color: Colors.white,
                thickness: 1.0,
              ),
            ],
          ),
        ),
        Container(
          child: Column(
            children: <Widget>[
              SimpleDialogOption(
                onPressed: getImageGallery,
                child: Text(
                  'Choose from Album',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal,
                    color: Hexcolor('#3F4D55'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
