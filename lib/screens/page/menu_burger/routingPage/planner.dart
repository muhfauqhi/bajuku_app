import 'dart:convert';
import 'package:bajuku_app/models/clothes.dart';
import 'package:bajuku_app/screens/page/scaffold/myscaffold.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class Planner extends StatefulWidget {
  @override
  _PlannerState createState() => _PlannerState();
}

class _PlannerState extends State<Planner> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events = {};
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  SharedPreferences prefs;
  var date;
  var selectedDate;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _selectedEvents = [];
    initPrefs();
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime, List<dynamic>>.from(
          decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    });
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      leadingActive: true,
      title: 'Planner',
      titleStyle: false,
      headerWidget: [],
      body: FutureBuilder(
          future: DatabaseService().getClothesAvailable(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text("");
            } else {
              List<Clothes> clothesList = [];
              for (var i in snapshot.data.documents) {
                clothesList.add(
                  Clothes(
                    i.documentID,
                    i.data['brand'],
                    i.data['category'],
                    i.data['clothName'],
                    i.data['color'],
                    i.data['cost'],
                    i.data['dateBought'],
                    i.data['endDate'],
                    i.data['fabric'],
                    i.data['image'],
                    i.data['price'],
                    i.data['notes'],
                    i.data['season'],
                    i.data['size'],
                    i.data['startDate'],
                    i.data['status'],
                    i.data['updateDate'],
                    i.data['url'],
                    i.data['usedInOutfit'],
                    i.data['worn'],
                  ),
                );
              }
              if (clothesList.isNotEmpty) {
                _events = getData(clothesList);
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TableCalendar(
                    events: _events,
                    initialCalendarFormat: CalendarFormat.month,
                    calendarStyle: CalendarStyle(
                        canEventMarkersOverflow: true,
                        todayColor: Colors.orange,
                        selectedColor: Theme.of(context).primaryColor,
                        todayStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.white)),
                    headerStyle: HeaderStyle(
                      centerHeaderTitle: true,
                      formatButtonDecoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      formatButtonTextStyle: TextStyle(color: Colors.white),
                      formatButtonShowsNext: false,
                    ),
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    onDaySelected: (date, events) {
                      setState(() {
                        _selectedEvents = events;
                      });
                    },
                    builders: CalendarBuilders(
                      selectedDayBuilder: (context, date, events) => Container(
                          margin: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              shape: BoxShape.circle),
                          child: Text(
                            date.day.toString(),
                            style: TextStyle(color: Colors.white),
                          )),
                      todayDayBuilder: (context, date, events) => Container(
                          margin: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.orange, shape: BoxShape.circle),
                          child: Text(
                            date.day.toString(),
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    calendarController: _controller,
                  ),
                  // ..._selectedEvents.map((event) => ListTile(
                  //       title: Text(event),
                  //     )),
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          date = _events.keys.elementAt(index);
                          var formatter = new DateFormat('dd MMMM yyyy');
                          date = formatter.format(date);
                          var values = _events.values.toList();
                          for (int i = 0; i < values.length; i++) {
                            print(values.elementAt(i)[0].clothName);
                          }
                          return ListTile(
                            onTap: () {
                              setState(() {
                                _controller.setSelectedDay(
                                    _events.keys.elementAt(index));
                              });
                            },
                            title: Text(values
                                .elementAt(index)[0]
                                .clothName
                                .toString()),
                            subtitle: Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    date.toString(),
                                  ),
                                ),
                                // Container(
                                //   margin: EdgeInsets.only(left: 200),
                                //   child: GestureDetector(
                                //     child: Text("Change Plan"),
                                //     onTap: () {
                                //       showDatePicker(
                                //         context: context,
                                //         initialDate: DateTime.now(),
                                //         firstDate: DateTime(2015, 8),
                                //         lastDate: DateTime(2101),
                                //         confirmText: 'OK',
                                //         cancelText: '',
                                //         builder: (BuildContext context,
                                //             Widget child) {
                                //           return Theme(
                                //             data: ThemeData.dark().copyWith(
                                //               colorScheme: ColorScheme.dark(
                                //                 primary: Hexcolor('#DBBEA7'),
                                //                 onPrimary: Colors.white,
                                //                 surface: Hexcolor('#3F4D55'),
                                //                 onSurface: Hexcolor('#DBBEA7'),
                                //               ),
                                //               dialogBackgroundColor:
                                //                   Hexcolor('#3F4D55'),
                                //             ),
                                //             child: child,
                                //           );
                                //         },
                                //       ).then((value) {
                                //         setState(() {
                                //           // selectedDate = value;
                                //           // dateBoughtFormatted =
                                //           // formatter.format(value);
                                //         });
                                //       });
                                //     },
                                //   ),
                                // )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                        itemCount: _events.length),
                  )
                ],
              );
            }
          }),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: _showAddDialog,
      // ),
    );
  }

  _showAddDialog() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: _eventController,
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("Save"),
                  onPressed: () {
                    // if (_eventController.text.isEmpty) return;
                    if (_events[_controller.selectedDay] != null) {
                      _events[_controller.selectedDay]
                          .add(_eventController.text);
                    } else {
                      _events[_controller.selectedDay] = [
                        _eventController.text
                      ];
                    }
                    // prefs.setString("events", json.encode(encodeMap(_events)));
                    _eventController.clear();
                    Navigator.pop(context);
                  },
                )
              ],
            ));
    setState(() {
      _selectedEvents = _events[_controller.selectedDay];
      print(_controller.selectedDay);
    });
  }

  Map<DateTime, List<dynamic>> getData(List<Clothes> events) {
    Map<DateTime, List<dynamic>> data = {};
    events.forEach((e) {
      if (data[e.endDate.toDate()] == null) {
        data[e.endDate.toDate()] = [];
      }
      data[e.endDate.toDate()].add(e);
    });
    return data;
  }
}
