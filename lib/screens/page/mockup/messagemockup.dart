import 'package:bajuku_app/screens/page/scaffold/myscaffold.dart';
import 'package:flutter/material.dart';

class MessageMockup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      leadingActive: true,
      isTitleWidget: false,
      actions: <Widget>[],
      titleStyle: true,
      titleWidget: Text(
        'Buy Message',
        style: TextStyle(
          color: Color(0xff3F4D55),
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.0,
        ),
      ),
      headerWidget: <Widget>[],
      body: Column(
        children: <Widget>[
          ClipRRect(
            child: Container(
              margin: EdgeInsets.only(bottom: 3.0),
              decoration: BoxDecoration(
                color: Color(0xffFBFBFB),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                colors: [
                                  Color(0xff6EAAB8),
                                  Color(0xff6EAAB8),
                                ],
                              ),
                            ),
                            padding: EdgeInsets.all(3.0),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  colors: [
                                    Color(0xffCEB39E),
                                    Color(0xffFFDEBF),
                                  ],
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'RY',
                                  style: TextStyle(
                                      color: Color(0xff3F4D55),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        'Ryan Young',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.more_horiz,
                    size: 30.0,
                    color: Color(0xff9D9D9D),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
