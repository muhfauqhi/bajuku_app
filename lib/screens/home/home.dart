import 'package:bajuku_app/screens/Page/journal.dart';
import 'package:bajuku_app/screens/page/addItem.dart';
import 'package:bajuku_app/screens/page/sustainable.dart';
import 'package:bajuku_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hexcolor/hexcolor.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
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
                Container(
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

                            }),
                          ],
                      ),
                      new Expanded(
                        child: new Image.network('https://assets.adidas.com/images/h_2000,f_auto,q_auto:sensitive,fl_lossy/8e72879ec848410db0c6ab2201261318_9366/MYSHELTER_RAIN.RDY_Parka_Black_FI9292_21_model.jpg',
                            height: 300,
                            width: 300,
                            ),
                      ),
                      new Expanded(
                        child: _buildGridView(),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: new Column(
                    children: <Widget>[
                      new Text('Journal'),
                    ],
                  ),
                ),
              ],
          ),
        ),
      ),
      drawer: _buildDrawer(context),
    );
  }

  GridView _buildGridView() {
    return GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 2,
        // Generate 100 widgets that display their index in the List.
        children: List.generate(8, (index) {
        return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Image.network(
                  'https://media.pitchfork.com/photos/5eb5c582a994f4606de325df/1:1/w_600/Petals%20for%20Armor_Hayley%20Williams.jpg'
            ),
          ),
        );
      }),
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
