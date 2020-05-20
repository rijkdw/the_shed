import 'package:flutter/material.dart';
import 'package:rw334/service/constants.dart';

class SearchPage extends StatelessWidget {
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
              Icons.near_me,
              color: Colors.grey,
            ),
            onPressed: () {
              Navigator.pushNamed(context, CHAT, arguments: context);
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
          children:[Text("THIS IS THE SEARCH PAGE")],
        ),
      ),
    );
  }
}
