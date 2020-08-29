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
  bool flagFilter;
  String _filter = 'All Items';
  List<bool> selected = [];
  List _filterMenu = [
    {
      'status': [
        'All Items',
        'Available',
        'Given',
        'Sold',
      ]
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
    },
    {
      'season': [
        'Summer',
        'Autumn',
        'Spring',
        'Winter',
      ]
    },
    {},
  ];

  @override
  void initState() {
    super.initState();
    _isSearching = false;
    _controller.addListener(_listener);
    flag = false;
    _searchText = '';
    flagFilter = false;
    for (var i in _filterMenu[2]['category']) {
      selected.add(false);
    }
  }

  Future getData() async {
    QuerySnapshot data = await _databaseService.getClothesByCategory();
    List<DocumentSnapshot> documents = data.documents;
    List<DocumentSnapshot> categories = [];

    if (documents.isEmpty) {
      return null;
    } else {
      documents.forEach((e) {
        var category = e.data['category'][0];
        if (category == widget.category) {
          categories.add(e);
        }
        if (widget.category == 'All Items') {
          categories.add(e);
        }
      });
      return categories;
    }
  }

  Clothes _addClothes(List<dynamic> data, int i) {
    Clothes clothes;
    if (!flagFilter) {
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
    } else {
      // if(){

      // }
    }
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
          icon: Icon(Icons.close),
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
              // DropdownButton(
              //   // isExpanded: false,
              //   icon: Image(
              //     height: 24,
              //     image: AssetImage('assets/images/filterIcon.png'),
              //   ),
              //   items: _filterMenu
              //       .map(
              //         (label) => DropdownMenuItem(
              //           child: Text(
              //             label,
              //             style: TextStyle(
              //               fontSize: 12.0,
              //               color: Color(0xff3F4D55),
              //             ),
              //           ),
              //           value: label,
              //         ),
              //       )
              //       .toList(),
              //   onChanged: (val) {
              //     _filter = val;
              //   },
              // ),
              IconButton(
                icon: Image(
                  image: AssetImage('assets/images/filterIcon.png'),
                ),
                onPressed: () {
                  // setState(() {
                  //   flagFilter = !flagFilter;
                  // });
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                            Wrap(
                              spacing: 5.0,
                              children: <Widget>[
                                for (var i in _filterMenu[0]['status'])
                                  Chip(
                                    label: Text('$i'),
                                  ),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Fabrics',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                                Text(
                                  'See All',
                                  style: TextStyle(color: Color(0xffE1C8B4)),
                                ),
                              ],
                            ),
                            Wrap(
                              spacing: 5.0,
                              children: <Widget>[
                                for (int i = 0; i < 7; i++)
                                  Chip(
                                    label:
                                        Text('${_filterMenu[1]['fabric'][i]}'),
                                  ),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Categories',
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
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  IconButton(
                                                    iconSize: 30.0,
                                                    icon: Icon(
                                                      Icons.close,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  Text(
                                                    'Categories',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Expanded(
                                                child: ListView.builder(
                                                  itemCount: _filterMenu[2]
                                                          ['category']
                                                      .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    print(selected.length);
                                                    return ListTile(
                                                      title: Text(
                                                        '${_filterMenu[2]['category'][index]}',
                                                      ),
                                                      onTap: () async {
                                                        setState(() {
                                                          selected[index] =
                                                              !selected[index];
                                                        });
                                                      },
                                                      trailing: selected[index]
                                                          ? Icon(
                                                              Icons.check_box)
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
                                  child: Text(
                                    'See All',
                                    style: TextStyle(
                                      color: Color(0xffE1C8B4),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Wrap(
                              spacing: 5.0,
                              children: <Widget>[
                                for (int i = 0; i < 7; i++)
                                  Chip(
                                    label: Text(
                                        '${_filterMenu[2]['category'][i]}'),
                                  ),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              'Seasons',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                            Wrap(
                              spacing: 5.0,
                              children: <Widget>[
                                for (var i in _filterMenu[3]['season'])
                                  Chip(
                                    label: Text('$i'),
                                  ),
                              ],
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
          Clothes clothes = _addClothes(data, i);
          var status = data[i]['status'];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TemplateDetail(
                            clothes: clothes,
                          )));
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
