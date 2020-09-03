import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MyScaffold extends StatelessWidget {
  final Widget body;
  final List<Widget> headerWidget;
  final String title;
  final Widget bottomNavigationBar;
  final bool titleStyle;
  final TextStyle titleTextStyle;
  final bool leadingActive;
  final List<Widget> actions;
  final Widget floatingActionButton;
  final bool isTitleWidget;
  final Widget titleWidget;

  MyScaffold({
    Key key,
    this.body,
    this.headerWidget,
    this.title,
    this.bottomNavigationBar,
    this.titleTextStyle,
    this.titleStyle = false,
    this.leadingActive = true,
    this.actions,
    this.floatingActionButton,
    this.isTitleWidget = true,
    this.titleWidget,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: false,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            Container(
              child: SliverAppBar(
                actions: actions,
                centerTitle: true,
                leading: leading(context),
                backgroundColor: Hexcolor('FBFBFB'),
                expandedHeight: 50.0,
                floating: false,
                pinned: false,
                title: isTitleWidget
                    ? titleWithStyle(title, titleTextStyle)
                    : titleWidget,
                // flexibleSpace: FlexibleSpaceBar(
                //   centerTitle: true,
                //   title: isTitleWidget
                //       ? titleWithStyle(title, titleTextStyle)
                //       : titleWidget,
                // ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  Container(
                    child: Column(
                      children: headerWidget,
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        body: body,
      ),
    );
  }

  Widget leading(var context) {
    return leadingActive
        ? IconButton(
            icon: Icon(Icons.arrow_back),
            color: Hexcolor('#3F4D55'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        : Container();
  }

  Widget titleWithStyle(var title, var titleTextStyle) {
    return titleStyle
        ? Text(
            title,
            style: titleTextStyle,
          )
        : Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              letterSpacing: 1.0,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              color: Hexcolor('#3F4D55'),
            ),
          );
  }
}
