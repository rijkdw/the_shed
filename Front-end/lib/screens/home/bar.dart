import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:rw334/screens/home/body.dart';
import 'home.dart';

class BarB extends StatefulWidget {
  @override
  _BarBState createState() => _BarBState();
}

class _BarBState extends State<BarB> {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Color.fromRGBO(41, 41, 41, 1),
      color: Colors.white,//Color.fromRGBO(128, 128, 128, 1),
      height: 60,
      animationDuration: Duration(milliseconds: 1000),
      index: 0,
      animationCurve: Curves.fastLinearToSlowEaseIn,
      items: <Widget>[
        Icon(Icons.home, size: 30, color: Colors.black,),
        Icon(Icons.search, size: 30, color: Colors.black),
        Icon(Icons.favorite_border, size: 30, color: Colors.black,),
        Icon(Icons.person, size: 30, color: Colors.black),
      ],
      onTap: (index){
        if (index == 1) {
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => Search()),
          );
        }
        else if (index == 0) {
          Navigator.pop(context,
            MaterialPageRoute(builder: (context) => UserHomePage()),
          );
        }
        else if (index == 2) {
          Navigator.pop(context,
            MaterialPageRoute(builder: (context) => UserLiked()),
          );
        }
        else if (index == 3) {
          Navigator.pop(context,
            MaterialPageRoute(builder: (context) => UserPost()),
          );
        }
      },
    );
  }
}
