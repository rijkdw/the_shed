import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:rw334/service/barIndex.dart';
import 'package:rw334/service/constants.dart';


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
      index: barIndex,
      animationCurve: Curves.fastLinearToSlowEaseIn,
      items: <Widget>[
        Icon(Icons.home, size: 30, color: Colors.black,),
        Icon(Icons.search, size: 30, color: Colors.black),
        Icon(Icons.favorite_border, size: 30, color: Colors.black,),
        Icon(Icons.person, size: 30, color: Colors.black),
      ],
      onTap: (index){
        if (index == 1 && barIndex != 1) {
          barIndex = 1;
          Navigator.pushNamed(context,SEARCH, arguments: context);
        }
        else if (index == 0 && barIndex != 0) {
          barIndex = 0;
          index = 0;
          Navigator.popUntil(context,ModalRoute.withName(HOME));
        }
        else if (index == 2 && barIndex != 2) {
          barIndex = 2;
          Navigator.pushNamed(context, LIKE, arguments: context);
        }
        else if (index == 3 && barIndex != 3) {
          barIndex = 3;
          Navigator.pushNamed(context, POST, arguments: context);
        }
      },
    );
  }
}
