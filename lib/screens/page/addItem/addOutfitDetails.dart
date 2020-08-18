import 'dart:io';

import 'package:flutter/material.dart';
import 'package:bajuku_app/screens/page/image_editor/imageEditorOutfits.dart';

class AddOutfitDetailScreen extends StatefulWidget {
  final File image;
  final List<DragItem> children;

  const AddOutfitDetailScreen({Key key, this.image, this.children})
      : super(key: key);

  @override
  _AddOutfitDetailScreenState createState() => _AddOutfitDetailScreenState();
}

class _AddOutfitDetailScreenState extends State<AddOutfitDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "New Journal",
          style: TextStyle(
            color: Color(0xff3F4D55),
            letterSpacing: 1,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color(0xff3F4D55),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: <Widget>[
          buildInputNotes(),
        ],
      ),
    );
  }

  Widget buildInputNotes() {
    return Container(
      padding: EdgeInsets.all(10.0),
      height: 120,
      color: Color(0xffF8F6F4),
      child: TextFormField(
        validator: (val) {
          if (val.isEmpty) {
            return 'The clothes name field is required';
          }
          return null;
        },
        style: TextStyle(
            color: Color(0xff3F4D55),
            letterSpacing: 1.0,
            fontSize: 12.0,
            fontStyle: FontStyle.italic),
        // controller: _controller[0],
        maxLines: 5,
        decoration: InputDecoration(
          hintText: 'Name of your outfits',
          hintStyle: TextStyle(
            color: Color(0xff3F4D55),
            letterSpacing: 1,
            fontSize: 12.0,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.italic,
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffF8F6F4),
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffF8F6F4),
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffF8F6F4),
            ),
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.all(8.0),
            child: GestureDetector(
              // TODO change image
              onTap: () {},
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                elevation: 3.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image(
                    height: 70.0,
                    width: 70.0,
                    fit: BoxFit.cover,
                    image: FileImage(
                      widget.image,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
