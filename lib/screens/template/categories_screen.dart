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
  bool flag = false;
  final _key = new GlobalKey<ScaffoldState>();
  bool _isSearching;
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _isSearching = false;
    _controller.addListener(_listener);
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
    Clothes clothes = Clothes(
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
              IconButton(
                icon: Image(
                  image: AssetImage('assets/images/filterIcon.png'),
                ),
                onPressed: () {},
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
