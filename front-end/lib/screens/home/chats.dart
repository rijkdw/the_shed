import 'package:flutter/material.dart';
import 'package:rw334/screens/home/chatscreen.dart';
import 'global.dart';
import 'package:rw334/models/message.dart';

class ChatsPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    // before rendering, sort the list of messages by time
    dummyMessages.sort((a, b) => b.epochTime.compareTo(a.epochTime));

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
              Icons.more_vert,
              color: Colors.white,
            ),
            onPressed: () {
              print('ChatsPage menu pressed');
            },
          ),
        ],
      ),
      body: ConversationList(dummyMessages),
    );
  }
}

class ConversationList extends StatelessWidget {
  
  final allMessagesList;
  ConversationList(this.allMessagesList);

  Map mapSendersToMessages() {
    Map<int, List<Message>> map = {};
    for (int i = 0; i < allMessagesList.length; i++) {
      Message msg = allMessagesList[i];
      // if the sender id of message i is already listed, add it to that list
      if (!map.keys.contains(msg.senderId)) {
        map[msg.senderId] = [];
      }
      map[msg.senderId].add(msg);
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    
    var senderToMessagesMap = mapSendersToMessages();

    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(41, 41, 41, 1)
      ),
      child: ListView.builder(
        padding: const EdgeInsets.all(4),
        itemBuilder: (context, i) {
          if (i < senderToMessagesMap.keys.length) {
            int key = senderToMessagesMap.keys.toList()[i];
            var messagesList = senderToMessagesMap[key];
            return InkWell(
              // tapping opens the chat
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatScreen(messagesList)));
              },
              // build the chat row
              child: Conversation(messagesList),
            );
          } else {
            return null;
          }
        }),
    );
  }
}

// displays the last message's text, time, and sender
class Conversation extends StatelessWidget {

  List<Message> messagesList;  
  Conversation(this.messagesList);

  // fonts
  final _senderStyle = const TextStyle(fontSize: 18.0, color: Colors.white);
  final _textStyle = const TextStyle(fontSize: 14.0, color: Colors.white);
  final _timeStyle = const TextStyle(fontSize: 14.0, color: Colors.white);

  // colors
  final _chatColor = Colors.white.withOpacity(0.0); // to allow tapping anywhere on the chat name

  @override
  Widget build(BuildContext context) {
    String username = messagesList[0].getSenderName();
    String text = messagesList[0].text;
    String timestamp = messagesList[0].getListTimeStamp();
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: _chatColor, 
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
                    color: Theme.of(context).accentColor,
                    size: 30,
                  )
                ]
              ),
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
                    child: Text(
                      username,
                      style: _senderStyle,
                      textAlign: TextAlign.left),
                  ),
                  // build message
                  Text(
                    text,
                    overflow: TextOverflow.ellipsis, // fade the text out if it's longer than the row allows
                    maxLines: 1,
                    softWrap: false,
                    style: _textStyle, 
                    textAlign: TextAlign.left
                  )
                ]
              ),
            ),
          ),

          // build time of message and new message notification
          Expanded(
            flex: 30,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // build message notification
                  Container(
                    padding: const EdgeInsets.only(top: 2),
                    child: Icon(
                      null, //Icons.notifications : null,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  // build time of message
                  Container(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      timestamp,
                      style: _timeStyle,
                      textAlign: TextAlign.left
                    ),
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