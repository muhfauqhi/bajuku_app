import 'dart:io';
import 'package:bajuku_app/screens/home/home.dart';
import 'package:bajuku_app/screens/page/addItem/dialogChipsCategories.dart';
import 'package:bajuku_app/screens/page/addItem/dialogChipsFabrics.dart';
import 'package:bajuku_app/screens/page/addItem/dialogChipsSeason.dart';
import 'package:bajuku_app/screens/page/image_editor/imageEditorCloth.dart';
import 'package:bajuku_app/screens/page/menu_burger/template/boxcolor.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class AddItemDetails extends StatefulWidget {
  final File fileUpload;
  AddItemDetails({this.fileUpload});
  @override
  _AddItemDetailsState createState() => _AddItemDetailsState();
}

class _AddItemDetailsState extends State<AddItemDetails> {
  final _formKey = GlobalKey<FormState>();
  List<TextEditingController> _controller = List<TextEditingController>(13);
  Map<String, dynamic> _mapController = {};
  bool loading = false;
  DateTime selectedDate = DateTime.now();
  Color currentColor = Colors.white;
  String status = 'Available';
  List<String> fabric = [];
  List<String> season = [];
  List<String> category = [];
  final _myController = TextEditingController();
  List<String> allStatus = [
    'Available',
    'Washing',
    'Given',
    'Sold',
    'Unavailable'
  ];

  void fetchData() {
    _mapController = {
      'clothName': _controller[0] = TextEditingController(),
      'date': _controller[1] = TextEditingController(
          text: DateFormat('dd MMMM yyyy').format(DateTime.now()).toString()),
      'fabric': _controller[2] = TextEditingController(),
      'brand': _controller[3] = TextEditingController(),
      'size': _controller[4] = TextEditingController(),
      'season': _controller[5] = TextEditingController(),
      'price': _controller[6] = TextEditingController(),
      'dateBought': _controller[7] = TextEditingController(),
      'color': _controller[8] = TextEditingController(
          text: currentColor
              .toString()
              .substring(10, currentColor.toString().length - 1)),
      'status': _controller[9] = TextEditingController(text: 'Available'),
      'category': _controller[10] = TextEditingController(),
      'url': _controller[11] = TextEditingController(),
      'notes': _controller[12] = TextEditingController(),
    };
  }

  String date;
  String dateBoughtFormatted;
  var now;
  var formatter;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    _myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFBFBFB),
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "Item Detail",
          style: TextStyle(
            color: Hexcolor('#3f4d55'),
            letterSpacing: 1,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Hexcolor('#3F4D55'),
          onPressed: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => new ImageEditor(
                          filePicture: widget.fileUpload,
                        )));
          },
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            constraints: BoxConstraints(
                minWidth: 25, minHeight: 25, maxHeight: 25, maxWidth: 25),
            child: GestureDetector(
              child: Image.asset('assets/images/helpicon.png'),
            ),
          )
        ],
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            // Clothes Name
            Container(
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
                controller: _mapController['clothName'],
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Name of your clothes',
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
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      elevation: 3.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Image.file(
                          widget.fileUpload,
                          height: 70.0,
                          width: 70.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: <Widget>[
                  _buildTextFormField(
                      'Date', true, true, _mapController['date']),
                  _buildTextFormField(
                      'Fabric', false, true, _mapController['fabric']),
                  _buildTextFormField(
                      'Brand', true, false, _mapController['brand']),
                  _buildTextFormField(
                      'Size', false, false, _mapController['size']),
                  _buildTextFormField(
                      'Season', true, true, _mapController['season']),
                  _buildTextFormField(
                      'Price', false, false, _mapController['price']),
                  _buildTextFormField(
                      'Date Bought', true, true, _mapController['dateBought']),
                  _buildTextFormField(
                      'Color', false, true, _mapController['color']),
                  _buildTextFormField(
                      'Status', true, true, _mapController['status']),
                  _buildTextFormField(
                      'Tags Category', false, true, _mapController['category']),
                  _buildTextFormField(
                      'URL', true, false, _mapController['url']),
                  _buildTextFormField(
                      'Notes', false, false, _mapController['notes']),
                ],
              ),
            ),
            SizedBox(height: 50.0),
            FlatButton(
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                String itemName = _mapController['clothName'].text;
                String brand = _mapController['brand'].text;
                String notes = _mapController['notes'].text;
                String size = _mapController['size'].text;
                String price = _mapController['price'].text;
                String url = _mapController['url'].text;
                  setState(() => loading = true);
                  String image = await uploadPic();
                  await DatabaseService().setClothes(
                      itemName,
                      brand,
                      fabric,
                      notes,
                      category,
                      size,
                      season,
                      price,
                      selectedDate,
                      currentColor.toString(),
                      status,
                      url,
                      image);
                  if (image != null) {
                    setState(() {
                      loading = false;
                      showDialog(
                        builder: (context) {
                          Future.delayed(Duration(seconds: 3), () {
                            // Navigator.of(context).pop(true);
                            Navigator.pushReplacement(
                                context,
                                new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new Home()));
                          });
                          return Image.asset(
                              'assets/images/itemsavedialog.png');
                        },
                        context: context,
                      );
                    });
                  }
                } else {
                  return null;
                }
              },
              child: Image(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/buttonSave.png'),
              ),
            ),
            SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField(String desc, bool isDark, bool readOnly,
      TextEditingController controller) {
    return TextFormField(
      validator: (val) {
        if (val.isEmpty) {
          return 'The $desc field is required';
        }
        return null;
      },
      onTap: readOnly
          ? () {
              if (desc == 'Fabric') {
                showDialog(
                  context: context,
                  child: DialogChipFabric(),
                ).then((value) {
                  setState(() {
                    fabric = DialogChipFabric().createState().getTags();
                    String text = getList(fabric);
                    _mapController['fabric'].text = text;
                  });
                });
              } else if (desc == 'Season') {
                showDialog(
                  context: context,
                  child: DialogChipSeason(),
                ).then((value) {
                  setState(() {
                    season = DialogChipSeason().createState().getTags();
                    String text = getList(season);
                    _mapController['season'].text = text;
                  });
                });
              } else if (desc == 'Tags Category') {
                showDialog(
                  context: context,
                  child: DialogChipCategories(),
                ).then((value) {
                  setState(() {
                    category = DialogChipCategories().createState().getTags();
                    String text = getList(category);
                    _mapController['category'].text = text;
                  });
                });
              } else if (desc == 'Date Bought') {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2015, 8),
                  lastDate: DateTime(2101),
                  confirmText: 'OK',
                  cancelText: '',
                  builder: (BuildContext context, Widget child) {
                    return Theme(
                      data: ThemeData.dark().copyWith(
                        colorScheme: ColorScheme.dark(
                          primary: Color(0xffDBBEA7),
                          onPrimary: Colors.white,
                          surface: Color(0xff3F4D55),
                          onSurface: Color(0xffDBBEA7),
                        ),
                        dialogBackgroundColor: Color(0xff3F4D55),
                      ),
                      child: child,
                    );
                  },
                ).then((value) {
                  setState(() {
                    selectedDate = value;
                    _mapController['dateBought'].text =
                        DateFormat('dd MMMM yyyy').format(value);
                  });
                });
              } else if (desc == 'Color') {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Select a color'),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: Hexcolor('FFFFFF'),
                          onColorChanged: (color) {
                            setState(() {
                              currentColor = color;
                              _mapController['color'].text = currentColor
                                  .toString()
                                  .substring(10, color.toString().length - 1);
                            });
                          },
                        ),
                      ),
                      actions: [
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset('assets/images/ok.png'),
                        ),
                      ],
                    );
                  },
                );
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
      decoration: _inputDecoration(desc, isDark),
    );
  }

  InputDecoration _inputDecoration(String desc, bool isDark) {
    return InputDecoration(
      prefix: desc == 'Color'
          ? BoxColor(color: _mapController['color'].text)
          : null,
      contentPadding: EdgeInsets.all(15.0),
      fillColor: isDark ? Color(0xffF8F6F4) : Color(0xffFFFFFF),
      filled: true,
      prefixText: desc == 'Price' ? '€ ' : null,
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

  String getList(List<String> list) {
    String text = '';
    for (var i in list) {
      text = text + i + '; ';
    }
    return text;
  }

  Future<String> uploadPic() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference firebaseStrorageRef =
        FirebaseStorage.instance.ref().child('clothes/' + fileName);
    StorageUploadTask uploadTask =
        firebaseStrorageRef.putFile(widget.fileUpload);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    var imageURL = await taskSnapshot.ref.getDownloadURL();
    if (uploadTask.isComplete) {
      String img = imageURL.toString();
      return img;
    } else {
      return null;
    }
  }
}
