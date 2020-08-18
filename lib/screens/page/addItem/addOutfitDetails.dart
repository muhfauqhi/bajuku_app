import 'dart:io';

import 'package:bajuku_app/screens/home/home.dart';
import 'package:bajuku_app/screens/page/image_editor/imageEditorOutfits.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddOutfitDetailScreen extends StatefulWidget {
  final File image;
  List<DragItem> children = [];

  AddOutfitDetailScreen({Key key, this.image, this.children}) : super(key: key);

  @override
  _AddOutfitDetailScreenState createState() => _AddOutfitDetailScreenState();
}

class _AddOutfitDetailScreenState extends State<AddOutfitDetailScreen> {
  final List<TextEditingController> _controller =
      List<TextEditingController>(5);
  Map<String, TextEditingController> _mapController = {};
  final _key = GlobalKey<FormState>();
  final DatabaseService _databaseService = DatabaseService();

  void fetchData() {
    int points = (widget.children.length * 3);
    int tagging = widget.children.length;
    _mapController = {
      'notes': _controller[0] = TextEditingController(),
      'tagging': _controller[1] =
          TextEditingController(text: tagging.toString() + ' clothes'),
      'name': _controller[2] = TextEditingController(),
      'cost': _controller[3] = TextEditingController(),
      'points': _controller[4] = TextEditingController(text: points.toString()),
    };
  }

  @override
  void initState() {
    super.initState();
    fetchData();
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
            return showDialog(
              context: context,
              child: buildShowDialogCancelFeedback(context),
            );
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: _key,
        child: ListView(
          children: <Widget>[
            buildInputNotes(),
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: Text(
                DateFormat('dd MMMM yyyy').format(DateTime.now()),
                style: TextStyle(
                  color: Color(0xff3F4D55),
                  fontSize: 12.0,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: <Widget>[
                  _buildTextFormField(
                    'Tagging',
                    true,
                    true,
                    _mapController['tagging'],
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12.0,
                      color: Color(0xffCEB39E),
                    ),
                  ),
                  _buildTextFormField(
                    'Outfit Name',
                    false,
                    false,
                    _mapController['name'],
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12.0,
                      color: Color(0xffCEB39E),
                    ),
                  ),
                  _buildTextFormField(
                    'Total Cost',
                    true,
                    false,
                    _mapController['cost'],
                    Icon(
                      Icons.info_outline,
                      size: 12.0,
                      color: Color(0xffCEB39E),
                    ),
                  ),
                  _buildTextFormField(
                    'Points Earned',
                    false,
                    true,
                    _mapController['points'],
                    Icon(
                      Icons.info_outline,
                      size: 12.0,
                      color: Color(0xffCEB39E),
                    ),
                  ),
                  SizedBox(height: 50.0),
                  FlatButton(
                    onPressed: () async {
                      String notes = _mapController['notes'].text;
                      String name = _mapController['name'].text;
                      String totalCost = _mapController['cost'].text;
                      List<Map<String, String>> taggedClothes = [];
                      Map<String, String> clothes = {};
                      widget.children.forEach((e) {
                        clothes = {
                          e.locationWidget.toString(): e.data.documentId,
                        };
                        taggedClothes.add(clothes);
                      });
                      if (_key.currentState.validate()) {
                        String image = await uploadPic();
                        if (image.isNotEmpty) {
                          await _databaseService.setOutfits(
                              notes, name, image, totalCost, taggedClothes);
                          for (var i in widget.children) {
                            String docId = i.data.documentId;
                            _databaseService.updateUsedInOutfit(docId);
                          }
                          _databaseService
                              .updatePoints(taggedClothes.length * 3);
                          showDialog(
                            context: context,
                            builder: (context) {
                              Future.delayed(Duration(seconds: 3), () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()));
                              });
                              return Image(
                                image: AssetImage(
                                    'assets/images/outfitsaveddialog.png'),
                              );
                            },
                          );
                        }
                      } else {}
                    },
                    child: Image(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/postButton.png'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
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
        controller: _mapController['notes'],
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

  Widget _buildTextFormField(String desc, bool isDark, bool readOnly,
      TextEditingController controller, Icon icon) {
    return TextFormField(
      validator: (val) {
        if (val.isEmpty) {
          return 'The $desc field is required';
        }
        return null;
      },
      onTap: readOnly
          ? () async {
              if (desc == 'Tagging') {
                var data = await getData();
                if (data != null) {
                  for (var i in data) {
                    setState(() {
                      widget.children = data;
                      fetchData();
                      i.draggable = false;
                    });
                  }
                }
              }
            }
          : null,
      style: TextStyle(
        fontSize: 12.0,
        color: desc == 'URL'
            ? Colors.blue
            : (desc == 'Color' ? Color(0xffFFFFFF) : Color(0xff3F4D55)),
      ),
      controller: controller,
      readOnly: readOnly,
      decoration: _inputDecoration(desc, isDark, icon),
    );
  }

  InputDecoration _inputDecoration(String desc, bool isDark, Icon icon) {
    return InputDecoration(
      suffixIcon: GestureDetector(
        child: icon,
        onTap: () {
          // TODO iconbutton
          print('test');
        },
      ),
      contentPadding: EdgeInsets.all(15.0),
      fillColor: isDark ? Color(0xffF8F6F4) : Color(0xffFFFFFF),
      filled: true,
      prefixText: desc == 'Total Cost' ? '€ ' : null,
      prefixStyle: TextStyle(
        fontSize: 12.0,
        color: Color(0xff3F4D55),
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
      prefixIcon: Container(
        width: 120.0,
        padding: EdgeInsets.fromLTRB(15.0, 15.0, 0, 15.0),
        child: Text(
          desc,
          style: TextStyle(
            color: Color(0xff3F4D55),
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Future<String> uploadPic() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference firebaseStrorageRef =
        FirebaseStorage.instance.ref().child('clothes/' + fileName);
    StorageUploadTask uploadTask = firebaseStrorageRef.putFile(widget.image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    var imageURL = await taskSnapshot.ref.getDownloadURL();
    if (uploadTask.isComplete) {
      String img = imageURL.toString();
      return img;
    } else {
      return '';
    }
  }

  Future getData() async {
    var results;
    for (var i in widget.children) {
      setState(() {
        i.draggable = true;
      });
    }
    if (widget.children.length < 0) {
      results = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TaggingScreen(
            image: widget.image,
          ),
        ),
      );
    } else {
      results = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TaggingScreen(
            image: widget.image,
            children: widget.children,
          ),
        ),
      );
    }
    return results;
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
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImageEditorOutifts(
                              image: widget.image,
                            ),
                          ),
                        );
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
