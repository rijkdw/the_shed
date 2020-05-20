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
    'text': 'What the f*ck did you just f*cking say about me, you little bitch? I\'ll have you know I graduated top of my class in the Navy Seals, and I\'ve been involved in numerous secret raids on Al-Quaeda, and I have over 300 confirmed kills. I am trained in gorilla warfare and I\'m the top sniper in the entire US armed forces. You are nothing to me but just another target. I will wipe you the f*ck out with precision the likes of which has never been seen before on this Earth, mark my f*cking words. You think you can get away with saying that shit to me over the Internet? Think again, f*cker. As we speak I am contacting my secret network of spies across the USA and your IP is being traced right now so you better prepare for the storm, maggot. The storm that wipes out the pathetic little thing you call your life. You\'re f*cking dead, kid. I can be anywhere, anytime, and I can kill you in over seven hundred ways, and that\'s just with my bare hands. Not only am I extensively trained in unarmed combat, but I have access to the entire arsenal of the United States Marine Corps and I will use it to its full extent to wipe your miserable ass off the face of the continent, you little shit. If only you could have known what unholy retribution your little "clever" comment was about to bring down upon you, maybe you would have held your f*cking tongue. But you couldn\'t, you didn\'t, and now you\'re paying the price, you goddamn idiot. I will shit fury all over you and you will drown in it. You\'re f*cking dead, kiddo.',
    'time': '12:05',
    'unread': true
  },
  {
    'me': false,
    'text': 'Subscribe to PewDiePie.',
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
  
  // constants
  
  // colors
  final _titlebarColor = Color.fromRGBO(10, 10, 10, 1.0);
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () => Navigator.of(context).pop(),
        // ), 
        title: Text(widget.recipientName),
        backgroundColor: _titlebarColor,
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              ConversationWidget(),
              InputWidget()
            ],
          )
        ]
      )
    );
  }

}

class ConversationWidget extends StatelessWidget{
  
  final ScrollController controller = new ScrollController();

  @override
  Widget build(BuildContext context) {
    
    return Flexible(
      child: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemBuilder: (context, index) {
          if (index < _messageMapList.length)
              return MessageWidget(index);
            else
              return null;
        },
        controller: controller,
      )
    );
  }
}

class InputWidget extends StatelessWidget {

  // constants

  // colors
  final _iconColor = Colors.deepOrange;

  // styles
  final _inputTextStyle = TextStyle(color: Colors.black, fontSize: 15.0);
  final _inputHintStyle = TextStyle(color: Colors.grey);

  final TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey,
            width: 0.5
          )
        ),
        color: Colors.white
      ),
      child: Row(
        children: <Widget>[
          Material(
            color: Colors.white,
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 1.0),
              child: new IconButton(
                onPressed: () => print('Emoji pls'),
                icon: new Icon(Icons.face),
                color: _iconColor,
              ),
            ),
          ),

          // Text input
          Flexible(
            child: Container(
              child: TextField(
                style: _inputTextStyle,
                controller: controller,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type a message...',
                  hintStyle: _inputHintStyle,
                ),
              ),
            ),
          ),

          // Send Message Button
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 8.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () => {},
                color: _iconColor,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}


class MessageWidget extends StatelessWidget {
  
  // fonts
  final _messageStyle = const TextStyle(fontSize: 14.0);
  final _messageTimeStyle = const TextStyle(fontSize: 13.0, color: Color.fromRGBO(120, 120, 120, 1.0));  

  // colors
  static final int intensity = 200;
  final _unreadReceivedMessageColor = Colors.deepOrange[intensity];
  final _readReceivedMessageColor = Colors.green[intensity];
  final _sentMessageColor = Colors.blue[intensity];
  
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
      padding: const EdgeInsets.all(4),
      child: Column(
        crossAxisAlignment: me
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
        children: <Widget>[
          
          // the message text
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
          
          // the message time
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