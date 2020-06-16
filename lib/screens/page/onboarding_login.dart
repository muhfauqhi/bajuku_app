import 'dart:async';
import 'package:bajuku_app/models/slide.dart';
import 'package:bajuku_app/models/user.dart';
import 'package:bajuku_app/screens/home/home.dart';
import 'package:bajuku_app/screens/wrapper.dart';
import 'package:bajuku_app/widget/slide_dots.dart';
import 'package:bajuku_app/widget/slide_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardLogin extends StatefulWidget {
  @override
  _OnboardLoginState createState() => _OnboardLoginState();
}

class _OnboardLoginState extends State<OnboardLogin> {
  // int _currentPage = 0;
  // final PageController _pageController = PageController(initialPage: 0);
  // // Automatic Transition
  // @override
  // void initState() {
  //   super.initState();
  //   Timer.periodic(Duration(seconds: 5), (Timer timer) {
  //     if (_currentPage < 2) {
  //       _currentPage++;
  //     } else {
  //       _currentPage = 0;
  //     }

  //     _pageController.animateToPage(_currentPage,
  //         duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  //   });
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _pageController.dispose();
  // }

  // _onPageChanged(int index) {
  //   setState(() {
  //     _currentPage = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Scaffold(
        body: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    // _pageViewSlider(),
                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: <Widget>[
                    //     Column(
                    //       children: <Widget>[
                    //         Container(
                    //           margin: const EdgeInsets.only(bottom: 35.0),
                    //           child: Container(
                    //             // color: Colors.red,
                    //             height: 330,
                    //             child: Row(
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               crossAxisAlignment: CrossAxisAlignment.end,
                    //               children: <Widget>[
                    //                 for (int i = 0; i < slideList.length; i++)
                    //                   if (i == _currentPage)
                    //                     SlideDots(true)
                    //                   else
                    //                     SlideDots(false)
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ],
                    // ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              child: Image.asset("assets/images/ButtonLogin.png"),
                              textColor: Colors.white,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) => Wrapper(
                                              flag: 'Login',
                                            )));
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: Text(
                              'Not a user yet?',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              child: Image.asset("assets/images/ButtonCreateAccount.png"),
                              // color: Colors.black,
                              textColor: Colors.white,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) => Wrapper(
                                              flag: 'Register',
                                            )));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Home();
    }
  }

  // PageView _pageViewSlider() {
  //   return PageView.builder(
  //     scrollDirection: Axis.horizontal,
  //     controller: _pageController,
  //     onPageChanged: _onPageChanged,
  //     itemCount: slideList.length,
  //     itemBuilder: (ctx, i) => SlideItem(i),
  //   );
  // }
}
