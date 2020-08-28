import 'package:bajuku_app/screens/page/scaffold/myscaffold.dart';
import 'package:flutter/material.dart';
import 'package:speech_bubble/speech_bubble.dart';

class MessageMockup extends StatelessWidget {
  final List message = [
    {
      'message':
          'Hi Ryan, Im interested in buying your Zara Trench Coat. I am based in Limerick, can we meet at Starbucks Henry St tomorrow around afternoon?',
      'time': '5',
    },
    {
      'message':
          'Hi Michelle, tomorrow is alright. But can we meet at Tesco at 3pm instead?',
      'time': '2',
    },
    {
      'message': 'Sure, that\’s still ok for me. Thanks. See you tomorrow. ',
      'time': 'A',
    },
    {
      'message': 'Ok. See you.                                             ',
      'time': 'A',
    },
  ];

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
          Expanded(
            child: ListView(
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
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
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
                _buildPostCard(),
                _buildMessage(true, 0),
                _buildMessage(false, 1),
                _buildMessage(true, 2),
                _buildMessage(false, 3),
              ],
            ),
          ),
          _buildTextFormMessage(),
        ],
      ),
    );
  }

  Widget _buildMessage(bool sender, int index) {
    return Container(
      margin: sender
          ? EdgeInsets.only(left: 80.0, right: 10.0, bottom: 20.0, top: 20.0)
          : EdgeInsets.only(left: 10.0, right: 80.0, bottom: 20.0, top: 20.0),
      child: SpeechBubble(
        color: sender ? Color(0xffE1C8B4) : Color(0xff355558),
        padding: EdgeInsets.all(20.0),
        borderRadius: 20,
        nipHeight: 0,
        child: RichText(
          textAlign: TextAlign.justify,
          text: TextSpan(
            text: '${message[index]['message']}\n\n',
            children: [
              TextSpan(
                  text: '${message[index]['time']} MINS AGO',
                  style: TextStyle(
                      color: sender
                          ? Color(0xff444444)
                          : Colors.white.withOpacity(0.5))),
            ],
            style: TextStyle(
              color: sender ? Color(0xff444444) : Color(0xffFFFFFF),
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormMessage() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Material(
        elevation: 20.0,
        borderRadius: BorderRadius.circular(30.0),
        child: Stack(
          children: <Widget>[
            TextFormField(
              textCapitalization: TextCapitalization.sentences,
              enableSuggestions: true,
              style: TextStyle(
                fontSize: 12.0,
                color: Color(0xff444444),
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                prefixIcon: ShaderMask(
                  shaderCallback: (bounds) {
                    return RadialGradient(
                      center: Alignment.topLeft,
                      radius: 0.5,
                      colors: <Color>[
                        Color(0xffCEB39E),
                        Color(0xffFFDEBF),
                      ],
                      tileMode: TileMode.repeated,
                    ).createShader(bounds);
                  },
                  child: Icon(
                    Icons.insert_emoticon,
                    color: Color(0xffCEB39E),
                  ),
                ),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ShaderMask(
                      shaderCallback: (bounds) {
                        return RadialGradient(
                          center: Alignment.topLeft,
                          radius: 0.5,
                          colors: <Color>[
                            Color(0xffCEB39E),
                            Color(0xffFFDEBF),
                          ],
                          tileMode: TileMode.repeated,
                        ).createShader(bounds);
                      },
                      child: Icon(
                        Icons.add_a_photo,
                        color: Color(0xffCEB39E),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          colors: [
                            Color(0xff1C3949),
                            Color(0xff557A6D),
                          ],
                        ),
                      ),
                      child: Container(
                        height: 60,
                        width: 60,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xffEEEEEE),
                        ),
                      ),
                    )
                  ],
                ),
                contentPadding: EdgeInsets.all(20),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                  borderSide: BorderSide(
                    color: Color(0xffEEEEEE),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                  borderSide: BorderSide(
                    color: Color(0xffFFFFFF),
                  ),
                ),
                filled: true,
                hintStyle: TextStyle(
                    color: Color(0xffD3D3D3),
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2.0),
                hintText: 'Type Something...',
                fillColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostCard() {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Card(
        color: Color(0xffF8F6F4),
        elevation: 8.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Image(
                height: 100,
                width: 100,
                fit: BoxFit.cover,
                image: AssetImage('assets/images/feed1.png'),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Trench Coat Zara',
                      style: TextStyle(
                        color: Color(0xff3F4D55),
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      '€5',
                      style: TextStyle(
                        color: Color(0xff3F4D55),
                        fontSize: 12.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      'Used',
                      style: TextStyle(
                        color: Color(0xff3F4D55),
                        fontSize: 12.0,
                      ),
                    ),
                    SizedBox(height: 25.0),
                  ],
                ),
                Text(
                  'Limerick, Ireland',
                  style: TextStyle(
                    color: Color(0xff9D9D9D),
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
