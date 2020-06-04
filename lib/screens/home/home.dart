import 'package:bajuku_app/screens/Page/journal.dart';
import 'package:bajuku_app/screens/page/add.dart';
import 'package:bajuku_app/screens/page/sustainable.dart';
import 'package:bajuku_app/screens/template/templateCategories.dart';
import 'package:bajuku_app/services/auth.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hexcolor/hexcolor.dart';

class Home extends StatefulWidget {
  final int currentIndex;
  Home({this.currentIndex});
  
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    if(widget.currentIndex == 0){
      return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
              length: 2,
              child: NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
                  return <Widget>[
                    Container(
                      child: SliverAppBar(
                        centerTitle: true,
                        leading: FlatButton(
                          onPressed:  () => Scaffold.of(context).openDrawer(),
                          padding: EdgeInsets.all(0.0),
                          child: Image.asset('assets/images/burger_menu.png',
                              height: 35.0,
                              width: 35.0,
                          ),
                        ),
                        iconTheme: IconThemeData(
                          color: Hexcolor('#3F4D55'),
                        ),
                        backgroundColor: Colors.white,
                        expandedHeight: 50.0,
                        floating: false,
                        pinned: false,
                        flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          title: Image.asset(
                            'assets/images/logo@3x.png',
                            width: 100,
                            height: 30,
                          ),

                        ),
                      ),
                    ),
                    new SliverPadding(
                      padding: EdgeInsets.all(0.0),
                      sliver: new SliverList(
                        delegate: new SliverChildListDelegate([
                          TabBar(
                            labelColor: Hexcolor('#2F4F55'),
                            unselectedLabelColor: Hexcolor('#D3D3D3'),
                            indicatorColor: Hexcolor('#859289'),
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelStyle: TextStyle(
                              letterSpacing: 2.0,
                              fontSize: 16.0,
                            ) ,
                            tabs: [
                              new Tab(
                                text: 'Wardrobe',
                              ),
                              new Tab(
                                text: 'Journal',
                              ),
                            ],
                          ),
                        ]),
                        ),
                      ),
                  ];
                },
          body: TabBarView(
              children: [
                _buildWardrobe(),
                _buildJournal(),
              ],
          ),
        ),
      ),
      drawer: _buildDrawer(context),
    );
    }else{
      return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          DefaultTabController(
                  length: 2,
                  child: NestedScrollView(
                    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
                      return <Widget>[
                        Container(
                          child: SliverAppBar(
                            centerTitle: true,
                            leading: FlatButton(
                              onPressed:  () => Scaffold.of(context).openDrawer(),
                              padding: EdgeInsets.all(0.0),
                              child: Image.asset('assets/images/burger_menu.png',
                                  height: 35.0,
                                  width: 35.0,
                              ),
                            ),
                            iconTheme: IconThemeData(
                              color: Hexcolor('#3F4D55'),
                            ),
                            backgroundColor: Colors.white,
                            expandedHeight: 50.0,
                            floating: false,
                            pinned: false,
                            flexibleSpace: FlexibleSpaceBar(
                              centerTitle: true,
                              title: Image.asset(
                                'assets/images/logo@3x.png',
                                width: 100,
                                height: 30,
                              ),

                            ),
                          ),
                        ),
                        new SliverPadding(
                          padding: EdgeInsets.all(0.0),
                          sliver: new SliverList(
                            delegate: new SliverChildListDelegate([
                              TabBar(
                                labelColor: Hexcolor('#2F4F55'),
                                unselectedLabelColor: Hexcolor('#D3D3D3'),
                                indicatorColor: Hexcolor('#859289'),
                                indicatorSize: TabBarIndicatorSize.tab,
                                labelStyle: TextStyle(
                                  letterSpacing: 2.0,
                                  fontSize: 16.0,
                                ) ,
                                tabs: [
                                  new Tab(
                                    text: 'Wardrobe',
                                  ),
                                  new Tab(
                                    text: 'Journal',
                                  ),
                                ],
                              ),
                            ]),
                            ),
                          ),
                      ];
                    },
              body: TabBarView(
                  children: [
                    _buildWardrobe(),
                    _buildJournal(),
                  ],
              ),
            ),
          ),
          AddItemDialog(),
        ],
      ),
      drawer: _buildDrawer(context),
    );
    }
  }

  Container _buildJournal() {
    return Container(
                child: new Column(
                  children: <Widget>[
                    new Text('Journal'),
                  ],
                ),
              );
  }

  SingleChildScrollView _buildWardrobe() {
    return SingleChildScrollView(
                child: new Column(
                  children: <Widget>[
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        textDirection: TextDirection.rtl,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          new IconButton(
                          icon: new Image.asset('assets/images/seeall@3x.png'
                          ),
                          iconSize: 40,
                          onPressed: (){
                            Navigator.of(context).pop();
                            Navigator.push(context, new MaterialPageRoute(
                                      builder: (BuildContext context) => new TemplateCategories(categories: "All Items",))
                            );
                          }),
                        ],
                    ),
                    _buildAllItems(),
                    FutureBuilder(
                      future: DatabaseService().getClothes('All Items'),
                      builder: (context, snapshot) {
                        if(!snapshot.hasData){
                            return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text('0', 
                                    style: TextStyle(
                                      letterSpacing: 1.0,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                      color: Hexcolor('#3F4D55'),
                                    ),
                                  ),
                                  Text(''),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text('Pieces', 
                                    style: TextStyle(
                                      letterSpacing: 1.0, 
                                      color: Hexcolor('#859289'),
                                    ),
                                  ),
                                  Text('Since May \'20', 
                                    style: TextStyle(
                                      letterSpacing: 1.0, 
                                      color: Hexcolor('#859289'),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }else{
                          return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(snapshot.data.documents.length.toString(), 
                                  style: TextStyle(
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    color: Hexcolor('#3F4D55'),
                                  ),
                                ),
                                Text(''),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text('Pieces', 
                                  style: TextStyle(
                                    letterSpacing: 1.0, 
                                    color: Hexcolor('#859289'),
                                  ),
                                ),
                                Text('Since May \'20', 
                                  style: TextStyle(
                                    letterSpacing: 1.0, 
                                    color: Hexcolor('#859289'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                          );
                        }
                      }
                    ),
                    _buildCategories(),
                    AddItemDialog(),
                  ],
                ),
              );
  }

  Column _buildCategories() {
    return Column(
                    children: <Widget>[
                      _buildAccessoriesAndTops(),
                      _buildBottomsAndFullBodyWear(),
                      _buildOutwearAndInnerwear(),
                      _buildSocksAndFootwear(),
                      _buildBags(),
                    ],
                  );
  }

  Row _buildBags() {
    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,                          
                      children: <Widget>[
                        GestureDetector(
                          child: new Card(
                            child: new Image.asset('assets/images/allitems.png',
                              fit: BoxFit.cover,
                              height: 150.0,
                            ),
                            elevation: 0.0,
                          ),
                          onTap: (){
                            Navigator.of(context).pop();
                            Navigator.push(context, new MaterialPageRoute(
                                      builder: (BuildContext context) => new TemplateCategories(categories: "Bags",))
                            );
                          },
                        ),
                      ],
                    );
  }

  Row _buildSocksAndFootwear() {
    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,                          
                      children: <Widget>[
                        GestureDetector(
                          child: new Card(
                            child: new Image.asset('assets/images/allitems.png',
                              fit: BoxFit.cover,
                              height: 150.0,
                            ),
                            elevation: 0.0,
                          ),
                          onTap: (){
                            Navigator.of(context).pop();
                            Navigator.push(context, new MaterialPageRoute(
                                      builder: (BuildContext context) => new TemplateCategories(categories: "Socks",))
                            );
                          },
                        ),
                        GestureDetector(
                          child: new Card(
                            child: new Image.asset('assets/images/allitems.png',
                              fit: BoxFit.cover,
                              height: 150.0,
                            ),
                            elevation: 0.0,
                          ),
                          onTap: (){
                            Navigator.of(context).pop();
                            Navigator.push(context, new MaterialPageRoute(
                                      builder: (BuildContext context) => new TemplateCategories(categories: "Footwear",))
                            );
                          },
                        ),
                      ],
                    );
  }

  Row _buildOutwearAndInnerwear() {
    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,                          
                      children: <Widget>[
                        GestureDetector(
                          child: new Card(
                            child: new Image.asset('assets/images/allitems.png',
                              fit: BoxFit.cover,
                              height: 150.0,
                            ),
                            elevation: 0.0,
                          ),
                          onTap: (){
                            Navigator.of(context).pop();
                            Navigator.push(context, new MaterialPageRoute(
                                      builder: (BuildContext context) => new TemplateCategories(categories: "Outwear",))
                            );
                          },
                        ),
                        GestureDetector(
                          child: new Card(
                            child: new Image.asset('assets/images/allitems.png',
                              fit: BoxFit.cover,
                              height: 150.0,
                            ),
                            elevation: 0.0,
                          ),
                          onTap: (){
                            Navigator.of(context).pop();
                            Navigator.push(context, new MaterialPageRoute(
                                      builder: (BuildContext context) => new TemplateCategories(categories: "Innerwear",))
                            );
                          },
                        ),
                      ],
                    );
  }

  Row _buildBottomsAndFullBodyWear() {
    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,                          
                      children: <Widget>[
                        GestureDetector(
                          child: new Card(
                            child: new Image.asset('assets/images/allitems.png',
                              fit: BoxFit.cover,
                              height: 150.0,
                            ),
                            elevation: 0.0,
                          ),
                          onTap: (){
                            Navigator.of(context).pop();
                            Navigator.push(context, new MaterialPageRoute(
                                      builder: (BuildContext context) => new TemplateCategories(categories: "Bottoms",))
                            );
                          },
                        ),
                        GestureDetector(
                          child: new Card(
                            child: new Image.asset('assets/images/allitems.png',
                              fit: BoxFit.cover,
                              height: 150.0,
                            ),
                            elevation: 0.0,
                          ),
                          onTap: (){
                            Navigator.of(context).pop();
                            Navigator.push(context, new MaterialPageRoute(
                                      builder: (BuildContext context) => new TemplateCategories(categories: "Full Body Wear",))
                            );
                          },
                        ),
                      ],
                    );
  }

  Row _buildAccessoriesAndTops() {
    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,                          
                      children: <Widget>[
                        GestureDetector(
                          child: new Card(
                            child: new Image.asset('assets/images/allitems.png',
                              fit: BoxFit.cover,
                              height: 150.0,
                            ),
                            elevation: 0.0,
                          ),
                          onTap: (){
                            Navigator.of(context).pop();
                            Navigator.push(context, new MaterialPageRoute(
                                      builder: (BuildContext context) => new TemplateCategories(categories: "Accesories",))
                            );
                          },
                        ),
                        GestureDetector(
                          child: new Card(
                            child: new Image.asset('assets/images/allitems.png',
                              fit: BoxFit.cover,
                              height: 150.0,
                            ),
                            elevation: 0.0,
                          ),
                          onTap: (){
                            Navigator.of(context).pop();
                            Navigator.push(context, new MaterialPageRoute(
                                      builder: (BuildContext context) => new TemplateCategories(categories: "Tops",))
                            );
                          },
                        ),
                      ],
                    );
  }

  GestureDetector _buildAllItems() {
    return GestureDetector(
                    child: new Card(
                      child: new Image.asset('assets/images/allitems.png',
                        fit: BoxFit.cover,
                      ),
                      elevation: 0.0,
                    ),
                    onTap: (){
                      Navigator.of(context).pop();
                      Navigator.push(context, new MaterialPageRoute(
                                builder: (BuildContext context) => new TemplateCategories(categories: "All Items",))
                      );
                    },
                  );
  }
    
  Drawer _buildDrawer(BuildContext context) {
        return new Drawer(
          child:  ListView(
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Hexcolor('#2F4F55')
                ),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Material(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        child: Padding(padding: EdgeInsets.all(8.0),
                        child: Image.network(
                            'https://cdn3.iconfinder.com/data/icons/furniture-175/64/clothes-cabinet-storage-furniture-wardrobe-512.png',
                          width: 70,
                          height: 70,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('Digidrobe', style: TextStyle(
                          color: Colors.white,fontSize: 20.0
                        )),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey.shade400))
                  ),
                  child: new ListTile(
                    title: Text('Journal',
                      style: TextStyle(
                          fontSize: 17.0
                      ),
                    ),
                    onTap: (){
                      Navigator.of(context).pop();
                      Navigator.push(context, new MaterialPageRoute(
                          builder: (BuildContext context) => new JournalPage())
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey.shade400))
                  ),
                  child: new ListTile(
                    title: Text('Sustainable',
                      style: TextStyle(
                          fontSize: 17.0
                      ),
                    ),
                    onTap: (){
                      Navigator.of(context).pop();
                      Navigator.push(context, new MaterialPageRoute(
                          builder: (BuildContext context) => new SustainablePage())
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey.shade400))
                  ),
                  child: new ListTile(
                    title: FlatButton.icon(
                      icon: Icon(Icons.person),
                      label: Text('Logout',
                        style: TextStyle(
                            color: Colors.black
                        ),
                      ),
                      onPressed: () async{
                        await _auth.signOut();
                      },
                    ),
                    onTap: (){
    
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      }
}
