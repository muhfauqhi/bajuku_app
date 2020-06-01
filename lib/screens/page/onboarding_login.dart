import 'package:bajuku_app/models/slide.dart';
import 'package:bajuku_app/screens/authenticate/authenticate.dart';
import 'package:bajuku_app/screens/authenticate/register.dart';
import 'package:bajuku_app/screens/authenticate/sign_in.dart';
import 'package:bajuku_app/screens/wrapper.dart';
import 'package:bajuku_app/widget/slide_item.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:bajuku_app/widget/slide_dots.dart';

class OnboardLogin extends StatefulWidget{
  @override
  _OnboardLoginState createState() => _OnboardLoginState();
}

class _OnboardLoginState extends State<OnboardLogin> {
  int _currentPage = 0;
  final PageController _pageController = PageController(
    initialPage: 0
  );
//Automatic Transition
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer){
      if(_currentPage < 2){
        _currentPage++;
      }else{
        _currentPage = 0;
      }

      _pageController.animateToPage(_currentPage,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index){
    setState(() {
      _currentPage = index;
    });
  }

  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
     body : Container(
       color: Colors.white,
       child : Column(
         children: <Widget>[
            Expanded(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  _pageViewSlider(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(bottom: 35.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                               children: <Widget>[
                              for(int i = 0; i<slideList.length; i++)
                                if( i == _currentPage )
                                  SlideDots(true)
                                else
                                  SlideDots(false)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      FlatButton(
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)
                    ),
                  child: Text('Login',
                       style: TextStyle(fontSize: 18.0),
                  ),
                  color : Colors.black,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.push(context, new MaterialPageRoute(
                      builder: (BuildContext context) => Wrapper())
                  );
                  },
                ),
                Text('Not a user yet?',textAlign: TextAlign.center,),
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                    ),
                  child: Text('Create an Account',
                       style: TextStyle(fontSize: 18.0),
                  ),
                  color : Colors.black,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.push(context, new MaterialPageRoute(
                      builder: (BuildContext context) => Wrapper())
                  );
                  },
                ),
                    ],
                  ),
                ],
              ),
            ),
          ],
         ),
      ),
    );
  }

  PageView _pageViewSlider() {
    return PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: slideList.length,
                  itemBuilder: (ctx, i) => SlideItem(i),
                  );
  }
}

