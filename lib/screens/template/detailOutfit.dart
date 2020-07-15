import 'package:bajuku_app/models/outfit.dart';
import 'package:bajuku_app/screens/page/outfit/buildTags.dart';
import 'package:bajuku_app/screens/page/scaffold/myscaffold.dart';
import 'package:bajuku_app/screens/page/sustainability/sustainabilitygivesell/sustainabilityAddJournal.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class OutfitDetail extends StatefulWidget {
  final String title;
  final Outfit outfit;
  final bool buttonWorn;
  final String type;

  OutfitDetail({Key key, this.title, this.outfit, this.buttonWorn, this.type})
      : super(key: key);

  @override
  _OutfitDetailState createState() => _OutfitDetailState();
}

class _OutfitDetailState extends State<OutfitDetail> {
  final List<Widget> children = [];
  final GlobalKey key = GlobalKey();
  final format = new DateFormat('dd MMMM yyyy');

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      titleStyle: true,
      actions: [
        GestureDetector(
          child: Container(
            margin: EdgeInsets.only(right: 10.0),
            child: Image.asset(
              'assets/images/close.png',
              width: 25,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
      titleTextStyle: textStyle('#3F4D55', 20.0, FontWeight.bold),
      leadingActive: true,
      title: widget.title,
      headerWidget: [],
      body: buildContainerPhoto(),
    );
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
                    fit: BoxFit.fitWidth,
                  ),
                ),
                for (var item in children) item
              ],
            ),
            // buildContainerRowButton(),
            buildContainerNotes(),
            buildContainerRowOutfit(),
            // buildContainerRowTotalCost(),
            Divider(
              color: Hexcolor('#FFFFFF'),
              thickness: 2.0,
            ),
            buildClothesList(),
            SizedBox(
              height: 20.0,
            ),
            _buildButton('next', context),
          ],
        ),
      ),
    );
  }

  onTapWorn() {
    setState(() {});
    // databaseService.updateWorn(widget.clothes.documentId);
  }

  Widget _buildButton(var asset, var context) {
    return Container(
      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 25.0, bottom: 25.0),
      child: FlatButton(
        child: Image.asset('assets/images/$asset.png'),
        onPressed: () {
          return widget.buttonWorn
              ? onTapWorn()
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => SustainAddJournal(
                      outfit: widget.outfit,
                      title: widget.title,
                      type: widget.type,
                    ),
                  ),
                );
        },
      ),
    );
  }

  Widget buildContainerRowTotalCost() {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            width: 200,
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Text(
              'Total Cost',
              style: textStyle('#859289', 16.0),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Text('€ ' + widget.outfit.totalCost,
                style: textStyle('#859289', 16.0, FontWeight.w600)),
          )
        ],
      ),
    );
  }

  Widget buildContainerRowOutfit() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            margin: EdgeInsets.only(
              left: 20,
              top: 10,
              bottom: 20,
            ),
            child: Text(
              'Outfit Name',
              style: TextStyle(fontSize: 16, color: Hexcolor('#859289')),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                right: 20,
                top: 10,
                bottom: 20,
              ),
              width: MediaQuery.of(context).size.width * 0.5,
              child: Text(
                widget.outfit.outfitName,
                overflow: TextOverflow.fade,
                softWrap: true,
                maxLines: 1,
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

  Widget buildContainerNotes() {
    return Container(
      height: 60,
      width: double.infinity,
      color: Hexcolor('#FFFFFF'),
      child: Container(
        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Text(
          widget.outfit.notes,
          softWrap: false,
          overflow: TextOverflow.clip,
          maxLines: 2,
        ),
      ),
    );
  }

  Widget buildContainerRowButton() {
    return Container(
      width: 600,
      height: 50,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 22),
            child: Text(
              format.format(widget.outfit.created.toDate()),
              style: textStyle(
                '#3F4D55',
                12.0,
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
            child:
                Text('Clothes you worn: ', style: textStyle('#3F4D55', 12.0)),
          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.outfit.tagged.length,
              itemBuilder: (context, index) {
                if (widget.outfit.tagged.values.elementAt(index)['status'] ==
                    'Available') {
                  return Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    alignment: Alignment(-1, 0),
                    child: Text(
                      widget.outfit.tagged.values
                              .elementAt(index)['clothName'] +
                          ' [${widget.outfit.tagged.values.elementAt(index)['status']}]',
                      style: textStyle(
                        '#3F4D55',
                        16.0,
                      ),
                    ),
                  );
                } else {
                  return Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    alignment: Alignment(-1, 0),
                    child: Text(
                      widget.outfit.tagged.values
                              .elementAt(index)['clothName'] +
                          ' [${widget.outfit.tagged.values.elementAt(index)['status']}]',
                      style: textStyle(
                        '#859289',
                        16.0,
                      ),
                    ),
                  );
                }
              }),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  TextStyle textStyle(var color, var fontSize, [FontWeight fontWeight]) {
    return TextStyle(
      fontSize: fontSize,
      color: Hexcolor(color),
      fontWeight: fontWeight,
    );
  }
}
