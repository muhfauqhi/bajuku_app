import 'package:bajuku_app/screens/page/menu_burger/menuBurger.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MenuBurgerScaffold extends StatelessWidget {
  // final Widget body;

  // const MenuBurgerScaffold({Key key, this.body}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuBurger(),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.transparent,
              expandedHeight: 300.0,
              floating: false,
              pinned: false,
              snap: false,
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/sliderimage3.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 45),
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Profile',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.0,
                          color: Hexcolor('#3F4D55'),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 53,
                        backgroundColor: Hexcolor('#C4C4C4'),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Hexcolor('#37585A'),
                          child: Text(
                            'TT',
                            style: TextStyle(
                              color: Hexcolor('#C4C4C4'),
                              fontSize: 40,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 150),
                      alignment: Alignment.center,
                      child: Text(
                        'Test Toang',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                          color: Hexcolor('#3F4D55'),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 200),
                      alignment: Alignment.center,
                      child: Text(
                        'Joined since 2019',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 1.0,
                          color: Hexcolor('#000000'),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30.0),
                      child: IconButton(
                        icon: Image.asset(
                          'assets/images/burger_menu.png',
                          height: 35.0,
                          width: 35.0,
                        ),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                    ),
                    // Positioned.fill(
                    //   left: 50,
                    //   right: 50,
                    //   child: Container(
                    //     margin: EdgeInsets.only(top: 150),
                    //     decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(12),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                collapseMode: CollapseMode.pin,
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  Container(
                    child: Column(
                      children: [],
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        body: Text(''),
      ),
    );
  }
}
