import 'package:bajuku_app/models/clothes.dart';
import 'package:bajuku_app/screens/page/scaffold/myscaffold.dart';
import 'package:bajuku_app/screens/template/templateDetail.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:bajuku_app/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  final String category;

  const CategoriesScreen({Key key, this.category}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final DatabaseService _databaseService = DatabaseService();
  final TextEditingController _controller = TextEditingController();
  List searchresult = List();
  bool flag;
  final _key = new GlobalKey<ScaffoldState>();
  bool _isSearching;
  String _searchText;
  List<String> selectedStatus;
  List<String> selectedSeason;
  List<String> selectedFabric;
  List<String> selectedCategory;
  List<bool> selectedCategoryBool = [];
  List<bool> selectedFabricBool = [];
  List _filterMenu = [
    {
      'status': [
        'Available',
        'Washing',
        'Given',
        'Sold',
        'Unavailable',
      ],
    },
    {
      'fabric': [
        'Acetate',
        'Bamboo',
        'Cotton',
        'Chiffon',
        'Chino',
        'Charmeuse',
        'Combed Cotton',
        'Coolmax',
        'Corduroy',
        'Ecosil Polyester',
        'Fleece',
        'Interlock Knit',
        'Jacquard',
        'Jersey',
        'Jeans',
        'Knit',
        'Leather',
        'Lace',
        'Latex',
        'Linen',
        'Lycra',
        'Lyocell',
        'Memory Foam',
        'Microfiber',
        'Microfleece',
        'Neoprene',
        'Nylon',
        'Pique',
        'Polyester',
        'Rayon',
        'Satin',
        'Silk',
        'Spandex',
        'Suede',
        'Tencel',
        'Tactel',
        'Thermastat',
        'Velvet',
        'Viscose',
        'Vinyl',
        'Wool',
        'Woven',
      ],
      'fabricSuggestion': [
        'Acetate',
        'Cotton',
        'Wool',
        'Satin',
        'Nylon',
      ],
    },
    {
      'category': [
        'Accessories',
        'Tops',
        'Full Body Wear',
        'Bottoms',
        'Innerwear',
        'Outerwear',
        'Footwear',
        'Socks',
        'Bags',
        'Caps and Hats',
        'Headbands',
        'Head Tie/Scarves',
        'Belts',
        'Eyewear',
        'Wallets & Card Holder',
        'Jewelry',
        'Scarves',
        'Ties',
        'Watches',
        'Others',
      ],
      'categorySuggestion': [
        'Accessories',
        'Tops',
        'Full Body Wear',
        'Bottoms',
        'Innerwear',
        'Outerwear',
        'Footwear',
      ],
    },
    {
      'season': [
        'Summer',
        'Autumn',
        'Spring',
        'Winter',
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    selectedStatus = List();
    selectedSeason = List();
    selectedFabric = List();
    selectedCategory = List();
    _isSearching = false;
    _controller.addListener(_listener);
    flag = false;
    _searchText = '';
    for (var i in _filterMenu[2]['category']) {
      selectedCategoryBool.add(false);
    }
    for (var i in _filterMenu[1]['fabric']) {
      selectedFabricBool.add(false);
    }
  }

  Future getData() async {
    QuerySnapshot data = await _databaseService.getClothesByCategory();
    var documents = data.documents;
    List<DocumentSnapshot> ds = [];

    if (documents.isEmpty) {
      return null;
    } else {
      documents.forEach((e) {
        var category = e.data['category'][0];
        if (category == widget.category) {
          ds.add(e);
        }
        if (widget.category == 'All Items') {
          ds.add(e);
        }
      });
      return ds;
    }
  }

  Clothes _addClothes(List<dynamic> data, int i) {
    Clothes clothes;
    clothes = Clothes(
      data[i].documentID,
      data[i]['brand'],
      data[i]['category'],
      data[i]['clothName'],
      data[i]['color'],
      data[i]['cost'],
      data[i]['dateBought'],
      data[i]['endDate'],
      data[i]['fabric'],
      data[i]['image'],
      data[i]['price'],
      data[i]['notes'],
      data[i]['season'],
      data[i]['size'],
      data[i]['startDate'],
      data[i]['status'],
      data[i]['updateDate'],
      data[i]['url'],
      data[i]['usedInOutfit'],
      data[i]['worn'],
    );
    return clothes;
  }

  void _listener() {
    if (_controller.text.isEmpty) {
      setState(() {
        _searchText = '';
      });
    } else {
      setState(() {
        _isSearching = true;
        _searchText = _controller.text;
      });
    }
  }

  void searchOperation(String searchText) async {
    List<DocumentSnapshot> snapshot = await getData();
    searchresult.clear();
    if (_isSearching != null) {
      for (int i = 0; i < snapshot.length; i++) {
        String data = snapshot[i].data['clothName'];
        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          setState(() {
            searchresult.add(snapshot[i]);
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            return MyScaffold(
              key: _key,
              isTitleWidget: false,
              titleWidget: _isSearching ? _appBarSearch() : _appBarTitle(),
              headerWidget: <Widget>[
                if (searchresult.length != 0 || _controller.text.isNotEmpty)
                  _buildTitle(searchresult)
                else
                  _buildTitle(snapshot.data),
              ],
              body: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  searchresult.length != 0 || _controller.text.isNotEmpty
                      ? _buildItems(searchresult)
                      : _buildItems(snapshot.data),
                  SizedBox(height: 50),
                ],
              ),
            );
          } else {
            return Loading();
          }
        } else {
          return Loading();
        }
      },
    );
  }

  Widget _appBarTitle() {
    return Text(
      'Your Wardrobe',
      style: TextStyle(
        color: Color(0xff3F4D55),
        fontSize: 16.0,
        letterSpacing: 1.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _appBarSearch() {
    return TextFormField(
      controller: _controller,
      onChanged: searchOperation,
      style: TextStyle(
        color: Color(0xff3F4D55),
        fontSize: 20.0,
        letterSpacing: 1.0,
        fontWeight: FontWeight.w600,
      ),
      autofocus: true,
      decoration: InputDecoration(
        focusedBorder: InputBorder.none,
        border: InputBorder.none,
        hintText: 'Search your clothes...',
        hintStyle: TextStyle(
          color: Color(0xff3F4D55),
          fontSize: 14.0,
          letterSpacing: 1.0,
          fontWeight: FontWeight.w600,
        ),
        suffixIcon: IconButton(
          color: Colors.grey,
          focusColor: Colors.grey,
          icon: Icon(
            Icons.close,
          ),
          onPressed: () {
            setState(() {
              _isSearching = false;
              _controller.clear();
              searchresult.clear();
            });
          },
        ),
      ),
    );
  }

  Widget _buildTitle(dynamic data) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 5.0),
              Text(
                '${widget.category}',
                style: TextStyle(
                  color: Color(0xff3F4D55),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                  fontStyle: FontStyle.normal,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '${data.length} Items',
                style: TextStyle(
                  color: Color(0xff859289),
                  fontSize: 12.0,
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: Image(
                  image: AssetImage('assets/images/searchIcon.png'),
                ),
                onPressed: () {
                  setState(() {
                    flag = true;
                    _isSearching = true;
                  });
                },
              ),
              IconButton(
                icon: Image(
                  image: AssetImage('assets/images/filterIcon.png'),
                ),
                onPressed: () {
                  setState(() {});
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return Container(
                        padding: EdgeInsets.only(
                          left: 20.0,
                          top: 20.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Filter',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                                IconButton(
                                  iconSize: 30.0,
                                  icon: Icon(
                                    Icons.close,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              'Status',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                            MultiSelectChip(
                              reportList: _filterMenu[0]['status'],
                              onSelectionChanged: (selectedList) {
                                setState(() {
                                  selectedStatus = selectedList;
                                });
                              },
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              'Seasons',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                            MultiSelectChip(
                              reportList: _filterMenu[3]['season'],
                              onSelectionChanged: (selectedList) {
                                setState(() {
                                  selectedSeason = selectedList;
                                });
                              },
                            ),
                            SizedBox(height: 10.0),
                            Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Fabrics',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (context) {
                                          return StatefulBuilder(
                                            builder: (context, setState) {
                                              return Container(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 20.0,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Row(
                                                          children: <Widget>[
                                                            IconButton(
                                                              iconSize: 30.0,
                                                              icon: Icon(
                                                                Icons.close,
                                                              ),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            ),
                                                            Text(
                                                              'Fabrics',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 20.0,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  12.0),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text(
                                                              'Save',
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Expanded(
                                                      child: ListView.builder(
                                                        itemCount:
                                                            _filterMenu[1]
                                                                    ['fabric']
                                                                .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return ListTile(
                                                            title: Text(
                                                              '${_filterMenu[1]['fabric'][index]}',
                                                            ),
                                                            onTap: () {
                                                              setState(() {
                                                                selectedFabricBool[
                                                                        index] =
                                                                    !selectedFabricBool[
                                                                        index];
                                                              });
                                                            },
                                                            trailing: selectedFabricBool[
                                                                    index]
                                                                ? Icon(Icons
                                                                    .check_box)
                                                                : Icon(Icons
                                                                    .check_box_outline_blank),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                    child: Text(
                                      'See All',
                                      style: TextStyle(
                                        color: Color(0xffE1C8B4),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            MultiSelectChip(
                              reportList: _filterMenu[1]['fabricSuggestion'],
                              onSelectionChanged: (selectedList) {
                                setState(() {
                                  selectedFabric = selectedList;
                                });
                              },
                            ),
                            SizedBox(height: 10.0),
                            Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Categories',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (context) {
                                          return StatefulBuilder(
                                            builder: (context, setState) {
                                              return Container(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 20.0,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Row(
                                                          children: <Widget>[
                                                            IconButton(
                                                              iconSize: 30.0,
                                                              icon: Icon(
                                                                Icons.close,
                                                              ),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            ),
                                                            Text(
                                                              'Categories',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 20.0,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  12.0),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              // Navigator.pop(
                                                              //     context);
                                                              // selectedCategoryBool.forEach((e) { })
                                                              List<int>
                                                                  selectedBool =
                                                                  List();
                                                              for (int i = 0;
                                                                  i <
                                                                      selectedCategoryBool
                                                                          .length;
                                                                  i++) {
                                                                if (selectedCategoryBool[
                                                                    i]) {
                                                                  selectedBool
                                                                      .add(i);
                                                                }
                                                              }
                                                              print(
                                                                  selectedBool);
                                                            },
                                                            child: Text(
                                                              'Save',
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Expanded(
                                                      child: ListView.builder(
                                                        itemCount:
                                                            _filterMenu[2]
                                                                    ['category']
                                                                .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return ListTile(
                                                            title: Text(
                                                              '${_filterMenu[2]['category'][index]}',
                                                            ),
                                                            onTap: () {
                                                              setState(() {
                                                                selectedCategoryBool[
                                                                        index] =
                                                                    !selectedCategoryBool[
                                                                        index];
                                                              });
                                                            },
                                                            trailing: selectedCategoryBool[
                                                                    index]
                                                                ? Icon(Icons
                                                                    .check_box)
                                                                : Icon(Icons
                                                                    .check_box_outline_blank),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                    child: Text(
                                      'See All',
                                      style: TextStyle(
                                        color: Color(0xffE1C8B4),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            MultiSelectChip(
                              reportList: _filterMenu[2]['categorySuggestion'],
                              onSelectionChanged: (selectedList) {
                                setState(() {
                                  selectedCategory = selectedList;
                                });
                              },
                            ),
                            SizedBox(height: 40.0),
                            Center(
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                textColor: Color(0xffE1C8B4),
                                padding: EdgeInsets.symmetric(
                                  vertical: 15.0,
                                  horizontal: 90.0,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                                color: Color(0xff4AA081),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItems(List<dynamic> data) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        shrinkWrap: true,
        itemBuilder: (context, i) {
          Clothes clothes;
          var status = data[i]['status'];
          clothes = _addClothes(data, i);
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TemplateDetail(
                    clothes: clothes,
                  ),
                ),
              );
            },
            child: Stack(
              children: <Widget>[
                Card(
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: ColorFiltered(
                        colorFilter: status == 'Sold' || status == 'Given'
                            ? ColorFilter.mode(Colors.grey, BlendMode.color)
                            : ColorFilter.mode(
                                Colors.transparent, BlendMode.color),
                        child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            '${data[i]['image']}',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // if (status == 'Sold' || status == 'Given')
                //   Center(
                //     child: Text(
                //       status,
                //       style: TextStyle(
                //         color: Color(0xffD96969),
                //         fontSize: 16.0,
                //       ),
                //     ),
                //   ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MultiSelectChip extends StatefulWidget {
  final List<String> reportList;
  final Function(List<String>) onSelectionChanged;

  MultiSelectChip({Key key, this.reportList, this.onSelectionChanged})
      : super(key: key);
  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  List<String> selectedChoices = List();

  _buildChoiceList() {
    List<Widget> choices = List();

    widget.reportList.forEach((item) {
      choices.add(
        Container(
          child: ChoiceChip(
            elevation: 3.0,
            selectedColor: Color(0xffE1C8B4).withOpacity(0.5),
            labelStyle: TextStyle(
              color: Colors.black,
            ),
            backgroundColor: Color(0xffFFFFFF),
            shadowColor: Colors.grey,
            label: Text(item),
            selected: selectedChoices.contains(item),
            onSelected: (selected) {
              setState(() {
                selectedChoices.contains(item)
                    ? selectedChoices.remove(item)
                    : selectedChoices.add(item);
                widget.onSelectionChanged(selectedChoices);
              });
            },
          ),
        ),
      );
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5.0,
      children: _buildChoiceList(),
    );
  }
}
