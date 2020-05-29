import 'package:flutter/material.dart';

class Slide{
  final String imageUrl;

  Slide({
    @required this.imageUrl
  });
}

final slideList = [
  Slide(
    imageUrl: 'assets/images/sliderimage1.png'
  ),
  Slide(
    imageUrl: 'assets/images/sliderimage2.png'
  ),
  Slide(
    imageUrl: 'assets/images/sliderimage3.png'
  ),
];
