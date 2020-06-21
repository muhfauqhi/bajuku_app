import 'package:bajuku_app/models/outfit.dart';
import 'package:bajuku_app/models/widgetrect.dart';
import 'package:bajuku_app/screens/home/home.dart';
import 'package:bajuku_app/screens/page/outfit/buildTags.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class TemplateDetailOutfit extends StatefulWidget {
  final Outfit outfit;

  TemplateDetailOutfit({this.outfit});
  @override
  _TemplateDetailOutfitState createState() => _TemplateDetailOutfitState();
}

class _TemplateDetailOutfitState extends State<TemplateDetailOutfit> {
  var formatter = new DateFormat('dd MMMM yyyy');
  List<Widget> children = [];

  Rect myRect;

  GlobalKey key = GlobalKey();

  void makeWidget() {
    var values = widget.outfit.taggedClothes.values.toList();
    // print(values.length);

    for (var i in values) {
      buildSplit(i);
    }

    var key = widget.outfit.taggedClothes.keys.toList();
    // for(var i in values){
    //   new TagsPositioned(myRect: ,);
    // }
  }

  void buildSplit(var str) {
    Rect rect;
    var substr = str.substring(15, str.length - 1);
    var left, top, right, bottom;
    List<String> splitted = substr.split(", ");
    for (int i = 0; i < splitted.length; i++) {
      left = double.parse(splitted[0]);
      top = double.parse(splitted[1]);
      right = double.parse(splitted[2]);
      bottom = double.parse(splitted[3]);
    }
    rect = Rect.fromLTRB(left, top, right, bottom);
    // rect = Rect.fromCenter()
    setState(() {
      children.add(
        new TagsPositioned(
          myRect: rect,
          clothName: '0',
          category: '0',
        ),
      );
    });
  }

  void getPosition() {
    final RenderBox renderBox = key.currentContext.findRenderObject();
    final position = renderBox.localToGlobal(Offset.zero);
    print(position);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            Container(
              child: SliverAppBar(
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Hexcolor('#3F4D55'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                iconTheme: IconThemeData(
                  color: Hexcolor('#3F4D55'),
                ),
                backgroundColor: Hexcolor('FBFBFB'),
                expandedHeight: 50.0,
                floating: false,
                pinned: false,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    'Journal',
                    style: TextStyle(
                      color: Hexcolor('#3F4D55'),
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: Container(
          child: buildContainerPhoto(),
        ),
      ),
    );
  }

  Container buildContainerRowTotalCost() {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            width: 200,
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Text(
              'Total Cost',
              style: TextStyle(fontSize: 16, color: Hexcolor('#859289')),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Text(
              '\$123',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Hexcolor('#859289')),
            ),
          )
        ],
      ),
    );
  }

  Container buildContainerRowOutfit() {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            width: 200,
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Text(
              'Outfit Name',
              style: TextStyle(fontSize: 16, color: Hexcolor('#859289')),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Text(
              'Working outfit1',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Hexcolor('#859289')),
            ),
          )
        ],
      ),
    );
  }

  Container buildContainerNotes() {
    return Container(
      width: 600,
      child: Container(
          margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Text("Start working again after WFH for so long")),
    );
  }

  Container buildContainerRowButton() {
    return Container(
      // color: Colors.red,
      width: 600,
      height: 50,
      margin: EdgeInsets.all(0),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 22),
            child: Text(
              formatter.format(DateTime.now()).toString(),
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
                color: Hexcolor('#3F4D55'),
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(left: 220),
              child: Image.asset('assets/images/shareButton.png'),
            ),
            onTap: () {},
          ),
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(left: 20),
              child: Image.asset('assets/images/optionButton.png'),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget buildContainerPhoto() {
    return GestureDetector(
      onTap: () {
        getPosition();
        makeWidget();
        // buildSplit();
      },
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  key: key,
                  constraints: BoxConstraints(
                      maxWidth: 450,
                      maxHeight: 450,
                      minWidth: 450,
                      minHeight: 450),
                  child: Image.network(
                    widget.outfit.image,
                    fit: BoxFit.fill,
                  ),
                ),
                buildContainerRowButton(),
                buildContainerNotes(),
                buildContainerRowOutfit(),
                buildContainerRowTotalCost(),
              ],
            ),
          ),
          Stack(
            children: children,
          ),
        ],
      ),
    );
  }
}
