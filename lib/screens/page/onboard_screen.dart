import 'dart:async';

import 'package:bajuku_app/models/slide.dart';
import 'package:bajuku_app/models/user.dart';
import 'package:bajuku_app/screens/home/home.dart';
import 'package:bajuku_app/screens/wrapper.dart';
import 'package:bajuku_app/widget/slide_dots.dart';
import 'package:bajuku_app/widget/slide_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardScreen extends StatefulWidget {
  @override
  _OnboardScreenState createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  int _currentPageView = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    changePage();
  }

  void changePage() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      if (_currentPageView < 2) {
        _currentPageView++;
      } else {
        _currentPageView = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPageView,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return user == null
        ? Scaffold(
            body: SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    PageView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _pageController,
                      onPageChanged: (i) {
                        setState(() {
                          _currentPageView = i;
                        });
                      },
                      itemCount: slideList.length,
                      itemBuilder: (context, i) {
                        return SlideItem(i);
                      },
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              for (int i = 0; i < slideList.length; i++)
                                if (i == _currentPageView)
                                  SlideDots(true)
                                else
                                  SlideDots(false)
                            ],
                          ),
                          SizedBox(height: 30),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Image.asset("assets/images/ButtonLogin.png"),
                            onPressed: () {
                              // Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => Wrapper(
                                    flag: 'Login',
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Not a user yet?',
                            style: TextStyle(
                              color: Color(0xff859289),
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(height: 20),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Image.asset(
                                "assets/images/ButtonCreateAccount.png"),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => Wrapper(
                                    flag: 'Register',
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Home();
  }
}
