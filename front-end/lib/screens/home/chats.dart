import 'package:flutter/material.dart';

class Chats extends StatelessWidget {
  // class constants

  // fonts
  final _senderUnreadFont = const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);
  final _senderReadFont = const TextStyle(fontSize: 18.0);
  final _messageReadFont = const TextStyle(fontSize: 14.0);
  final _messageUnreadFont = const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold);
  final _messageTimeFont = const TextStyle(fontSize: 14.0);

  // colors
  final _titlebarColor = Color.fromRGBO(10, 10, 10, 1.0);
  final _iconColor = Colors.orange;
  final _unreadChatColor = Colors.orange.withOpacity(0.1);
  final _readChatColor = Color.fromRGBO(0, 0, 0, 0.0);

  // list of dummy chats
  var _chatsArr = [
    {
      'name': 'Rijk',
      'last_message': 'Hello World!',
      'last_message_time': '21:09',
      'unread': 3
    },
    {
      'name': 'Ronaldo',
      'last_message': 'Jissie Flutter is cool',
      'last_message_time': '10:42',
      'unread': 0
    },
    {
      'name': 'Bill Gates',
      'last_message': 'I\'d like to buy your app.',
      'last_message_time': '13:14',
      'unread': 1
    },
    {
      'name': 'Big Data Dave',
      'last_message': 'bitcoin ' * 100,
      'last_message_time': '19:20',
      'unread': 0
    },
    {
      'name': 'Barack Obama',
      'last_message': 'Nice dick bro',
      'last_message_time': '09:24',
      'unread': 0
    },
  ];

  @override
  Widget build(BuildContext context) {
    // before rendering:

    // sort the list of messages by time
    _chatsArr.sort((a, b) => b['last_message_time']
        .toString()
        .compareTo(a['last_message_time'].toString()));

    return Scaffold(
      appBar: AppBar(
        title: Text('Chats Screen'),
        backgroundColor: _titlebarColor,
      ),
      body: _buildChatsList(),
    );
  }

  // build the list of chats
  Widget _buildChatsList() {
    return ListView.builder(
        padding: const EdgeInsets.all(4),
        itemBuilder: (context, i) {
          // removed divided list code
          // if (i.isOdd) return Divider();  // to put dividers inbetween chats
          // final index = i ~/ 2;  // divide by 2, round down

          // replaced with prettier colored box list code
          final index = i;
          if (index < _chatsArr.length)
            return _buildRow(context, _chatsArr[index]);
          else
            return null;
        });
  }

  // build one chat row
  Widget _buildRow(context, messageDict) {

    // the data to be displayed in this row
    String username = messageDict['name'];
    String messageText = messageDict['last_message'];
    String messageTime = messageDict['last_message_time'];
    bool unread = messageDict['unread'] > 0;

    return InkWell(

      // tapping opens the chat
      onTap: () {
        final snackBar =
            SnackBar(content: Text('Chat \"' + username + '\" selected.'));
        Scaffold.of(context).showSnackBar(snackBar);
      },

      // build the chat row
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: unread
              ? _unreadChatColor
              : _readChatColor, // to allow tapping anywhere on the chat name
        ),
        child: Row(
          children: [
            // build profile picture
            Expanded(
              flex: 20,
              child: Container(
                alignment: Alignment(-0.5, 0.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.face,
                        color: _iconColor,
                        size: 30,
                      )
                    ]),
              ),
            ),

            // build name and message
            Expanded(
              flex: 80,
              child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // build name
                      Container(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(username,
                            style: unread
                                ? _senderUnreadFont
                                : _senderReadFont, // if the message is unread, use bold font
                            textAlign: TextAlign.left),
                      ),
                      // build message
                      Text(messageText,
                          overflow: TextOverflow.ellipsis, // fade the text out if it's longer than the row allows
                          maxLines: 1,
                          softWrap: false,
                          style: unread ? _messageUnreadFont : _messageReadFont, // if the message is unread, use bold font
                          textAlign: TextAlign.left)
                    ]),
              ),
            ),

            // build time of message and new message notification
            Expanded(
              flex: 20,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // build message notification
                    Container(
                      padding: const EdgeInsets.only(top: 2),
                      child: Icon(
                        unread ? Icons.notifications : null,
                        color: _iconColor,
                        size: 20,
                      ),
                    ),
                    // build time of message
                    Container(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(messageTime,
                          style: _messageTimeFont,
                          textAlign: TextAlign.left),
                    ),
                  ]
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
