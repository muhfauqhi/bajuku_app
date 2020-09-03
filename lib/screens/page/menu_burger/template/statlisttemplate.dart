import 'package:bajuku_app/screens/page/menu_burger/template/boxcolor.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class StatsListTemplate extends StatelessWidget {
  final String widget;
  final String color;
  final double marginTop;
  final String titleText;
  final String subtitleText;
  final TextStyle customTextStyle;
  final Function function;

  StatsListTemplate({
    Key key,
    this.widget,
    this.color,
    this.marginTop,
    this.titleText,
    this.subtitleText,
    this.customTextStyle,
    this.function,
  }) : super(key: key);

  final DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          child: Container(
            color: Hexcolor(color),
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: marginTop),
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Container(
                    margin: EdgeInsets.only(left: 25.0),
                    child: setWidget(),
                  ),
                ),
                buildButtonRight(),
              ],
            ),
          ),
          onTap: () {
            function();
          },
        ),
        Text(''),
      ],
    );
  }

  Widget setWidget() {
    switch (widget) {
      case 'color':
        return buildColor();
        break;
      case 'normal':
        return buildNormal();
        break;
      case 'custom':
        return buildCustom();
        break;
      default:
        return Text('');
        break;
    }
  }

  Widget buildCustom() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$titleText',
          style: myTextStyle(
              FontWeight.w800, 20.0, FontStyle.normal, '#3F4D55', 1.0),
        ),
        Text(
          '$subtitleText',
          style: customTextStyle,
        ),
      ],
    );
  }

  Widget buildNormal() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$titleText',
          style: myTextStyle(
              FontWeight.w800, 20.0, FontStyle.normal, '#3F4D55', 1.0),
        ),
        Text(
          '$subtitleText',
          style: myTextStyle(
              FontWeight.normal, 12.0, FontStyle.normal, '#9D9D9D', 1.0),
        ),
      ],
    );
  }

  Widget buildColor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color Storage',
          style: myTextStyle(
              FontWeight.w800, 20.0, FontStyle.normal, '#3F4D55', 1.0),
        ),
        FutureBuilder(
          future: databaseService.getTotalClothes(),
          builder: (contex, snapshot) {
            if (!snapshot.hasData) {
              return Text('');
            } else {
              List<String> listOfColors = [];
              for (var i in snapshot.data.documents) {
                if (listOfColors.contains(i.data['color'])) {
                } else {
                  listOfColors.add(i.data['color']);
                }
              }
              return Container(
                margin: EdgeInsets.only(top: 5.0),
                child: Text(
                  '${listOfColors.length} Colors',
                  style: myTextStyle(FontWeight.normal, 12.0, FontStyle.normal,
                      '#E1C8B4', 0.0),
                ),
              );
            }
          },
        ),
        Container(
          margin: EdgeInsets.only(top: 10.0, left: 5.0),
          child: FutureBuilder(
            future: databaseService.getTotalClothes(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text('');
              } else {
                List<String> listOfColors = [];
                List<Widget> boxColors = [];
                for (var i in snapshot.data.documents) {
                  if (listOfColors.contains(i.data['color'])) {
                  } else {
                    listOfColors.add(i.data['color']);
                  }
                }
                for (var i in listOfColors) {
                  boxColors.add(
                    BoxColor(
                      color: i.substring(10, i.length - 1),
                    ),
                  );
                  if (boxColors.length > 9) {
                    boxColors.removeLast();
                  }
                }
                return Row(
                  children: boxColors,
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget buildButtonRight() {
    return Container(
      child: IconButton(
        icon: Icon(Icons.chevron_right),
        color: Hexcolor('#3F4D55'),
        iconSize: 30.0,
        onPressed: () {
          function();
        },
      ),
    );
  }

  TextStyle myTextStyle(FontWeight fontWeight, double fontSize,
      FontStyle fontStyle, String color, double letterSpacing) {
    return TextStyle(
      fontSize: fontSize,
      fontStyle: fontStyle,
      color: Hexcolor('$color'),
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
    );
  }
}
