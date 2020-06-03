import 'package:flutter/material.dart';

class GroupsPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset(
          "assets/logo.png",
          width: 120,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // mini: true,
        child: Icon(
          Icons.add,
          size: 30,
        ),
        onPressed: () => print('Open the group creator'),
      ),
      body: Container(
        color: Color.fromRGBO(41, 41, 41, 1.0),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Text(
              'Group'
            );
          }
        ),
      ),
    );
  }
}

class GroupCard extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}