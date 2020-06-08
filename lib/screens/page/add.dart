import 'dart:io';
import 'package:bajuku_app/screens/home/homescreen.dart';
import 'package:bajuku_app/screens/page/previewImage.dart';
import 'package:bajuku_app/screens/page/onboarding_login.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddItemDialog extends StatefulWidget {
  @override
  _AddItemDialogState createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  File _image;

  Future getImageGallery() async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      if(_image!=null){
      print('_image: $_image');
       Navigator.of(context).pop();
                  Navigator.push(context, new MaterialPageRoute(
                      builder: (BuildContext context) => new PreviewImage(fileImage: _image, method: 'Gallery',)));
      }else{
        Navigator.of(context).pop();
                  Navigator.push(context, new MaterialPageRoute(
                      builder: (BuildContext context) => new HomeScreen()));
      }
    });
  }

  Future getImageCamera() async{
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
      if(_image!=null){
      print('_image: $_image');
       Navigator.of(context).pop();
                  Navigator.push(context, new MaterialPageRoute(
                      builder: (BuildContext context) => new PreviewImage(fileImage: _image, method: 'Camera',)));
      }else{
        Navigator.of(context).pop();
                  Navigator.push(context, new MaterialPageRoute(
                      builder: (BuildContext context) => new HomeScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      // useMaterialBorderRadius: true,
      children: <Widget>[
          SimpleDialogOption(
            onPressed: getImageCamera,
            child: const Text('Take a picture'),
          ),
          SimpleDialogOption(
            onPressed: getImageGallery,
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