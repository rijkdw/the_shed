import 'package:flutter/material.dart';
import 'package:rw334/models/user.dart';
import 'global.dart' as usr;

class ProfilePage extends StatelessWidget {
  final User user = usr.dummy;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.black,
        title: Text("Welcome " + user.getUsername()),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      body: Container(
        color: Color.fromRGBO(41, 41, 41, 1),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [Text(user.getEmail())],
        ),
      ),
    );
  }
}
