import 'package:flutter/material.dart';

class Slide {
  final String imageUrl;
  final String firstText;
  final String secondText;

  Slide({@required this.imageUrl, this.firstText, this.secondText});
}

final slideList = [
  Slide(
    imageUrl: 'assets/images/sliderimage1.png',
    firstText: 'Virtual Wardrobe',
    secondText: 'Manage your wardrobe and maximize the usage of your clothes',
  ),
  Slide(
    imageUrl: 'assets/images/sliderimage2.png',
    firstText: 'Outfit Journal',
    secondText:
        'Share your outfit stories and follow your friends outfit creation.',
  ),
  Slide(
      imageUrl: 'assets/images/sliderimage3.png',
      firstText: 'Sustainability Impact',
      secondText:
          'Buy, sell, give and donate to reduce the fast fashion impact.'),
  Slide(
    imageUrl: 'assets/images/sliderimage4.png',
    firstText: 'Get Rewards',
    secondText: 'The more you become sustainable, the more rewards you’ll get',
  ),
];
