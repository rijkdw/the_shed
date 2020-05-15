import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BarB extends StatefulWidget {
  @override
  _BarBState createState() => _BarBState();
}

class _BarBState extends State<BarB> {

  int _barIndex = 0;
  PageController pageController;
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Color.fromRGBO(41, 41, 41, 1),
      color: Colors.white,//Color.fromRGBO(128, 128, 128, 1),
      height: 60,
      animationDuration: Duration(milliseconds: 1000),
      index: _barIndex,
      animationCurve: Curves.fastLinearToSlowEaseIn,
      items: <Widget>[
        Icon(Icons.home, size: 30, color: Colors.black,),
        Icon(Icons.search, size: 30, color: Colors.black),
        Icon(Icons.favorite_border, size: 30, color: Colors.black,),
        Icon(Icons.person, size: 30, color: Colors.black),
      ],
    );
  }
  void navigationTapped (int page) {
    pageController.jumpToPage(page);
  }
}
