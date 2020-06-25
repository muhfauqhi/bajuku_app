import 'package:bajuku_app/models/clothes.dart';
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

  String price;
  String notes;
  String condition;
  String location;

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
                color: '#FFFFFF',
                desc: 'Condition',
                enabled: true,
              ),
              BuildTextField(
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textFieldGivenOrSell() {
    if (type == 'Given') {
      return BuildTextField(
        widget: 'Free',
        color: '#F8F6F4',
        desc: 'Price',
        enabled: false,
      );
    } else {
      return BuildTextField(
        color: '#F8F6F4',
        desc: 'Price',
        enabled: true,
      );
    }
  }
}
