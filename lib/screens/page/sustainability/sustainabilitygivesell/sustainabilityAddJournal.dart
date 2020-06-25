import 'package:bajuku_app/models/outfit.dart';
import 'package:bajuku_app/screens/page/scaffold/myscaffold.dart';
import 'package:bajuku_app/screens/template/buildTextField.dart';
import 'package:flutter/material.dart';

class SustainAddJournal extends StatelessWidget {
  final Outfit outfit;
  final String title;
  final String type;

  SustainAddJournal({this.outfit, this.title, this.type});
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      titleStyle: false,
      leadingActive: true,
      title: title,
      headerWidget: [],
      body: Column(
        children: [
          BuildTextField(
            type: 'Outfit',
            outfit: outfit,
            widget: 'notes',
            color: '#F8F6F4',
            desc: 'Price',
            enabled: false,
          ),
          BuildTextField(
            widget: 'date',
            color: '#F8F6F4',
            enabled: false,
          ),
          BuildTextField(
            widget: outfit.outfitName,
            color: '#F8F6F4',
            desc: 'Clothes Name',
            enabled: false,
          ),
          textFieldGivenOrSell(),
          BuildTextField(
            color: '#F8F6F4',
            desc: 'Condition',
            enabled: true,
          ),
          BuildTextField(
            color: '#FFFFFF',
            desc: 'Location',
            enabled: true,
          ),
          BuildTextField(
            widget: 'sizedOfBox',
          ),
          BuildTextField(
            widget: 'button',
          ),
        ],
      ),
    );
  }

  Widget textFieldGivenOrSell() {
    if (type == 'Given') {
      return BuildTextField(
        widget: 'Free',
        color: '#FFFFFF',
        desc: 'Price',
        enabled: false,
      );
    } else {
      return BuildTextField(
        color: '#FFFFFF',
        desc: 'Price',
        enabled: true,
      );
    }
  }
}
