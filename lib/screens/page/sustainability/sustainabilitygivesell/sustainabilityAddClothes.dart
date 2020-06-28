import 'package:bajuku_app/models/clothes.dart';
import 'package:bajuku_app/screens/home/home.dart';
import 'package:bajuku_app/screens/page/scaffold/myscaffold.dart';
import 'package:bajuku_app/screens/template/buildTextField.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
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
                  databaseService.setGivenOrSellClothes(
                      clothes, productDesc, price, condition, type);
                  showDialog(
                    context: context,
                    child: GestureDetector(
                      onTap: () {
                        print(type);
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Home(currentIndex: 0,)));
                      },
                      child: Image.asset('assets/images/${type}Post.png'),
                    ),
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
