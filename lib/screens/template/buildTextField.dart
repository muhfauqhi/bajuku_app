import 'package:bajuku_app/models/clothes.dart';
import 'package:bajuku_app/models/outfit.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class BuildTextField extends StatefulWidget {
  final String color;
  final String desc;
  final bool enabled;
  final String widget;
  final Clothes clothes;
  final Outfit outfit;
  final String type;
  final Function onChanged;
  final Function onTap;
  final controller;

  BuildTextField({
    Key key,
    this.color,
    this.desc,
    this.enabled,
    this.widget,
    this.clothes,
    this.outfit,
    this.type,
    this.onChanged,
    this.onTap,
    this.controller,
  }) : super(key: key);

  @override
  _BuildTextFieldState createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends State<BuildTextField> {
  final format = new DateFormat('dd MMMM yyyy');
  final DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    switch (widget.widget) {
      case 'notes':
        if (widget.type == 'Outfit') {
          return _buildNotes(widget.outfit.outfitName, widget.outfit.image);
        } else {
          return _buildNotes(widget.clothes.clothName, widget.clothes.image);
        }
        break;
      case 'date':
        return _buildDate();
        break;
      case 'sizedOfBox':
        return _buildSpace();
        break;
      case 'button':
        if (widget.type == 'Given') {
          return _buildButton('givethis');
        } else {
          return _buildButton('sellthis');
        }
        break;
      default:
        return _buildText(widget.color, widget.widget);
    }
  }

  Widget _buildButton(var asset) {
    return GestureDetector(
      child: Image.asset(
        'assets/images/$asset.png',
        width: 350,
      ),
      onTap: widget.onTap,
    );
  }

  Widget _buildNotes(var type, var typeImage) {
    return Container(
      child: TextFormField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        maxLines: 5,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: const Color(0xF8F6F4))),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: const Color(0xF8F6F4))),
          filled: true,
          fillColor: Hexcolor('#F8F6F4'),
          labelText: type,
          labelStyle: textStyle(
            14.0,
            '#3F4D55',
            FontWeight.bold,
          ),
          contentPadding: EdgeInsets.fromLTRB(60, 30, 0, 0),
          hintText: 'Write your product description here',
          hintStyle: textStyle(
            12.0,
            '#9D9D9D',
            FontWeight.normal,
            FontStyle.italic,
            1.0,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.fromLTRB(21, 22, 24, 28),
            child: Card(
              child: Image.network(
                typeImage,
                height: 70.0,
                width: 70.0,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildText(var color, var hintText) {
    return Container(
      margin: EdgeInsets.only(left: 25.0, right: 25.0),
      color: Hexcolor(color),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 8.0),
            width: 100,
            child: Text(
              widget.desc,
              style: textStyle(12.0, '#3F4D55', FontWeight.bold),
            ),
          ),
          widget.enabled
              ? textFieldEnabled(color)
              : textFieldDisabled(color, hintText),
        ],
      ),
    );
  }

  Widget _buildDate() {
    return Container(
      margin: EdgeInsets.only(left: 35.0, top: 20.0, bottom: 20.0),
      alignment: Alignment(-1, 0),
      child: Text(
        format.format(DateTime.now()),
        style: textStyle(12.0, '#3F4D55'),
      ),
    );
  }

  Widget textFieldEnabled(var color) {
    if (widget.desc == 'Price') {
      return Expanded(
        child: Container(
          child: TextFormField(
            controller: widget.controller,
            onChanged: widget.onChanged,
            keyboardType: TextInputType.number,
            style: textStyle(12.0, '#3F4D55'),
            decoration: InputDecoration(
              prefixText: '€ ',
              prefixStyle: textStyle(12.0, '#3F4D55'),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: const Color(0xF8F6F4))),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: const Color(0xF8F6F4))),
            ),
          ),
        ),
      );
    } else {
      return Expanded(
        child: Container(
          child: TextFormField(
            controller: widget.controller,
            onChanged: widget.onChanged,
            style: textStyle(12.0, '#3F4D55'),
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: const Color(0xF8F6F4))),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: const Color(0xF8F6F4))),
            ),
          ),
        ),
      );
    }
  }

  Widget textFieldDisabled(var color, var hintText) {
    return Expanded(
      child: Container(
        child: TextFormField(
          style: textStyle(12.0, '#3F4D55'),
          decoration: InputDecoration(
            enabled: false,
            hintText: hintText,
            contentPadding: EdgeInsets.only(right: 10.0),
            hintStyle: textStyle(12.0, '#3F4D55'),
            filled: true,
            fillColor: Hexcolor(color),
          ),
        ),
      ),
    );
  }

  TextStyle textStyle(var fontsize, var color,
      [FontWeight fontWeight, FontStyle fontStyle, var letterSpacing]) {
    return TextStyle(
      color: Hexcolor(color),
      letterSpacing: letterSpacing,
      fontSize: fontsize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
    );
  }

  Widget _buildSpace() {
    return SizedBox(
      height: 50.0,
    );
  }
}
