import 'package:bajuku_app/models/clothes.dart';
import 'package:bajuku_app/models/outfit.dart';
import 'package:bajuku_app/models/sustainabilityClothes.dart';
import 'package:bajuku_app/screens/home/home.dart';
import 'package:bajuku_app/screens/page/scaffold/myscaffold.dart';
import 'package:bajuku_app/screens/template/buildTextField.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SustainAddJournal extends StatefulWidget {
  final Outfit outfit;
  final String title;
  final String type;

  SustainAddJournal({this.outfit, this.title, this.type});

  @override
  _SustainAddJournalState createState() => _SustainAddJournalState();
}

class _SustainAddJournalState extends State<SustainAddJournal> {
  List<Widget> textFieldCount = [];
  List<Clothes> clothesList = [];
  List<String> productDescList = [];
  List<String> condition = [];
  List<String> location = [];
  List<String> price = [];
  List<String> productDesc = [];
  String testVal = '';
  List<TextEditingController> controller = [];

  DatabaseService databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      titleStyle: false,
      leadingActive: true,
      title: widget.title,
      headerWidget: [],
      body: FutureBuilder(
          future: buildTextField(),
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Column(children: [
                for (var item in textFieldCount) item,
                Container(
                  margin: EdgeInsets.only(top: 40.0, bottom: 30.0),
                  child: BuildTextField(
                    widget: 'button',
                    type: widget.type,
                    onTap: () {
                      var index = 0;
                      List<SustainabilityClothes> sustainClothes = [];
                      for (var i = 0; i < clothesList.length; i++) {
                        if (widget.type == 'Given') {
                          sustainClothes.add(
                            SustainabilityClothes(
                                clothesList[i],
                                controller[index].text,
                                'Free',
                                controller[index + 2].text,
                                controller[index + 3].text),
                          );
                        } else {
                          sustainClothes.add(
                            SustainabilityClothes(
                                clothesList[i],
                                controller[index].text,
                                controller[index + 1].text,
                                controller[index + 2].text,
                                controller[index + 3].text),
                          );
                        }
                        index += 4;
                      }
                      for (int i = 0; i < clothesList.length; i++) {
                        clothesList[i].status = widget.type;
                        databaseService.setGivenOrSellClothes(
                            sustainClothes[i].clothes,
                            sustainClothes[i].productDesc,
                            sustainClothes[i].price,
                            sustainClothes[i].condition,
                            widget.type,
                            sustainClothes[i].location);
                      }
                      showDialog(
                        builder: (context) {
                          Future.delayed(Duration(seconds: 3), () {
                            Navigator.of(context).pop(true);
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new Home()));
                          });
                          return Image.asset(
                              'assets/images/${widget.type}Post.png');
                        },
                        context: context,
                      );
                    },
                  ),
                ),
              ]),
            );
          }),
    );
  }

  Future buildTextField() async {
    var index = 0;
    var controllerIndex = 0;

    for (var i in widget.outfit.tagged) {
      String docId =
          i.values.toString().substring(1, i.values.toString().length - 1);
      DocumentSnapshot d = await databaseService.getCloth(docId);
      String status = d.data['status'];
      if (status == 'Available') {
        clothesList.add(Clothes(
          docId,
          d.data['brand'],
          d.data['category'],
          d.data['clothName'],
          d.data['color'],
          d.data['cost'],
          d.data['dateBought'],
          d.data['endDate'],
          d.data['fabric'],
          d.data['image'],
          d.data['price'],
          d.data['notes'],
          d.data['season'],
          d.data['size'],
          d.data['startDate'],
          d.data['status'],
          d.data['updateDate'],
          d.data['url'],
          d.data['usedInOutfit'],
          d.data['worn'],
        ));
        for (int i = 0; i < 4; i++) {
          controller.add(TextEditingController());
        }
        textFieldCount.add(
          BuildTextField(
            controller: controller[controllerIndex],
            type: 'Clothes',
            clothes: clothesList[index],
            widget: 'notes',
            color: '#F8F6F4',
            enabled: false,
          ),
        );
        controllerIndex++;
        textFieldCount.add(
          BuildTextField(
            widget: 'date',
            color: '#F8F6F4',
            enabled: false,
          ),
        );
        textFieldCount.add(textFieldGivenOrSell(controller[controllerIndex]));
        controllerIndex++;
        textFieldCount.add(
          BuildTextField(
            controller: controller[controllerIndex],
            color: '#F8F6F4',
            desc: 'Condition',
            enabled: true,
          ),
        );
        controllerIndex++;
        textFieldCount.add(BuildTextField(
          controller: controller[controllerIndex],
          color: '#FFFFFF',
          desc: 'Location',
          enabled: true,
        ));
        controllerIndex++;
        index++;
      }
    }
  }

  Widget textFieldGivenOrSell(var controller) {
    if (widget.type == 'Given') {
      return BuildTextField(
        controller: controller,
        widget: 'Free',
        color: '#FFFFFF',
        desc: 'Price',
        enabled: false,
      );
    } else {
      return BuildTextField(
        controller: controller,
        color: '#FFFFFF',
        desc: 'Price',
        enabled: true,
      );
    }
  }
}
