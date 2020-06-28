import 'package:bajuku_app/models/sustainabilityClothes.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CardSmall extends StatelessWidget {
  final SustainabilityClothes sustainabilityClothes;

  CardSmall({this.sustainabilityClothes});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                sustainabilityClothes.clothes['image'],
                height: 130,
                width: 140,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(left: 15.0),
                      width: 100,
                      child: Text(
                        sustainabilityClothes.clothes['clothName'],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Hexcolor('#3F4D55'),
                        ),
                        softWrap: false,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  // Icon Settings TODO
                ],
              ),
              
            ],
          ),
        ],
      ),
    );
  }
}
