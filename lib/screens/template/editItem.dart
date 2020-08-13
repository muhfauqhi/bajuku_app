import 'package:bajuku_app/models/clothes.dart';
import 'package:bajuku_app/screens/page/addItem/dialogChipsCategories.dart';
import 'package:bajuku_app/screens/page/addItem/dialogChipsFabrics.dart';
import 'package:bajuku_app/screens/page/addItem/dialogChipsSeason.dart';
import 'package:bajuku_app/screens/page/menu_burger/template/boxcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class EditItemScreen extends StatefulWidget {
  final Clothes clothes;

  EditItemScreen({Key key, this.clothes}) : super(key: key);

  @override
  _EditItemScreenState createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final _key = GlobalKey<FormState>();
  List<TextEditingController> _controller = List<TextEditingController>(12);
  String status = '';
  List<String> fabric = [];
  List<String> season = [];
  List<String> category = [];
  DateTime selectedDate = DateTime.now();
  Color currentColor = Colors.white;

  List<String> _statusMenu = [
    'Available',
    'Washing',
    'Given',
    'Sold',
    'Unavailable'
  ];

  void fetchData() {
    _controller[0] = TextEditingController(text: widget.clothes.clothName);
    _controller[1] = TextEditingController(
        text: DateFormat('dd MMMM yyyy')
            .format(widget.clothes.startDate.toDate())
            .toString());
    _controller[2] = TextEditingController(
        text: widget.clothes.fabric
            .toString()
            .substring(1, widget.clothes.fabric.toString().length - 1));
    _controller[3] = TextEditingController(text: widget.clothes.brand);
    _controller[4] = TextEditingController(text: widget.clothes.size);
    _controller[5] = TextEditingController(
        text: widget.clothes.season
            .toString()
            .substring(1, widget.clothes.season.toString().length - 1));
    _controller[6] = TextEditingController(text: widget.clothes.price);
    _controller[7] = TextEditingController(
        text: DateFormat('dd MMMM yyyy')
            .format(widget.clothes.dateBought.toDate())
            .toString());
    _controller[8] = TextEditingController(
        text: widget.clothes.color
            .toString()
            .substring(10, widget.clothes.color.toString().length - 1));
    status = widget.clothes.status;
    _controller[9] = TextEditingController(
        text: widget.clothes.category
            .toString()
            .substring(1, widget.clothes.category.toString().length - 1));
    _controller[10] =
        TextEditingController(text: widget.clothes.url.toString());
    _controller[11] =
        TextEditingController(text: widget.clothes.notes.toString());

    currentColor = Hexcolor(_controller[8].text);
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFBFBFB),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xff3F4D55),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Edit Item Detail',
          style: TextStyle(
            color: Color(0xff3F4D55),
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffFBFBFB),
        elevation: 0.0,
      ),
      body: Form(
        key: _key,
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
                controller: _controller[0],
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
                          child: ColorFiltered(
                            colorFilter: status == 'Sold' || status == 'Given'
                                ? ColorFilter.mode(Colors.grey, BlendMode.color)
                                : ColorFilter.mode(
                                    Colors.transparent, BlendMode.color),
                            child: Image(
                              height: 70.0,
                              width: 70.0,
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                widget.clothes.image,
                              ),
                            ),
                          ),
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
                  _buildTextFormField('Date', true, true, _controller[1]),
                  _buildTextFormField('Fabric', false, true, _controller[2]),
                  _buildTextFormField('Brand', true, false, _controller[3]),
                  _buildTextFormField('Size', false, false, _controller[4]),
                  _buildTextFormField('Season', true, true, _controller[5]),
                  _buildTextFormField('Price', false, false, _controller[6]),
                  _buildTextFormField(
                      'Date Bought', true, true, _controller[7]),
                  _buildTextFormField('Color', false, true, _controller[8]),
                  _buildDropdownButtonFormField(),
                  _buildTextFormField(
                      'Tags Category', false, true, _controller[9]),
                  _buildTextFormField('URL', true, false, _controller[10]),
                  _buildTextFormField('Notes', false, false, _controller[11]),
                ],
              ),
            ),
            SizedBox(height: 50.0),
            FlatButton(
              onPressed: () {
                if (_key.currentState.validate()) {
                  print('yes');
                } else {
                  print('no');
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

  DropdownButtonFormField<String> _buildDropdownButtonFormField() {
    return DropdownButtonFormField<String>(
      value: status,
      hint: status == 'Sold' || status == 'Given'
          ? Text(
              status,
              style: TextStyle(
                fontSize: 12.0,
                color: status == 'Sold' || status == 'Given'
                    ? Color(0xffD96969)
                    : Color(0xff3F4D55),
              ),
            )
          : null,
      decoration: _inputDecoration('Status', true),
      items: _statusMenu
          .map(
            (label) => DropdownMenuItem(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12.0,
                  color: label == 'Sold' || label == 'Given'
                      ? Color(0xffD96969)
                      : Color(0xff3F4D55),
                ),
              ),
              value: label,
            ),
          )
          .toList(),
      onChanged: status == 'Sold' || status == 'Given'
          ? null
          : (val) {
              status = val;
            },
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
                    _controller[2].text = text;
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
                    _controller[5].text = text;
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
                    _controller[9].text = text;
                  });
                });
              } else if (desc == 'Date Bought') {
                showDatePicker(
                  context: context,
                  initialDate: widget.clothes.dateBought.toDate(),
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
                    _controller[7].text =
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
                          pickerColor: Hexcolor(_controller[8].text),
                          onColorChanged: (color) {
                            setState(() {
                              currentColor = color;
                              _controller[8].text = currentColor
                                  .toString()
                                  .substring(
                                      10,
                                      widget.clothes.color.toString().length -
                                          1);
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
      prefix: desc == 'Color' ? BoxColor(color: _controller[8].text) : null,
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
}
