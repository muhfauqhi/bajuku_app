import 'package:bajuku_app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class TemplateDetailOutfit extends StatefulWidget {
  @override
  _TemplateDetailOutfitState createState() => _TemplateDetailOutfitState();
}

class _TemplateDetailOutfitState extends State<TemplateDetailOutfit> {
  var formatter = new DateFormat('dd MMMM yyyy');
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
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new Home()));
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
        body: SingleChildScrollView(
            child: Container(
          child: Column(
            children: <Widget>[
              buildContainerPhoto(),
              buildContainerRowButton(),
              buildContainerNotes(),
              buildContainerRowOutfit(),
              buildContainerRowTotalCost(),
            ],
          ),
        )),
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
                    style:
                        TextStyle(fontSize: 16, color: Hexcolor('#859289')),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text(
                    '\$123',
                    style:
                        TextStyle(fontWeight: FontWeight.w600,fontSize: 16, color: Hexcolor('#859289')),
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
                      style:
                          TextStyle(fontSize: 16, color: Hexcolor('#859289')),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Text(
                      'Working outfit1',
                      style:
                          TextStyle(fontWeight: FontWeight.w600,fontSize: 16, color: Hexcolor('#859289')),
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

  Container buildContainerPhoto() {
    return Container(
              height: 480,
              width: 500,
              child: ClipRRect(
                child: Image.network(
                  'https://cdn.idntimes.com/content-images/post/20180824/6eda99bee7ddfc124c5645ebf2ca4fbf.jpg',
                  fit: BoxFit.fill,
                ),
              ),
            );
  }
}
