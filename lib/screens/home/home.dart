import 'package:bajuku_app/screens/Page/journal.dart';
import 'package:bajuku_app/screens/page/sustainable.dart';
import 'package:bajuku_app/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:
        Center(
          child: Text('Wardrobe',
            style: TextStyle(
              color: Colors.white)),
        ),
        backgroundColor: Colors.red,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person,
            color: Colors.white),
            label: Text('Logout',
            style: TextStyle(
              color: Colors.white,
              ),
            ),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
      drawer: new Drawer(
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
      ),
      body: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 2,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(6, (index) {
          return Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.network(
                    'https://media.pitchfork.com/photos/5eb5c582a994f4606de325df/1:1/w_600/Petals%20for%20Armor_Hayley%20Williams.jpg'
              ),
            ),
          );
        }),
      ),
      floatingActionButton: Container(
        height: 80.0,
        width: 80.0,
        child: FittedBox(
          child: FloatingActionButton(onPressed: () {
          },
          child: Icon(Icons.add),
            backgroundColor: Colors.red,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
    return scaffold;
  }
}
