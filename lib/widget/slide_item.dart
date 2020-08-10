import 'package:bajuku_app/models/slide.dart';
import 'package:flutter/material.dart';

class SlideItem extends StatelessWidget {
  final int index;
  SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(slideList[index].imageUrl), fit: BoxFit.cover),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 70.0),
            Text(
              '${slideList[index].firstText}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff3F4D55),
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              '${slideList[index].secondText}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff3F4D55),
                fontWeight: FontWeight.w300,
                fontSize: 16.0,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
