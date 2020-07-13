import 'package:bajuku_app/models/clothes.dart';
import 'package:bajuku_app/models/outfit.dart';
import 'package:bajuku_app/screens/home/home.dart';
import 'package:bajuku_app/screens/page/scaffold/myscaffold.dart';
import 'package:bajuku_app/screens/template/buildTextField.dart';
import 'package:bajuku_app/services/database.dart';
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
    buildTextField();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      titleStyle: false,
      leadingActive: true,
      title: widget.title,
      headerWidget: [],
      body: SingleChildScrollView(
        child: Column(children: [
          for (var item in textFieldCount) item,
          Container(
            margin: EdgeInsets.only(bottom: 30.0),
            child: BuildTextField(
              widget: 'button',
              type: widget.type,
              onTap: () {
                var index = 0;
                for (var i in clothesList) {
                  if (i.status == 'Available') {
                    // print(productDescList);
                    // print(price);
                    // print(condition);
                    // print(location);
                    // print(testVal);
                    // print(productDescList.last);
                    // databaseService.updateGivenJournal(
                    //     widget.type, i.documentId);
                    // i.status = widget.type;
                    // databaseService.setGivenOrSellClothes(i, productDesc[index],
                    //     price[index], condition[index], widget.type);
                    index++;
                    // productDescList.clear();
                    // price.clear();
                    // condition.clear();
                    // location.clear();
                  }
                  // print(productDescList);
                  // for(var i in productDescList){
                  //   if(i.){

                  //   }
                  // }
                }
                // showDialog(
                //   context: context,
                //   child: GestureDetector(
                //     onTap: () {
                //       Navigator.pop(context);
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (BuildContext context) => Home(
                //                     currentIndex: 0,
                //                   )));
                //     },
                //     child: Image.asset('assets/images/${widget.type}Post.png'),
                //   ),
                // );
                // print(productDescList);
                // for (var i = 1; i < productDescList.length; i++) {
                //   if (productDescList[i].length %
                //           productDescList[i].length - 1 ==
                //       0) {
                //     print(productDescList[i].length);
                //     print(productDescList[
                //         i + (productDescList[i].length % 10 + 1)]);
                //   }
                // }
                // print(controller[0].text);
              },
            ),
          ),
        ]),
      ),
    );
  }

  void buildTextField() {
    var index = 0;
    var controllerIndex = 0;
    for (var i in widget.outfit.tagged.values.toList()) {
      if (i['status'] == 'Available') {
        clothesList.add(Clothes(
          i['documentID'],
          i['brand'],
          i['category'],
          i['clothName'],
          i['color'],
          i['cost'],
          i['dateBought'],
          i['endDate'],
          i['fabric'],
          i['image'],
          i['price'],
          i['notes'],
          i['season'],
          i['size'],
          i['startDate'],
          i['status'],
          i['updateDate'],
          i['url'],
          i['usedInOutfit'],
          i['worn'],
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

  // Widget test(var clothes, var outfitName, var controller) {
  //   return Column(
  //     children: [
  //       BuildTextField(
  //         controller: controller,
  //         onChanged: (val) {
  //           testVal = val;
  //         },
  //         type: 'Clothes',
  //         clothes: clothes,
  //         widget: 'notes',
  //         color: '#F8F6F4',
  //         enabled: false,
  //       ),
  //       BuildTextField(
  //         widget: 'date',
  //         color: '#F8F6F4',
  //         enabled: false,
  //       ),
  //       textFieldGivenOrSell(controller),
  //       BuildTextField(
  //         controller: controller,
  //         onChanged: (val) {
  //           condition.add(val);
  //         },
  //         color: '#F8F6F4',
  //         desc: 'Condition',
  //         enabled: true,
  //       ),
  //       BuildTextField(
  //         controller: controller,
  //         onChanged: (val) {
  //           location.add(val);
  //         },
  //         color: '#FFFFFF',
  //         desc: 'Location',
  //         enabled: true,
  //       ),
  //       BuildTextField(
  //         widget: 'sizedOfBox',
  //       ),
  //     ],
  //   );
  // }

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
