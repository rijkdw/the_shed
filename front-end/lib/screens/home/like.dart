import 'package:flutter/material.dart';
import 'dart:math';

class LikePage extends StatefulWidget {
  
  @override
  _LikePageState createState() => _LikePageState();
}

class _LikePageState extends State<LikePage> {

  Color iconColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset(
          "assets/logo.png",
          width: 120,
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            iconSize: 30,
            onPressed: () {
              print('LikePage refresh pressed');
            },
          ),
        ],
      ),
      body: Container(
        color: Color.fromRGBO(41, 41, 41, 1),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,

        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height/35,
            ),
            IconButton(
              iconSize: 100,
              splashColor: Colors.white,
              splashRadius: 10,
              icon: Icon(
                Icons.thumb_up,
                color: iconColor,
              ),
              onPressed: () {
                var colors = [Colors.red, Colors.blue, Colors.green, Colors.yellow];
                setState(() {
                  final random = new Random();
                  Color newColor;
                  do {
                    newColor = colors[random.nextInt(colors.length)];
                  } while (newColor == iconColor);
                  iconColor = newColor;
                });
              },
            ),
            Text(
              'This is size 24',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'This is size 20',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'This is size 18',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'This is size 16',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'This is size 14',
              style: TextStyle(fontSize: 14),
            ),
            Text(
              'This is size 12',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
