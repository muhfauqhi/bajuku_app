import 'package:bajuku_app/screens/page/scaffold/myscaffold.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'indicator.dart';

class ColorStorage extends StatefulWidget {
  @override
  _ColorStorageState createState() => _ColorStorageState();
}

class _ColorStorageState extends State<ColorStorage> {
  final DatabaseService databaseService = DatabaseService();
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Color Storage',
      leadingActive: true,
      titleStyle: false,
      headerWidget: [],
      body: FutureBuilder(
          future: databaseService.getTotalClothes(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text('');
            } else {
              List<String> listOfColors = [];
              for (var i = 0; i < snapshot.data.documents.length; i++) {
                if (listOfColors
                    .contains(snapshot.data.documents[i]['color'])) {
                } else {
                  listOfColors.add(snapshot.data.documents[i]['color']);
                }
              }
              return Center(
                child: AspectRatio(
                  aspectRatio: 1.3,
                  child: Card(
                    color: Hexcolor('#F8F8F8'),
                    child: Row(
                      children: [
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: PieChart(
                              PieChartData(
                                pieTouchData: PieTouchData(
                                  touchCallback: (pieTouchResponse) {
                                    setState(
                                      () {
                                        if (pieTouchResponse.touchInput
                                                is FlLongPressEnd ||
                                            pieTouchResponse.touchInput
                                                is FlPanEnd) {
                                          touchedIndex = -1;
                                        } else {
                                          touchedIndex = pieTouchResponse
                                              .touchedSectionIndex;
                                        }
                                      },
                                    );
                                  },
                                ),
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                sectionsSpace: 2,
                                centerSpaceRadius: 40,
                                sections: showingSections(listOfColors),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Indicator(
                              color: listOfColors
                                  .elementAt(0)
                                  .substring(
                                      10, listOfColors.elementAt(0).length - 1)
                                  .toUpperCase(),
                              text: 'First',
                              isSquare: true,
                              size: 16,
                              textColor: const Color(0xff505050),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Indicator(
                              color: listOfColors
                                  .elementAt(1)
                                  .substring(
                                      10, listOfColors.elementAt(1).length - 1)
                                  .toUpperCase(),
                              text: 'Second',
                              isSquare: true,
                              size: 16,
                              textColor: const Color(0xff505050),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Indicator(
                              color: listOfColors
                                  .elementAt(2)
                                  .substring(
                                      10, listOfColors.elementAt(2).length - 1)
                                  .toUpperCase(),
                              text: 'Third',
                              isSquare: true,
                              size: 16,
                              textColor: const Color(0xff505050),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Indicator(
                              color: listOfColors
                                  .elementAt(3)
                                  .substring(
                                      10, listOfColors.elementAt(3).length - 1)
                                  .toUpperCase(),
                              text: 'Fourth',
                              isSquare: true,
                              size: 16,
                              textColor: const Color(0xff505050),
                            ),
                            SizedBox(
                              height: 18,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }

  List<PieChartSectionData> showingSections(var list) {
    return List.generate(
      4,
      (i) {
        final isTouched = i == touchedIndex;
        final double fontSize = isTouched ? 25 : 16;
        final double radius = isTouched ? 60 : 50;
        switch (i) {
          case 0:
            return PieChartSectionData(
              color: Hexcolor(
                  '${list.elementAt(0).substring(10, list.elementAt(0).length - 1)}'),
              value: 40,
              title: '40%',
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffffffff)),
            );
          case 1:
            return PieChartSectionData(
              color: Hexcolor(
                  '${list.elementAt(1).substring(10, list.elementAt(1).length - 1)}'),
              value: 30,
              title: '30%',
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffffffff)),
            );
          case 2:
            return PieChartSectionData(
              color: Hexcolor(
                  '${list.elementAt(2).substring(10, list.elementAt(2).length - 1)}'),
              value: 15,
              title: '15%',
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffffffff)),
            );
          case 3:
            return PieChartSectionData(
              color: Hexcolor(
                  '${list.elementAt(3).substring(10, list.elementAt(3).length - 1)}'),
              value: 15,
              title: '15%',
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffffffff)),
            );
          default:
            return null;
        }
      },
    );
  }
}
