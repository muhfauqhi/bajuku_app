import 'dart:io';

import 'package:bajuku_app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ImageEditorOutifts extends StatelessWidget {
  final File image;

  const ImageEditorOutifts({Key key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: Text(
                'Cancel',
                style: TextStyle(
                    color: Color(0xff3F4D55),
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
              onTap: () {
                return showDialog(
                  context: context,
                  child: buildShowDialogCancelFeedback(context),
                );
              },
            ),
            Container(
              margin: EdgeInsets.only(left: 15),
              child: Text(
                'Edit Image',
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
              onTap: () {},
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.85,
            child: Image(
              fit: BoxFit.cover,
              image: FileImage(image),
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            child: Text(
              DateFormat('dd MMMM yyyy').format(DateTime.now()),
            ),
          ),
          SizedBox(height: 20.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15.0),
                color: Color(0xffE1C8B4).withOpacity(0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _buildIcon('bi_brightness-high'),
                    _buildIcon('crop'),
                    _buildIcon('ion_contrast'),
                    _buildIcon('uil_temperature'),
                    _buildIcon('cil_drop'),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(15.0),
                color: Color(0xffFFFFFF),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _buildIcon('uil_image-edit'),
                    _buildIcon('cil_tags', context: context),
                    _buildIcon('undo'),
                    _buildIcon('redo'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(String asset, {BuildContext context}) {
    return GestureDetector(
      onTap: () {
        if (context != null) {
          return showDialog(
              context: context,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Card(
                      elevation: 0.0,
                      child: TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 10.0,
                          ),
                          prefixIcon: GestureDetector(
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                          ),
                          hintText: 'Search for a clothes',
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffFFFFFF),
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffFFFFFF),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffFFFFFF),
                            ),
                          ),
                          suffixIcon: GestureDetector(
                            child: Icon(
                              Icons.close,
                              color: Colors.black,
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      'https://stockx.imgix.net/products/streetwear/Supreme-Box-Logo-Hoodie-Heather-Grey.jpg?fit=fill&bg=FFFFFF&w=700&h=500&auto=format,compress&q=90&dpr=2&trim=color&updated_at=1538080256'),
                                ),
                                SizedBox(width: 40.0),
                                Card(
                                  elevation: 0.0,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Text(
                                        'Supreme Hoodie',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.0,
                                          color: Color(0xff3F4D55),
                                        ),
                                      ),
                                      Text(
                                        'Hoodie and Jackets',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: Color(0xff859289),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ));
        } else {
          return null;
        }
      },
      child: Image(
        height: asset == 'redo' || asset == 'undo' ? 25 : 30,
        fit: BoxFit.cover,
        image: AssetImage('assets/images/$asset.png'),
      ),
    );
  }

  Widget buildShowDialogCancelFeedback(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      contentPadding: EdgeInsets.only(top: 0.0),
      children: <Widget>[
        Container(
          color: Colors.transparent,
          width: 280,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 30, bottom: 40),
                child: Image.asset(
                  'assets/images/textCancelFeedback.png',
                  width: 240,
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Image.asset(
                        'assets/images/keepWorkingButton.png',
                        width: 140,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    GestureDetector(
                      child: Image.asset(
                        'assets/images/cancelButton.png',
                        width: 140,
                      ),
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
