import 'package:flutter/material.dart';
import 'package:rw334/models/message.dart';

class ChatScreen extends StatefulWidget {

  final List<Message> messageList;
  const ChatScreen(this.messageList);

  @override
  _ChatScreenState createState() => _ChatScreenState();

}

class _ChatScreenState extends State<ChatScreen> {
  
  // constants
    
  @override
  Widget build(BuildContext context) {

    widget.messageList.sort((a, b) => -b.epochTime.compareTo(a.epochTime));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.messageList[0].getSenderName()),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
            ),
            onPressed: () {
              print('Menu button');
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              ConversationWidget(widget.messageList),
              InputWidget()
            ],
          )
        ]
      )
    );
  }

}

class ConversationWidget extends StatelessWidget{
  
  final List<Message> messageList;
  ConversationWidget(this.messageList);

  final ScrollController controller = new ScrollController();

  @override
  Widget build(BuildContext context) {
    
    return Flexible(
      child: Container(
        color: Color.fromRGBO(41, 41, 41, 1),
        child: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemBuilder: (context, index) {
            if (index < this.messageList.length)
                return MessageWidget(messageList[index]);
              else
                return null;
          },
          controller: controller,
        ),
      )
    );
  }
}

class InputWidget extends StatelessWidget {

  final TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    final _inputTextStyle = TextStyle(color: Colors.black, fontSize: 16.0);
    final _inputHintStyle = TextStyle(color: Colors.grey);

    return Container(
      width: double.infinity,
      height: 70.0,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey,
            width: 0.5
          )
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -3),
            blurRadius: 1,
            color: Colors.black.withOpacity(0.2),
          )
        ]
      ),
      child: Row(
        children: <Widget>[

          // emoji button
          new Container(
            margin: new EdgeInsets.symmetric(horizontal: 1.0),
            child: new IconButton(
              onPressed: () => print('Emoji pls'),
              icon: new Icon(
                Icons.face
              ),
              iconSize: 30,
              color: Theme.of(context).accentColor,
            ),
          ),

          // text input
          Flexible(
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 2, 2, 2),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: TextField(
                style: _inputTextStyle,
                controller: controller,
                // expands: true,
                minLines: 1,
                maxLines: 5,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type a message...',
                  hintStyle: _inputHintStyle,
                ),
              ),
            ),
          ),

          // send message button
          new Container(
            margin: new EdgeInsets.symmetric(horizontal: 8.0),
            child: new IconButton(
              icon: new Icon(
                Icons.send
              ),
              iconSize: 30,
              onPressed: () {
                print('Send message');
              },
              color: Theme.of(context).accentColor,
            ),
          ),

        ],
      ),
    );
  }
}


class MessageWidget extends StatelessWidget {

  final Message message;
  MessageWidget(this.message);

  @override
  Widget build(BuildContext context) {

    final _messageStyle = const TextStyle(fontSize: 16.0);
    final _messageTimeStyle = const TextStyle(fontSize: 14.0, color: Color.fromRGBO(120, 120, 120, 1.0)); 
    
    // data to be displayed
    String text = this.message.text;
    String time = this.message.getInChatTimeStamp();
    bool me = false;

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
              color: me
              ? Colors.white
              : Theme.of(context).accentColor
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