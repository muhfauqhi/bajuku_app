import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SustainableTemplate extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget headerWidget;

  SustainableTemplate({this.title, this.body, this.headerWidget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Navigator.pop(context);
                  },
                ),
                backgroundColor: Hexcolor('FBFBFB'),
                expandedHeight: 50.0,
                floating: false,
                pinned: false,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.0,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      color: Hexcolor('#3F4D55'),
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          color: Hexcolor('#FBFBFB'),
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                width: 120,
                                height: 90,
                                child: Column(
                                  children: <Widget>[
                                    GestureDetector(
                                      child: Center(
                                        child: Container(
                                          width: 60.0,
                                          height: 60.0,
                                          decoration: new BoxDecoration(
                                            border: Border.all(
                                                width: 3,
                                                color: Hexcolor('#F4D4B8')),
                                            shape: BoxShape.circle,
                                            image: new DecorationImage(
                                              fit: BoxFit.fitHeight,
                                              image: new NetworkImage(
                                                  "https://cdn.vox-cdn.com/thumbor/U7zc79wuh0qCZxPhGAdi3eJ-q1g=/1400x1400/filters:format(jpeg)/cdn.vox-cdn.com/uploads/chorus_asset/file/19228501/acastro_190919_1777_instagram_0003.0.jpg"),
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: () {},
                                    ),
                                    Center(
                                      child: Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: GestureDetector(
                                            child: Text(
                                              'Edit',
                                              style: TextStyle(
                                                color: Hexcolor('#E1C8B4'),
                                                fontSize: 12,
                                              ),
                                            ),
                                            onTap: () {},
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                width: 260,
                                height: 90,
                                child: Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            '100',
                                            style: TextStyle(
                                                color: Hexcolor('#3F4D55'),
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          ),
                                          Text(
                                            'Pieces',
                                            style: TextStyle(
                                                fontStyle: FontStyle.normal,
                                                fontSize: 16,
                                                color: Hexcolor('#859289')),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            '10',
                                            style: TextStyle(
                                                color: Hexcolor('#3F4D55'),
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          ),
                                          Text(
                                            'Outfits',
                                            style: TextStyle(
                                                fontStyle: FontStyle.normal,
                                                fontSize: 16,
                                                color: Hexcolor('#859289')),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            '10',
                                            style: TextStyle(
                                                color: Hexcolor('#3F4D55'),
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          ),
                                          Text(
                                            'Points',
                                            style: TextStyle(
                                                fontStyle: FontStyle.normal,
                                                fontSize: 16,
                                                color: Hexcolor('#859289')),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  headerWidget,
                ],
              ),
            ),
          ];
        },
        body: body,
      ),
    );
  }

}
