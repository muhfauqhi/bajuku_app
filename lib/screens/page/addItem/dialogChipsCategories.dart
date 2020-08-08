import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class DialogChipCategories extends StatefulWidget {
  @override
  _DialogChipCategoriesState createState() => _DialogChipCategoriesState();
}

class _DialogChipCategoriesState extends State<DialogChipCategories> {
  String temp;
  final _myController = TextEditingController();
  static String tags;
  static String tagsTopCategory;

  List<String> cariJumlahTitle(List<Category> tagsList) {
    List<String> alpha = [];
    for (int i = 0; i < tagsList.length; i++) {
      if (alpha.any((e) => e.contains(tagsList[i].categoryName))) {
      } else {
        alpha.add((tagsList[i].categoryName));
      }
    }
    return alpha;
  }

  List<String> cariJumlahSubCategory(List<Category> tagsList) {
    List<String> alpha = [];
    for (int i = 0; i < tagsList.length; i++) {
      if (alpha.any((e) => e.contains(tagsList[i].subCategoryName))) {
      } else {
        alpha.add((tagsList[i].subCategoryName));
      }
    }
    return alpha;
  }

  String cariTitle(String tags, List<Category> cL) {
    for (var i = 0; i < cL.length; i++) {
      if (cL.elementAt(i).subCategoryName.contains(tags)) {
        return cL.elementAt(i).categoryName;
      }
    }
    return 'Tidak ditemukan';
  }

  List<String> categoryListTitle;
  List<String> subCategoryList;

  @override
  void initState() {
    super.initState();
    categoryListTitle = cariJumlahTitle(categoryList);
    subCategoryList = cariJumlahSubCategory(categoryList);
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool flag = true;

  List<String> getTags() {
    List<String> tagsCategory = [];
    if (tagsTopCategory != null && tags != null) {
      tagsCategory.add(tagsTopCategory);
      tagsCategory.add(tags);
    }
    return tagsCategory;
  }

  Widget suggestionList() {
    if (flag) {
      return Expanded(
        child: ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            shrinkWrap: true,
            itemCount: categoryListTitle.length,
            itemBuilder: (context, idx) {
              return ListTile(
                title: Text(
                  categoryListTitle.elementAt(idx),
                  style: TextStyle(
                      color: Hexcolor('#E1C8B4'),
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal),
                ),
                subtitle: ChipsChoice<String>.single(
                    value: tags,
                    itemConfig: ChipsChoiceItemConfig(
                      selectedColor: Hexcolor('#3F4D55'),
                      unselectedColor: Hexcolor('#3F4D55'),
                      labelStyle: TextStyle(
                        color: Hexcolor('#3F4D55'),
                        fontSize: 12.0,
                        fontWeight: FontWeight.normal,
                      ),
                      elevation: 5.0,
                    ),
                    options: ChipsChoiceOption.listFrom<String, Category>(
                        source: categoryList
                            .where((e) =>
                                e.categoryName ==
                                categoryListTitle.elementAt(idx).toString())
                            .toList(),
                        value: (i, v) => v.subCategoryName,
                        label: (i, v) => v.subCategoryName),
                    onChanged: (val) => setState(() {
                          tags = val;
                          tagsTopCategory = cariTitle(tags, categoryList);
                        })),
              );
            }),
      );
    } else {
      if (subCategoryList.any((e) => e.toLowerCase().startsWith(temp))) {
        return ListTile(
          title: Text('Result'),
          subtitle: ChipsChoice<String>.single(
              itemConfig: ChipsChoiceItemConfig(
                selectedColor: Hexcolor('#3F4D55'),
                unselectedColor: Hexcolor('#3F4D55'),
                labelStyle: TextStyle(
                  color: Hexcolor('#3F4D55'),
                  fontSize: 12.0,
                  fontWeight: FontWeight.normal,
                ),
                elevation: 5.0,
              ),
              value: tags,
              options: ChipsChoiceOption.listFrom<String, String>(
                  source: subCategoryList
                      .where(
                          (e) => e.toUpperCase().startsWith(temp.toUpperCase()))
                      .toList(),
                  value: (i, v) => v,
                  label: (i, v) => v),
              onChanged: (val) => setState(() => tags = val)),
        );
      } else {
        return Text('Not found');
      }
    }
  }

  Widget buildChip() {
    if (tags != null) {
      return Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          child: InputChip(
            onPressed: () {
              setState(() {
                tags = null;
              });
            },
            label: Text(
              tags,
              style: TextStyle(
                color: Hexcolor('#3F4D55'),
                fontSize: 12.0,
                fontWeight: FontWeight.normal,
              ),
            ),
            showCheckmark: true,
            checkmarkColor: Hexcolor('#3F4D55'),
            selected: true,
            selectedColor: Hexcolor('#FFFFFF'),
            elevation: 5.0,
          ),
        ),
      );
    } else {
      return Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(children: [
      Container(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(14.0),
              child: TextFormField(
                onSaved: (val) {
                  return tags;
                },
                onChanged: (val) {
                  if (val.isNotEmpty) {
                    setState(() {
                      flag = false;
                      temp = val;
                    });
                  } else {
                    setState(() {
                      flag = true;
                      temp = val;
                    });
                  }
                },
                controller: _myController,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.normal,
                  color: Hexcolor('#3F4D55'),
                ),
                decoration: InputDecoration(
                    hintText: 'Search your categories',
                    suffixIcon: Icon(Icons.search)),
              ),
            ),
            buildChip(),
            Divider(),
            // suggestionList(),
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Image.asset('assets/images/ok.png'),
            ),
          ],
        ),
      ),
    ]);
  }

  List<Category> categoryList = <Category>[
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
    Category('Outerwear', 'Robes and Cloaks'),
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
    Category('Socks', 'Socks'),
    Category('Bags', 'Shoulder'),
    Category('Bags', 'Briefcase'),
    Category('Bags', 'Backpack'),
    Category('Bags', 'Clutch'),
    Category('Bags', 'Tote'),
    Category('Bags', 'Crossbody'),
    Category('Bags', 'Luggage and Travel'),
  ];
}

class Category {
  final String categoryName;
  final String subCategoryName;

  Category(this.categoryName, this.subCategoryName);

  @override
  String toString() {
    return 'Category{$categoryName}';
  }
}
