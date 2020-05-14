import 'package:flutter/material.dart';

class Chats extends StatelessWidget {
  
  final _biggerFont = const TextStyle(fontSize: 18.0);

  var _users = [
    { 'name': 'Rijk', 'last_message': 'Hello World!', 'last_message_time': '21:09', 'message': true },
    { 'name': 'Ronaldo', 'last_message': 'Flutter is cool!', 'last_message_time': '10:42', 'message': false },
    { 'name': 'Bill Gates', 'last_message': 'Nice app!', 'last_message_time': '13:14', 'message': true }
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats Screen"),
      ),
      body: _buildChatsList(),
    );
  }

  Widget _buildChatsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();

        final index = i ~/ 2;
        if (index < _users.length) return _buildRow(_users[index]);
      }
    );
  }

  Widget _buildRow(userDict) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [

          // profile picture
          Expanded(
            flex: 13,
            child: Container(
              // padding: const EdgeInsets.only(right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.face, color: Colors.orange)
                ]
              ),
            ),
          ),

          // name and message
          Expanded(
            flex: 80,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userDict['name'], style: _biggerFont, textAlign: TextAlign.left),
                  Text(userDict['last_message'], textAlign: TextAlign.left),
                ]
              ),
            ),
          ),

          // time of message and new message notification
          Expanded(
            flex: 20,
            child: Container(
              alignment: Alignment(1.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(userDict['last_message_time'], style: _biggerFont, textAlign: TextAlign.left),
                  Icon(userDict['message']? Icons.favorite: Icons.favorite_border),
                ]
              ),
            ),
          ),

        ],
      ),
    );
  }

}
