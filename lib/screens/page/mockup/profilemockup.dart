import 'package:bajuku_app/screens/page/mockup/messagemockup.dart';
import 'package:flutter/material.dart';

class ProfileMockup extends StatefulWidget {
  @override
  _ProfileMockupState createState() => _ProfileMockupState();
}

class _ProfileMockupState extends State<ProfileMockup> {
  int _activeTabIndex = 0;

  final List itemSale = [
    {
      'itemName': 'Trench Coat Zara',
      'price': '€5',
      'likes': '65',
      'image': 'sale1.png',
    },
    {
      'itemName': 'HnM Tshirt Yellow',
      'price': '€1',
      'likes': '34',
      'image': 'sale2.png',
    },
    {
      'itemName': 'Adidas Yeezy Grey',
      'price': '€40',
      'likes': '23',
      'image': 'sale3.png',
    },
    {
      'itemName': 'Balenciaga Jacket',
      'price': '€60',
      'likes': '98',
      'image': 'sale4.png',
    },
  ];
  final List itemFree = [
    {
      'itemName': 'Studded boots',
      'price': 'Free',
      'likes': '65',
      'image': 'free1.png',
    },
    {
      'itemName': 'Overflowing dress',
      'price': 'Free',
      'likes': '34',
      'image': 'free2.png',
    },
  ];
  @override
  Widget build(BuildContext context) {
    List<Tab> myTabs = <Tab>[
      Tab(
        text: 'Journal (9)',
      ),
      Tab(
        text: 'Sale (4)',
      ),
      Tab(
        text: 'Free (2)',
      )
    ];

    return Scaffold(
      body: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              _buildAppBar(context),
              SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    TabBar(
                      labelColor: Color(0xff1C3949),
                      unselectedLabelColor: Color(0xffD3D3D3),
                      indicatorColor: Color(0xff859289),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelStyle: TextStyle(
                        letterSpacing: 1.0,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                      tabs: myTabs,
                      onTap: (index) {
                        setState(() {
                          _activeTabIndex = index;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemBuilder: (context, index) {
                    return Image(
                      image: AssetImage('assets/images/Image ${index + 1}.png'),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: GridView.builder(
                  itemCount: itemSale.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      elevation: 2,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image(
                                image: AssetImage(
                                    'assets/images/${itemSale[index]['image']}'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          '${itemSale[index]['itemName']}',
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Color(0xff3F4D55),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '${itemSale[index]['price']}',
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Color(0xff859289),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Icon(Icons.more_vert, color: Colors.grey),
                                  ],
                                ),
                                SizedBox(height: 5.0),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    _buildCircleAvatar(),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.favorite_border,
                                          color: Colors.grey,
                                          size: 20,
                                        ),
                                        Text(
                                          '${itemSale[index]['likes']}',
                                          style: TextStyle(
                                            color: Color(0xff859289),
                                            letterSpacing: 1.0,
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: GridView.builder(
                  itemCount: itemFree.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      elevation: 2,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image(
                                image: AssetImage(
                                    'assets/images/${itemFree[index]['image']}'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          '${itemFree[index]['itemName']}',
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Color(0xff3F4D55),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '${itemFree[index]['price']}',
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Color(0xff859289),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Icon(Icons.more_vert, color: Colors.grey),
                                  ],
                                ),
                                SizedBox(height: 5.0),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    _buildCircleAvatar(),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.favorite_border,
                                          color: Colors.grey,
                                          size: 20,
                                        ),
                                        Text(
                                          '${itemFree[index]['likes']}',
                                          style: TextStyle(
                                            color: Color(0xff859289),
                                            letterSpacing: 1.0,
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCircleAvatar() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xff6EAAB8),
      ),
      padding: EdgeInsets.all(2.0),
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            colors: [
              Color(0xffCEB39E),
              Color(0xffFFDEBF),
            ],
          ),
        ),
        child: Center(
          child: Text(
            'RY',
            style: TextStyle(
              color: Color(0xff3F4D55),
              fontSize: 12.0,
              letterSpacing: 1.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  SliverAppBar _buildAppBar(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Color(0xff3F4D55),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[
        IconButton(
            icon: Icon(
              Icons.more_horiz,
              color: Color(0xff3F4D55),
            ),
            onPressed: () {})
      ],
      backgroundColor: Colors.transparent,
      expandedHeight: 450.0,
      floating: false,
      pinned: false,
      snap: false,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Container(
              height: 400,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/images/sliderimage3.png',
                  ),
                ),
              ),
            ),
            _buildProfilePicture(),
            Container(
              margin: EdgeInsets.only(top: 220),
              alignment: Alignment.topCenter,
              child: Text(
                'Ryan Young',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                  color: Color(0xff3F4D55),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 250),
              alignment: Alignment.topCenter,
              child: Text(
                "Joined since 2019",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1.0,
                  color: Color(0xff000000),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 280),
              alignment: Alignment.topCenter,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff3F4D55), width: 2),
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text('+ Follow'),
                  ),
                  SizedBox(width: 10.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MessageMockup(),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff3F4D55), width: 2),
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text('Message'),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width * 0.9,
                margin: EdgeInsets.only(top: 350, bottom: 10.0),
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '4,1 / 5',
                              style: TextStyle(
                                color: Color(0xff4AA081),
                                fontSize: 20.0,
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  color: Color(0xffE1B359),
                                  size: 20,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Color(0xffE1B359),
                                  size: 20,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Color(0xffE1B359),
                                  size: 20,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Color(0xffE1B359),
                                  size: 20,
                                ),
                                Icon(
                                  Icons.star_half,
                                  color: Color(0xffE1B359),
                                  size: 20,
                                ),
                              ],
                            ),
                            Text(
                              'Trade Rating',
                              style: TextStyle(
                                fontSize: 12.0,
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    VerticalDivider(),
                    Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '1220',
                              style: TextStyle(
                                color: Color(0xff4AA081),
                                fontSize: 20.0,
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Points',
                              style: TextStyle(
                                fontSize: 12.0,
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    VerticalDivider(),
                    Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '109',
                              style: TextStyle(
                                color: Color(0xff4AA081),
                                fontSize: 20.0,
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Followers',
                              style: TextStyle(
                                fontSize: 12.0,
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
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
    );
  }

  Widget _buildProfilePicture() {
    return Container(
      padding: EdgeInsets.all(3.0),
      margin: EdgeInsets.only(top: 100),
      alignment: Alignment.topCenter,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xffE1B359),
        // gradient: LinearGradient(
        //   begin: Alignment.bottomLeft,
        //   colors: [
        //     Color(0xffE1B359),
        //     Color(0xffFFDEBF),
        //   ],
        // ),
      ),
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            colors: [
              Color(0xffCEB39E),
              Color(0xffFFDEBF),
            ],
          ),
        ),
        child: Center(
          child: Text(
            'RY',
            style: TextStyle(
              color: Color(0xff3f4D55),
              fontSize: 40,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
