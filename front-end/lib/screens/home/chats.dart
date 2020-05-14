import 'package:flutter/material.dart';

class Chats extends StatelessWidget {
  
  final _senderFont = const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);
  final _messageReadFont = const TextStyle(fontSize: 14.0);
  final _messageUnreadFont = const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold);
  final _messageTimeFont = const TextStyle(fontSize: 14.0);

  var _messagesArr = [
    { 'name': 'Rijk', 'last_message': 'Hello World!', 'last_message_time': '21:09', 'unread': true },
    { 'name': 'Ronaldo', 'last_message': 'Flutter is cool!', 'last_message_time': '10:42', 'unread': false },
    { 'name': 'Bill Gates', 'last_message': 'Nice app!', 'last_message_time': '13:14', 'unread': true }
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats Screen"),
        backgroundColor: Color.fromRGBO(10, 10, 10, 1.0),
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
        if (index < _messagesArr.length) return _buildRow(_messagesArr[index]);
        else return null;
      }
    );
  }

  Widget _buildRow(messageDict) {
    
    String _username = messageDict['name'];
    String _message_text = messageDict['last_message'];
    String _message_time = messageDict['last_message_time'];
    bool _unread = messageDict['unread'];

    return Container(
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [

          // profile picture
          Expanded(
            flex: 15,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.face,
                    color: Colors.orange,
                    size: 35,
                  )
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
                  Container(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      _username,
                      style: _senderFont,
                      textAlign: TextAlign.left
                    ),
                  ),
                  Text(
                    _message_text,
                    style: _unread? _messageUnreadFont : _messageReadFont,
                    textAlign: TextAlign.left
                  ),
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
                  Container(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      _message_time,
                      style: _messageTimeFont,
                      textAlign: TextAlign.left
                    ),
                  ),
                  Icon(
                    _unread? Icons.sms : null,
                    color: Colors.orange,
                    size: 20,
                  ),
                ]
              ),
            ),
          ),

        ],
      ),
    );
  }

}
