import 'package:bajuku_app/screens/page/sustainability/sustainabilitywidget/addgiveorsell.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HeaderWidgetSustainability extends StatelessWidget {
  final String asset;
  final String title;
  final bool headerButton;
  final bool titleActive;
  HeaderWidgetSustainability(
      {this.asset, this.title, this.headerButton, this.titleActive});

  @override
  Widget build(BuildContext context) {
    return headerButton ? buildButton(context) : buildTitleWidget();
  }

  Widget buildButton(var context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          child: GestureDetector(
            child: Image.asset(
              'assets/images/$asset',
              height: 50,
            ),
            onTap: () {
              showDialog(
                context: context,
                child: SimpleDialogAddGiveOrSell(),
              );
            },
          ),
        ),
        buildTitleWidget(),
      ],
    );
  }

  Widget buildTitle(var left) {
    return Container(
      width: 340,
      margin: EdgeInsets.only(left: left, top: 12),
      child: Text(
        '$title',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0,
          color: Hexcolor('#3F4D55'),
        ),
      ),
    );
  }

  Widget buildTitleWidget() {
    return titleActive
        ? buildTitle(0.0)
        : Column(
            children: [
              Divider(
                color: Hexcolor('#FFFFFF'),
                thickness: 2.0,
              ),
              Row(
                children: <Widget>[
                  buildTitle(25.0),
                  Container(
                    margin: EdgeInsets.only(top: 12),
                    child: Image.asset(
                      'assets/images/jam_settings-alt.png',
                      height: 25,
                    ),
                  )
                ],
              ),
            ],
          );
  }
}
