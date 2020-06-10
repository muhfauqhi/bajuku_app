import 'dart:async';

import 'package:bajuku_app/services/chips_input.dart';
import 'package:flutter/material.dart';

class DemoScreen extends StatefulWidget {
  @override
  _DemoScreenState createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ChipsInput(
                decoration: InputDecoration(
                  hintText: 'Category search',
                  // enabled: false,
                  // fillColor: Colors.red,
                  // filled: true,
                  ),
                findSuggestions: _findSuggestions,
                onChanged: _onChanged,
                chipBuilder: (BuildContext context, ChipsInputState<Category> state, Category category) {
                  return InputChip(
                    key: ObjectKey(category),
                    label: Text(category.categoryName + '/' + category.subCategoryName),
                    avatar: CircleAvatar(
                      child: Text(category.categoryName[0]),
                    ),
                    onDeleted: () => state.deleteChip(category),
                    onSelected: (_) => _onChipTapped(category),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  );
                },
                suggestionBuilder: (BuildContext context, ChipsInputState<Category> state, Category category) {
                  return Container(
                    padding: EdgeInsets.zero,
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      key: ObjectKey(category),
                      leading: CircleAvatar(
                        child: Text(category.categoryName[0]),
                      ),
                      title: Text(category.categoryName),
                      subtitle: Text(category.categoryName + '/' + category.subCategoryName),
                      onTap: () => state.selectSuggestion(category),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
    );
  }

  void _onChipTapped(Category category) {
    print('$category');
  }

  void _onChanged(List<Category> data) {
    print('onChanged $data');
  }

  Future<List<Category>> _findSuggestions(String query) async {
    if (query.length != 0) {
      return mockResults.where((profile) {
        return profile.categoryName.contains(query) || profile.categoryName.contains(query);
      }).toList(growable: false);
    } else {
      return const <Category>[];
    }
  }
}

// -------------------------------------------------

const mockResults = <Category>[
      Category('Accessories', 'Caps and Hats'),
      Category('Accessories', 'Headbands'),
      Category('Accessories', 'Head Tie/Scarves'),
      Category('Accessories', 'Belts'),
      Category('Accessories', 'Eyewear'),
      Category('Accessories', 'Wallets & Card Holder'),
      Category('Accessories', 'Jewelry'),
      Category('Accessories', 'Scarves'),
      Category('Accessories', 'Ties'),
      Category('Accessories', 'Watches'),
      Category('Accessories', 'Others'),
      Category('Tops', 'T-Shirts'),
      Category('Tops', 'Blouses'),
      Category('Tops', 'Tube top'),
      Category('Tops', 'Crop Tops'),
      Category('Tops', 'Sweaters'),
      Category('Full Body Wear', 'Dresses/Gowns'),
      Category('Full Body Wear', 'Activewear'),
      Category('Full Body Wear', 'Rompers'),
      Category('Bottoms', 'Pants/Trousers'),
      Category('Bottoms', 'Skirts'),
      Category('Bottoms', 'Shorts'),
      Category('Bottoms', 'Sarong'),
      Category('Bottoms', 'Tights and Leggings'),
      Category('Bottoms', 'Jeans'),
      Category('Innerwear', 'Long/Thermal Underwear'),
      Category('Innerwear', 'Tank Top'),
      Category('Innerwear', 'Underwear/Underpants'),
      Category('Innerwear', 'Bras'),
      Category('Innerwear', 'Corsets and Body Shapers'),
      Category('Innerwear', 'Slip'),
      Category('Innerwear', 'Panties/Underwear'),
      Category('Outerwear', 'Coats'),
      Category('Outerwear', 'Jackets and Hoodies'),
      Category('Outerwear', 'Vest/Waistcoat'),
      Category('Outerwear', 'Robes and CLoaks'),
      Category('Outerwear', 'Poncho'),
      Category('Outerwear', 'Scarves and Shawls'),
      Category('Outerwear', 'Windbreaker'),
      Category('Outerwear', 'Gloves'),
      Category('Footwear', 'Shoes'),
      Category('Footwear', 'Sandals'),
      Category('Footwear', 'Boots'),
      Category('Footwear', 'Sneakers'),
      Category('Footwear', 'Wedges'),
      Category('Footwear', 'Loafers'),
      Category('Footwear', 'Flats'),
      Category('Socks', ''),
      Category('Bags', 'Shoulder'),
      Category('Bags', 'Briefcase'),
      Category('Bags', 'Backpack'),
      Category('Bags', 'Clutch'),
      Category('Bags', 'Tote'),
      Category('Bags', 'Crossbody'),
      Category('Bags', 'Luggage and Travel'),
];

class Category {
  final String categoryName;
  final String subCategoryName;

  const Category(this.categoryName, this.subCategoryName);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Category && runtimeType == other.runtimeType && categoryName == other.categoryName;

  @override
  int get hashCode => categoryName.hashCode;

  @override
  String toString() {
    return 'Category{$categoryName}';
  }
}