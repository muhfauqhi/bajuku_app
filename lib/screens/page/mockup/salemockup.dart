import 'package:bajuku_app/screens/page/mockup/messagemockup.dart';
import 'package:bajuku_app/screens/page/scaffold/myscaffold.dart';
import 'package:flutter/material.dart';

class SaleMockup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      leadingActive: true,
      isTitleWidget: false,
      actions: <Widget>[],
      titleStyle: true,
      titleWidget: Text(
        'Sale',
        style: TextStyle(
          color: Color(0xff3F4D55),
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.0,
        ),
      ),
      headerWidget: <Widget>[],
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: <Widget>[
            // Circle avatar with name
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
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

            SizedBox(height: 15.0),

            // Image of post
            Image(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/feed1.png'),
            ),

            SizedBox(height: 15.0),

            // Time of post
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                '20 Mins Ago',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Color(0xff9D9D9D),
                ),
              ),
            ),

            SizedBox(height: 15.0),

            // Title of post
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Trench Coat Zara',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff3F4D55),
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        '€5',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xff859289),
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        'Used',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xff3F4D55),
                        ),
                      ),
                    ],
                  ),
                  // Like icon
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.favorite,
                        color: Color(0xffD96969),
                      ),
                      Text(
                        '89',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12.0,
                          color: Color(0xffD96969),
                          letterSpacing: 1.0,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),

            SizedBox(height: 30),

            // Description of post
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: RichText(
                text: TextSpan(
                  text:
                      'Hi peeps,\n\nI sell my Zara Trench Coat for only €5. The condition is still good, but one of the button just gone missing. But it can be repaired easily with another button.\n\nHit me through personal message here for payment and delivery process.\n\nCheers!',
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
              ),
            ),

            SizedBox(height: 30),

            // Button buy
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MessageMockup(),
                    ),
                  );
                },
                child: Image(
                  image: AssetImage('assets/images/buy.png'),
                ),
              ),
            ),

            SizedBox(height: 70.0),
            
          ],
        ),
      ),
    );
  }
}
