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
  var notes, totalCost, outfitName;

  Rect myRect;

  GlobalKey key = GlobalKey();

  @override
  void initState() {
    notes = widget.outfit.notes;
    totalCost = widget.outfit.totalCost;
    outfitName = widget.outfit.outfitName;
    super.initState();
  }

  void makeWidget() {
    var keys = widget.outfit.tagged.keys.toList();
    for (var i = 0; i < keys.length; i++) {
      buildSplit(
        keys[i],
        widget.outfit.tagged.values.elementAt(i)['clothName'],
        widget.outfit.tagged.values
            .elementAt(i)['category']
            .toString()
            .substring(
                1,
                widget.outfit.tagged.values
                        .elementAt(i)['category']
                        .toString()
                        .length -
                    1),
      );
    }
  }

  void buildSplit(var value, var key, var keyCategory) {
    Rect rect;
    var x, y, width, height;
    String substr = value.replaceAll("Size", "");
    String substr1 = substr.replaceAll("(", "");
    String substr2 = substr1.replaceAll(")", "");
    List<String> splitted = substr2.split(",");
    for (int i = 0; i < splitted.length; i++) {
      x = double.parse(splitted[0]);
      y = double.parse(splitted[1]);
      width = double.parse(splitted[2]);
      height = double.parse(splitted[3]);
    }
    rect = Rect.fromCenter(center: Offset(x, y), width: width, height: height);
    setState(() {
      children.add(
        new TagsPositioned(
          myRect: rect,
          clothName: key,
          category: keyCategory,
        ),
      );
    });
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
            width: 160,
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Text(
              'Total Cost',
              style: TextStyle(fontSize: 16, color: Hexcolor('#859289')),
            ),
          ),
          Flexible(
            child: Container(
              width: 200,
              margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Text(
                '€ ' + totalCost,
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Hexcolor('#859289')),
              ),
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
            width: 160,
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Text(
              'Outfit Name',
              style: TextStyle(fontSize: 16, color: Hexcolor('#859289')),
            ),
          ),
          Flexible(
            child: Container(
              width: 200,
              margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Text(
                outfitName,
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Hexcolor('#859289')),
              ),
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
          margin: EdgeInsets.fromLTRB(20, 10, 20, 10), child: Text(notes)),
    );
  }

  Container buildContainerRowButton() {
    return Container(
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

  Widget buildClothesList() {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment(-1, 0),
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Text(
              'Clothes you worn: ',
              style: TextStyle(fontSize: 12, color: Hexcolor('#3F4D55')),
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: widget.outfit.tagged.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  alignment: Alignment(-1, 0),
                  child: Text(
                    widget.outfit.tagged.values.elementAt(index)['clothName'],
                    // widget.outfit.taggedClothesName[index],
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Hexcolor('#859289'),
                    ),
                  ),
                );
              }),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Widget buildContainerPhoto() {
    return GestureDetector(
      onTap: () {
        makeWidget();
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
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
                for (var item in children) item
              ],
            ),
            buildContainerRowButton(),
            buildContainerNotes(),
            buildContainerRowOutfit(),
            buildContainerRowTotalCost(),
            buildClothesList(),
          ],
        ),
      ),
    );
  }
}
