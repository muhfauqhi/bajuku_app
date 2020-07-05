import 'package:bajuku_app/models/company.dart';
import 'package:bajuku_app/models/sustainabilityClothes.dart';
import 'package:bajuku_app/screens/page/sustainability/sustainabilitywidget/buildCardLarge.dart';
import 'package:bajuku_app/screens/page/sustainability/sustainabilitywidget/buildCardSmall.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class GridViewSustainability extends StatelessWidget {
  final int crossAxisCount;
  final int itemCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;
  final bool cardLarge;
  final String category;
  final List<SustainabilityClothes> sustainabilityClothes;
  GridViewSustainability(
      {this.crossAxisCount,
      this.itemCount,
      this.mainAxisSpacing,
      this.crossAxisSpacing,
      this.childAspectRatio,
      this.cardLarge,
      this.category,
      this.sustainabilityClothes});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 25.0, right: 25.0),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: itemCount,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          childAspectRatio: childAspectRatio,
        ),
        itemBuilder: (context, index) {
          List<Company> company = addData();
          return Card(
            elevation: 2.0,
            child: Container(
              decoration: BoxDecoration(
                color: Hexcolor('#FFFFFF'),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: cardLarge
                  ? CardLarge(
                      company: company[index],
                      onTap: () {
                        if (category == 'Donate') {
                          showDialog(
                            context: context,
                            child: Container(
                              child: Stack(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      'assets/images/AskConfirmation.png',
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      showDialog(
                                        context: context,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            child: Image.asset(
                                                'assets/images/Success.png'),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      alignment: Alignment(-0.2, 0.38),
                                      child: Image.asset(
                                        'assets/images/yes.png',
                                        width: 312,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      alignment: Alignment(-0.2, 0.6),
                                      child: Image.asset(
                                        'assets/images/cancel.png',
                                        width: 312,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            child: GestureDetector(
                              child: Image.asset(
                                'assets/images/Redirecting.png',
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          );
                        }
                      },
                    )
                  : CardSmall(
                      sustainabilityClothes: sustainabilityClothes[index]),
            ),
          );
        },
      ),
    );
  }

  List<Company> addData() {
    List<Company> company = [];
    if (category == 'Donate') {
      company.add(
        new Company(
            'Oxfam',
            'oxfam',
            'Issues we work on is from women\'s rights to climate change, earthquakes to education, we carry out life-changing, ground-breaking work around the world.',
            'Donate'),
      );
      company.add(
        new Company(
            'Goodwill',
            'goodwill',
            'Goodwill’s mission is all about enhancing the quality of life for millions of people through education, skills training, and work.',
            'Donate'),
      );
      company.add(
        new Company(
            'Soles4Souls',
            'soles4souls',
            'The Soles4Souls is the incredible organization that believes in the power of a pair of shoes. Explore how you can aid in their efforts by gathering and donating your unwanted shoes.',
            'Donate'),
      );
      company.add(
        new Company(
            'The Arc',
            'thearc',
            'The Arc is the nation’s leading advocate for those with developmental disabilities. All the donation go toward public policy advocacy as well as inclusivity programs and services for the community.',
            'Donate'),
      );
    } else if (category == 'Upkeep') {
      company.add(
        new Company(
            'Green Laundry Room',
            'greenlaundry',
            'The Green Laundry Room aims to use 20% less water, 30% less energy and 90% less chemicals when compared to doing laundry at home or elsewhere.',
            'Contact'),
      );
      company.add(
        new Company('Jim’s Shoes & Bag', 'jimsshoes&bags',
            'Repair services for leather', 'Contact'),
      );
      company.add(
        new Company(
            'Soles4Souls',
            'soles4souls',
            'The Soles4Souls is the incredible organization that believes in the power of a pair of shoes. Explore how you can aid in their efforts by gathering and donating your unwanted shoes.',
            'Contact'),
      );
      company.add(
        new Company(
            'The Arc',
            'thearc',
            'The Arc is the nation’s leading advocate for those with developmental disabilities. All the donation go toward public policy advocacy as well as inclusivity programs and services for the community.',
            'Contact'),
      );
    } else {}
    return company;
  }
}
