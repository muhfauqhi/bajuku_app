import 'dart:io';
import 'package:bajuku_app/screens/home/homescreen.dart';
import 'package:bajuku_app/screens/page/addItem.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ImageEditor extends StatefulWidget {
  final File fileImage;
  ImageEditor({this.fileImage});

  @override
  _ImageEditorState createState() => _ImageEditorState();
}

class _ImageEditorState extends State<ImageEditor> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Hexcolor('#3F4D55'),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => new HomeScreen()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              ButtonBar(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.flip),
                    onPressed: null,
                  ),
                  IconButton(icon: Icon(Icons.crop), onPressed: null),
                ],
              ),
              Image.file(widget.fileImage),
              RaisedButton(
                child: Text("Save"),
                onPressed: () {
                //  new  AlertDialog(
                //     backgroundColor: Colors.blue,
                //     elevation: 24.0,
                //     shape: CircleBorder(),
                //     title: Text("Are you sure?"),
                //     actions: [
                //       FlatButton(
                //         child: Text("No"),
                //         onPressed: (){

                //         }
                //       ),
                //       FlatButton(
                //         child: Text("Yes"),
                //         onPressed: (){
                          
                //         }
                //       )
                //     ],
                //   );

                  showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        title: Text("Are you sure?"),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("No"),
                            onPressed: (){
                              Navigator.pop(context);
                            },
                          ),
                          FlatButton(
                            child: Text("Yes"),
                            onPressed: (){
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (BuildContext context) => new AddItem(fileUpload: widget.fileImage,)));
                            },
                          )
                        ],
                      );
                    }
                  );
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
