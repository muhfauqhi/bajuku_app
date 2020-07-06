import 'package:bajuku_app/screens/page/menu_burger/menuBurger.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MenuBurgerScaffold extends StatelessWidget {
  // final Widget body;

  // const MenuBurgerScaffold({Key key, this.body}) : super(key: key);
  final String title;
  final Widget leftBox;
  final Widget rightBox;
  final String profileName;
  final String profilePict;
  final String profileCreated;
  final Widget contentSliver;
  final Widget body;

  MenuBurgerScaffold(
      {this.title,
      this.body,
      this.leftBox,
      this.rightBox,
      this.contentSliver,
      this.profileCreated,
      this.profileName,
      this.profilePict});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuBurger(),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.transparent,
              expandedHeight: 400.0,
              floating: false,
              pinned: false,
              snap: false,
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Container(
                      height: 350,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            'assets/images/sliderimage3.png',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 45),
                      alignment: Alignment.topCenter,
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.0,
                          color: Hexcolor('#3F4D55'),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 100),
                      alignment: Alignment.topCenter,
                      child: CircleAvatar(
                        radius: 53,
                        backgroundColor: Hexcolor('#C4C4C4'),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Hexcolor('#37585A'),
                          child: Text(
                            profilePict,
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
                      margin: EdgeInsets.only(top: 220),
                      alignment: Alignment.topCenter,
                      child: Text(
                        profileName,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                          color: Hexcolor('#3F4D55'),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 250),
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Joined since " + profileCreated,
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
                    Center(
                      child: Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width * 0.9,
                        margin: EdgeInsets.only(top: 300, bottom: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          shape: BoxShape.rectangle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0),
                              blurRadius: 3.0,
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 150,
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Center(
                                child: leftBox,
                              ),
                            ),
                            VerticalDivider(),
                            Container(
                              height: 150,
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Center(
                                child: rightBox,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                collapseMode: CollapseMode.pin,
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[contentSliver],
              ),
            ),
          ];
        },
        body: body,
      ),
    );
  }
}
