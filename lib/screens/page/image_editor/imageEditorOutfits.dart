import 'dart:io';

import 'package:bajuku_app/models/clothes.dart';
import 'package:bajuku_app/screens/home/home.dart';
import 'package:bajuku_app/screens/page/addItem/addOutfitDetails.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:bajuku_app/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:speech_bubble/speech_bubble.dart';

class ImageEditorOutifts extends StatefulWidget {
  final File image;

  const ImageEditorOutifts({Key key, this.image}) : super(key: key);

  @override
  _ImageEditorOutiftsState createState() => _ImageEditorOutiftsState();
}

class _ImageEditorOutiftsState extends State<ImageEditorOutifts> {
  List<DragItem> _children;

  @override
  void initState() {
    super.initState();
    _children = List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.only(right: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: Text(
                  'Cancel',
                  style: TextStyle(
                      color: Color(0xff3F4D55),
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
                onTap: () {
                  return showDialog(
                    context: context,
                    child: buildShowDialogCancelFeedback(context),
                  );
                },
              ),
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Text(
                  'Edit Image',
                  style: TextStyle(
                    color: Color(0xff3F4D55),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              GestureDetector(
                child: Text(
                  'Use Photo',
                  style: TextStyle(
                    color: Color(0xff3F4D55),
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onTap: () {
                  if (_children.length > 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddOutfitDetailScreen(
                          image: widget.image,
                          children: _children,
                        ),
                      ),
                    );
                  } else {
                    // TODO feedback showdialog harus tag clothes
                    print('no');
                  }
                },
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 0.85,
                child: Image(
                  fit: BoxFit.cover,
                  image: FileImage(widget.image),
                ),
              ),
              for (var i in _children) i,
            ],
          ),
          SizedBox(height: 20.0),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            child: Text(
              DateFormat('dd MMMM yyyy').format(DateTime.now()),
              style: TextStyle(
                color: Color(0xff3F4D55),
                fontSize: 12.0,
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15.0),
                color: Color(0xffE1C8B4).withOpacity(0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _buildIcon('bi_brightness-high'),
                    _buildIcon('crop'),
                    _buildIcon('ion_contrast'),
                    _buildIcon('uil_temperature'),
                    _buildIcon('cil_drop'),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(15.0),
                color: Color(0xffFFFFFF),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _buildIcon('uil_image-edit'),
                    _buildIcon('cil_tags', context: context),
                    _buildIcon('undo'),
                    _buildIcon('redo'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(String asset, {BuildContext context}) {
    return GestureDetector(
      onTap: () async {
        if (context != null) {
          var data = await getData();
          if (data != null) {
            for (var i in data) {
              setState(() {
                _children = data;
                i.draggable = false;
              });
            }
          }
        } else {
          return null;
        }
      },
      child: Image(
        height: asset == 'redo' || asset == 'undo' ? 25 : 30,
        fit: BoxFit.cover,
        image: AssetImage('assets/images/$asset.png'),
      ),
    );
  }

  Widget buildShowDialogCancelFeedback(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      contentPadding: EdgeInsets.only(top: 0.0),
      children: <Widget>[
        Container(
          color: Colors.transparent,
          width: 280,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 30, bottom: 40),
                child: Image.asset(
                  'assets/images/textCancelFeedback.png',
                  width: 240,
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Image.asset(
                        'assets/images/keepWorkingButton.png',
                        width: 140,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    GestureDetector(
                      child: Image.asset(
                        'assets/images/cancelButton.png',
                        width: 140,
                      ),
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Future getData() async {
    var results;
    for (var i in _children) {
      setState(() {
        i.draggable = true;
      });
    }
    if (_children.length < 0) {
      results = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TaggingScreen(
            image: widget.image,
          ),
        ),
      );
    } else {
      results = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TaggingScreen(
            image: widget.image,
            children: _children,
          ),
        ),
      );
    }
    return results;
  }
}

class TagClothes extends StatefulWidget {
  @override
  _TagClothesState createState() => _TagClothesState();
}

class _TagClothesState extends State<TagClothes> {
  final TextEditingController _controller = TextEditingController();
  final DatabaseService _databaseService = DatabaseService();
  List searchResult = List();
  bool flag = false;
  final _key = new GlobalKey<ScaffoldState>();
  bool _isSearching;
  String search = '';

  @override
  void initState() {
    super.initState();
    _isSearching = false;
    _controller.addListener((_listener));
  }

  void _listener() {
    if (_controller.text.isEmpty) {
      setState(() {
        search = '';
      });
    } else {
      setState(() {
        _isSearching = true;
        search = _controller.text;
      });
    }
  }

  Future getData() async {
    QuerySnapshot data = await _databaseService.getClothesAvailable();
    List<DocumentSnapshot> documents = data.documents;

    if (documents.isEmpty) {
      return null;
    } else {
      return documents;
    }
  }

  void searchOperation(String searchText) async {
    List<DocumentSnapshot> snapshot = await getData();
    searchResult.clear();
    if (_isSearching != null) {
      for (int i = 0; i < snapshot.length; i++) {
        String data = snapshot[i].data['clothName'];
        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          setState(() {
            searchResult.add(snapshot[i]);
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F6F4),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _buildSearch(context),
            FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      if (searchResult.length != 0 ||
                          _controller.text.isNotEmpty) {
                        return _buildItems(searchResult);
                      } else {
                        return _buildItems(snapshot.data);
                      }
                    }
                    return Loading();
                  } else {
                    return Loading();
                  }
                }),
          ],
        ),
      ),
    );
  }

  Widget _buildItems(List<dynamic> data) {
    return Expanded(
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          String name = data[index].data['clothName'];
          String category = data[index].data['category'].toString();
          String image = data[index].data['image'];
          category = category.substring(1, category.length - 1);
          return ListTile(
            contentPadding: EdgeInsets.all(20),
            leading: CircleAvatar(
              foregroundColor: Colors.transparent,
              backgroundImage: NetworkImage(
                image,
              ),
              radius: 25,
            ),
            dense: false,
            title: Text(
              name,
              style: TextStyle(
                color: Color(0xff3F4D55),
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              category,
              style: TextStyle(
                color: Color(0xff859289),
              ),
            ),
            onTap: () {
              var c = data[index].data;
              Clothes cloth = Clothes(
                data[index].documentID,
                c['brand'],
                c['category'],
                c['clothName'],
                c['color'],
                c['cost'],
                c['dateBought'],
                c['endDate'],
                c['fabric'],
                c['image'],
                c['price'],
                c['notes'],
                c['season'],
                c['size'],
                c['startDate'],
                c['status'],
                c['updateDate'],
                c['url'],
                c['usedInOutfit'],
                c['worn'],
              );
              Navigator.pop(context, cloth);
            },
          );
        },
      ),
    );
  }

  Widget _buildSearch(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              controller: _controller,
              onChanged: searchOperation,
              decoration: InputDecoration(
                hintText: 'Search your clothes...',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                contentPadding: EdgeInsets.all(10),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey[500],
                ),
                filled: true,
                suffixIcon: search.length != 0
                    ? IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.grey[500],
                        ),
                        onPressed: () {
                          setState(() {
                            search = '';
                            _controller.clear();
                          });
                        },
                      )
                    : null,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 14.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TaggingScreen extends StatefulWidget {
  final File image;
  final List<DragItem> children;

  const TaggingScreen({Key key, this.image, this.children}) : super(key: key);
  @override
  _TaggingScreenState createState() => _TaggingScreenState();
}

GlobalKey keyImage = GlobalKey();

class _TaggingScreenState extends State<TaggingScreen> {
  List<DragItem> _children;

  @override
  void initState() {
    super.initState();
    if (widget.children == null) {
      _children = List();
    } else {
      _children = widget.children;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: Text(
                  'Cancel',
                  style: TextStyle(
                      color: Color(0xff3F4D55),
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
                onTap: () {
                  return showDialog(
                    context: context,
                    child: buildShowDialogCancelFeedback(context),
                  );
                },
              ),
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Text(
                  'Tag Clothes',
                  style: TextStyle(
                    color: Color(0xff3F4D55),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              GestureDetector(
                child: Text(
                  'Done',
                  style: TextStyle(
                    color: Color(0xff3F4D55),
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context, _children);
                },
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          AspectRatio(
            key: keyImage,
            aspectRatio: 0.85,
            child: GestureDetector(
              onTap: () async {
                var data = await getData();
                if (data != null) {
                  String name = data.clothName;
                  String category = data.category
                      .toString()
                      .substring(1, data.category.toString().length - 1);
                  setState(() {
                    _children.add(
                      DragItem(
                        data: data,
                        name: name,
                        category: category,
                        locationWidget: Offset(0.0, 0.0),
                      ),
                    );
                  });
                }
              },
              child: Image(
                fit: BoxFit.cover,
                image: FileImage(widget.image),
              ),
            ),
          ),
          for (var i in _children) i,
          // DragTarget(
          //   onAccept: (test) {},
          //   builder: (context, t, a) {
          //     return Container(
          //       height: 100,
          //       color: Colors.red,
          //     );
          //   },
          // ),
        ],
      ),
    );
  }

  Widget buildShowDialogCancelFeedback(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      contentPadding: EdgeInsets.only(top: 0.0),
      children: <Widget>[
        Container(
          color: Colors.transparent,
          width: 280,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 30, bottom: 40),
                child: Image.asset(
                  'assets/images/textCancelFeedback.png',
                  width: 240,
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Image.asset(
                        'assets/images/keepWorkingButton.png',
                        width: 140,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    GestureDetector(
                      child: Image.asset(
                        'assets/images/cancelButton.png',
                        width: 140,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImageEditorOutifts(
                              image: widget.image,
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Future getData() async {
    var results = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => TagClothes()));
    return results;
  }
}

RenderBox renderBox = keyImage.currentContext.findRenderObject();
final size = renderBox.size;

class DragItem extends StatefulWidget {
  final data;
  Offset locationWidget;
  dynamic nipLocation = NipLocation.BOTTOM;
  final String name;
  final String category;
  double top = 0;
  double left = 0;
  bool draggable;
  DragItem({
    Key key,
    this.name,
    this.category,
    this.nipLocation = NipLocation.BOTTOM,
    this.locationWidget,
    this.top,
    this.left,
    this.data,
    this.draggable = true,
  }) : super(key: key);

  @override
  _DragItemState createState() => _DragItemState();
}

class _DragItemState extends State<DragItem> {
  GlobalKey key = GlobalKey();

  @override
  void initState() {
    super.initState();
    widget.top = widget.locationWidget.dy;
    widget.left = widget.locationWidget.dx;
    if (widget.left < (size.width / 2)) {
      if (widget.top > size.height / 2) {
        widget.nipLocation = NipLocation.TOP_RIGHT;
      } else if (widget.left < size.height / 2) {
        widget.nipLocation = NipLocation.BOTTOM_RIGHT;
      } else {
        widget.nipLocation = NipLocation.RIGHT;
      }
    } else if (widget.left > (size.width / 2)) {
      if (widget.top > size.height / 2) {
        widget.nipLocation = NipLocation.TOP_LEFT;
      } else if (widget.top < size.height / 2) {
        widget.nipLocation = NipLocation.BOTTOM_LEFT;
      } else {
        widget.nipLocation = NipLocation.LEFT;
      }
    } else {
      widget.nipLocation = NipLocation.TOP;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.draggable
        ? Draggable(
            child: Container(
              padding: EdgeInsets.only(top: widget.top, left: widget.left),
              child: Bubble(
                nipLocation: widget.nipLocation,
                name: widget.name,
                category: widget.category,
              ),
            ),
            feedback: Container(
              padding: EdgeInsets.only(top: widget.top, left: widget.left),
              child: Bubble(
                nipLocation: widget.nipLocation,
                name: widget.name,
                category: widget.category,
              ),
            ),
            childWhenDragging: Container(
              padding: EdgeInsets.only(top: widget.top, left: widget.left),
              child: Bubble(
                key: key,
                nipLocation: widget.nipLocation,
                name: widget.name,
                category: widget.category,
              ),
            ),
            onDragCompleted: () {},
            onDragEnd: (drag) {
              setState(() {
                RenderBox widgets = key.currentContext.findRenderObject();
                final sizeWidget = widgets.size;

                if ((widget.top + drag.offset.dy - sizeWidget.height) >
                    (size.height)) {
                  widget.top = size.height - sizeWidget.height - 10.0;
                } else if ((widget.top + drag.offset.dy - 80.0) < 0.0) {
                  widget.top = 0;
                } else {
                  widget.top = widget.top + drag.offset.dy - 80.0;
                }
                if ((widget.left + drag.offset.dx + sizeWidget.width) >
                    (size.width)) {
                  widget.left = size.width - sizeWidget.width;
                } else if ((widget.left + drag.offset.dx) < 0.0) {
                  widget.left = 0;
                } else {
                  widget.left = widget.left + drag.offset.dx;
                  Offset location = Offset(widget.left, widget.top);
                  setState(() {
                    if (location.dx < (size.width / 2)) {
                      if (location.dy > size.height / 2) {
                        widget.nipLocation = NipLocation.TOP_RIGHT;
                      } else if (location.dy < size.height / 2) {
                        widget.nipLocation = NipLocation.BOTTOM_RIGHT;
                      } else {
                        widget.nipLocation = NipLocation.RIGHT;
                      }
                    } else if (location.dx > (size.width / 2)) {
                      if (location.dy > size.height / 2) {
                        widget.nipLocation = NipLocation.TOP_LEFT;
                      } else if (location.dy < size.height / 2) {
                        widget.nipLocation = NipLocation.BOTTOM_LEFT;
                      } else {
                        widget.nipLocation = NipLocation.LEFT;
                      }
                    } else {
                      widget.nipLocation = NipLocation.TOP;
                    }
                  });
                }
                setLocation(Offset(widget.left, widget.top));
              });
            },
          )
        : Container(
            padding: EdgeInsets.only(top: widget.top, left: widget.left),
            child: Bubble(
              nipLocation: widget.nipLocation,
              name: widget.name,
              category: widget.category,
            ),
          );
  }

  setLocation(Offset location) {
    setState(() {
      widget.locationWidget = location;
    });
  }
}

class Bubble extends StatefulWidget {
  final nipLocation;
  final String name;
  final String category;
  Bubble({
    Key key,
    this.nipLocation,
    this.name,
    this.category,
  }) : super(key: key);

  @override
  _BubbleState createState() => _BubbleState();
}

class _BubbleState extends State<Bubble> {
  @override
  Widget build(BuildContext context) {
    return SpeechBubble(
      color: Colors.white,
      borderRadius: 0,
      nipLocation: widget.nipLocation,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                '${widget.name}',
                style: TextStyle(
                  color: Color(0xff3F4D55),
                  fontWeight: FontWeight.w600,
                  fontSize: 9.0,
                ),
              ),
              Text(
                '${widget.category}',
                style: TextStyle(
                  color: Color(0xff859289),
                  fontSize: 9.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
