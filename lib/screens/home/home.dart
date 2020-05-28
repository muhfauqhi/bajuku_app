import 'package:bajuku_app/screens/Page/journal.dart';
import 'package:bajuku_app/screens/page/addItem.dart';
import 'package:bajuku_app/screens/page/sustainable.dart';
import 'package:bajuku_app/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
              length: 2,
              child: NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
                  return <Widget>[
                    SliverAppBar(
                      iconTheme: IconThemeData(
                        color: Colors.black,
                      ),
                      backgroundColor: Colors.white,
                      expandedHeight: 100.0,
                      floating: false,
                      pinned: false,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Text('Digidrobe',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            ),
                        ),
                      ),
                    ),
                    new SliverPadding(
                      padding: EdgeInsets.all(16.0),
                      sliver: new SliverList(
                        delegate: new SliverChildListDelegate([
                          TabBar(
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.grey,
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
          body: Container(
            child: new Column(
              children: <Widget>[
                new Expanded(
                  child: _buildGridView(),
                ),
              ],
            ),
          ),
        ),
      ),
      // appBar: AppBar(
      //   iconTheme: IconThemeData(
      //     color: Colors.black,
      //   ),
      //   title:
      //   Text('Digidrobe',
      //     style: TextStyle(
      //       color: Colors.black)),
      //   backgroundColor: Colors.white,
      //   centerTitle: true,
      //   elevation: 0.0,
      //   actions: <Widget>[
      //     FlatButton.icon(
      //       icon: Icon(Icons.person,
      //       color: Colors.black),
      //       label: Text('Logout',
      //       style: TextStyle(
      //         color: Colors.black,
      //         ),
      //       ),
      //       onPressed: () async {
      //         await _auth.signOut();
      //       },
      //     ),
      //   ],
      // ),
      drawer: _buildDrawer(context),
      // body: Container(
      //   child: new Column(
      //     children: <Widget>[
      //       _buildButtonBar(),
      //       new Expanded(
      //         child: _buildGridView()
      //         ),
      //     ],
      //   ),
      // ),
      // floatingActionButton: Container(
      //   height: 80.0,
      //   width: 80.0,
      //   child: FittedBox(
      //     child: FloatingActionButton(onPressed: () {
      //             Navigator.push(context, new MaterialPageRoute(
      //                 builder: (BuildContext context) => new AddItem())
      //             );
      //     },
      //     child: Icon(Icons.add),
      //       backgroundColor: Colors.red,
      //     ),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomNavigationBar(
        // onTap: onTabTap,
        currentIndex: _currentIndex,
        items: [
         BottomNavigationBarItem(
           icon: new Icon(Icons.tab),
           title: new Text(''),
         ),
         BottomNavigationBarItem(
           icon: new Icon(Icons.add_circle_outline),
           title: new Text(''),
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.person),
           title: Text('')
         )
       ],
      ),
    );
    return scaffold;
  }

  // ButtonBar _buildButtonBar() {
  //   return ButtonBar(
  //           children: <Widget>[
  //             FlatButton(child: Text('Wardrobe',),
  //             ),
  //             FlatButton(child: Text('Journal'),
  //             ),
  //           ],
  //           alignment: MainAxisAlignment.center,
  //           mainAxisSize: MainAxisSize.max,
  //         );
  // }

// Gridview Categories
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

// Side Menu
  Drawer _buildDrawer(BuildContext context) {
    return new Drawer(
      child:  ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                    Colors.red,
                  Colors.redAccent
                ]),
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
        ],
      ),
    );
  }
}
