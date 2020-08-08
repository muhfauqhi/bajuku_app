import 'package:bajuku_app/models/clothes.dart';
import 'package:bajuku_app/screens/home/home.dart';
import 'package:bajuku_app/screens/page/scaffold/myscaffold.dart';
import 'package:bajuku_app/screens/template/buildTextField.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:flutter/material.dart';

class SustainAddClothes extends StatelessWidget {
  final Clothes clothes;
  final String title;
  final String type;

  SustainAddClothes({this.clothes, this.title, this.type});

  final _formKey = GlobalKey<FormState>();

  String price = '';
  String productDesc = '';
  String condition = '';
  String location = '';
  final DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      titleStyle: false,
      leadingActive: true,
      title: title,
      headerWidget: [],
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              BuildTextField(
                onChanged: (val) {
                  productDesc = val;
                },
                type: 'Clothes',
                clothes: clothes,
                widget: 'notes',
                color: '#F8F6F4',
                enabled: false,
              ),
              BuildTextField(
                widget: 'date',
                color: '#F8F6F4',
                enabled: false,
              ),
              textFieldGivenOrSell(),
              BuildTextField(
                onChanged: (val) {
                  condition = val;
                },
                color: '#FFFFFF',
                desc: 'Condition',
                enabled: true,
              ),
              BuildTextField(
                onChanged: (val) {
                  location = val;
                },
                color: '#F8F6F4',
                desc: 'Location',
                enabled: true,
              ),
              BuildTextField(
                widget: 'sizedOfBox',
              ),
              BuildTextField(
                widget: 'button',
                type: type,
                onTap: () {
                  databaseService.updateGivenJournal(type, clothes.documentId);
                  clothes.status = type;
                  databaseService.setGivenOrSellClothes(
                      clothes, productDesc, price, condition, type, location);
                  showDialog(
                    builder: (context) {
                      Future.delayed(Duration(seconds: 3), () {
                        Navigator.of(context).pop(true);
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) => new Home()));
                      });
                      return Image.asset('assets/images/${type}Post.png');
                    },
                    context: context,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textFieldGivenOrSell() {
    if (type == 'Given') {
      price = 'Free';
      return BuildTextField(
        widget: 'Free',
        color: '#F8F6F4',
        desc: 'Price',
        enabled: false,
      );
    } else {
      return BuildTextField(
        onChanged: (val) {
          price = val;
        },
        color: '#F8F6F4',
        desc: 'Price',
        enabled: true,
      );
    }
  }
}
