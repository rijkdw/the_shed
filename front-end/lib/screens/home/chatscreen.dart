import 'package:flutter/material.dart';

// dummy messages
var _messageMapList = [
  {
    'me': true,
    'text': 'Hey there!',
    'time': '12:00',
    'unread': false
  },
  {
    'me': true,
    'text': 'Isn\'t this app awesome?',
    'time': '12:01',
    'unread': false
  },
  {
    'me': false,
    'text': 'It\'s pretty cool.',
    'time': '12:02',
    'unread': false
  },
  {
    'me': false,
    'text': 'Flutter is awesome.',
    'time': '12:05',
    'unread': true
  },
  {
    'me': false,
    'text': 'This message is rather long for a reason.  '*10,
    'time': '12:05',
    'unread': true
  },
];

class ChatScreen extends StatefulWidget {

  final String recipientName;

  const ChatScreen(this.recipientName);

  @override
  _ChatScreenState createState() => _ChatScreenState();

}

class _ChatScreenState extends State<ChatScreen> {
  
  // colors
  final _titlebarColor = Color.fromRGBO(10, 10, 10, 1.0);
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ), 
        title: Text(widget.recipientName),
        backgroundColor: _titlebarColor,
      ),
      body: ConversationWidget()
    );
  }

}

class ConversationWidget extends StatelessWidget{
  
  final ScrollController controller = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(10.0),
      itemBuilder: (context, index) {
        if (index < _messageMapList.length)
            return MessageWidget(index);
          else
            return null;
      },
      controller: controller,
    );
  }
}

class MessageWidget extends StatelessWidget {
  
  // fonts
  final _messageStyle = const TextStyle(fontSize: 14.0);
  final _messageTimeStyle = const TextStyle(fontSize: 13.0, color: Color.fromRGBO(120, 120, 120, 1.0));  

  // colors
  final _unreadReceivedMessageColor = Colors.orange[100];
  final _readReceivedMessageColor = Colors.green[100];
  final _sentMessageColor = Colors.blue[100];
  
  // index of message
  final int index;

  // constructor
  MessageWidget(this.index);

  @override
  Widget build(BuildContext context) {
    
    // data to be displayed
    var messageMap = _messageMapList[index];
    String text = messageMap['text'];
    String time = messageMap['time'];
    bool unread = messageMap['unread'];
    bool me = messageMap['me'];

    // some logic for choosing colors
    Color messageColor;
    if (me) {
      messageColor = _sentMessageColor;
    } else {
      if (unread) {
        messageColor = _unreadReceivedMessageColor;
      } else {
        messageColor = _readReceivedMessageColor;
      }
    }

    return Container(
      padding: const EdgeInsets.all(6),
      child: Column(
        crossAxisAlignment: me
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
        children: <Widget>[
          // the text
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width*0.7
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              boxShadow: [
                BoxShadow(
                  offset: Offset(1, 1),
                  blurRadius: 4,
                  color: Colors.black.withOpacity(0.3)
                ),
              ],
              color: messageColor
            ),
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
            child: Text(
              text,
              style: _messageStyle,
            ),
          ),
          // the time
          Container(
            padding: const EdgeInsets.only(top: 3, bottom: 4, left: 8, right: 8),
            child: Text(
              time,
              style: _messageTimeStyle,
            ),
          )
        ],
      ),
    );
  }
}