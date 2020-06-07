import 'dart:io';
import 'package:bajuku_app/screens/page/imageEditor.dart';
import 'package:bajuku_app/screens/page/onboarding_login.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddItemDialog extends StatefulWidget {
  @override
  _AddItemDialogState createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  File _image;

  Future _getImageGallery() async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      print('_image: $_image');
       Navigator.of(context).pop();
                  Navigator.push(context, new MaterialPageRoute(
                      builder: (BuildContext context) => new ImageEditor(fileImage: _image,)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      // useMaterialBorderRadius: true,
      children: <Widget>[
          SimpleDialogOption(
            onPressed: () {},
            child: const Text('Take a picture'),
          ),
          SimpleDialogOption(
            onPressed: _getImageGallery,
            child: const Text('Choose From Album'),
          ),
          SimpleDialogOption(
            onPressed: () {
             
            },
            child: const Text('Take Multiple Photos'),
          ),
      ],
    );
  }
}