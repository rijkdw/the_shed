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
              Icons.refresh,
              color: Colors.white,
            ),
            iconSize: 30,
            onPressed: () {
              print('ChatsPage refresh pressed');
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
          // } else if (i == senderToMessagesMap.keys.length) {
          //   return Container(
          //     color: Colors.white70,
          //     margin: const EdgeInsets.only(top: 8),
          //     child: Text(
          //       '- End of list -',
          //       style: const TextStyle(
          //         fontSize: 16,
          //         color: Colors.grey,
          //       ),
          //       textAlign: TextAlign.center,
          //     ),
          //   );
          } else {
            return null;
          }
        }
      ),
    );
  }
}

// displays the last message's text, time, and sender
class Conversation extends StatelessWidget {

  List<Message> messagesList;  
  Conversation(this.messagesList);  

  @override
  Widget build(BuildContext context) {

    final debug = false;

    final _chatColor = Colors.white.withOpacity(0.0); // to allow tapping anywhere on the chat name

    final _senderStyle = TextStyle(fontSize: 16.0, color: Theme.of(context).accentColor);
    final _textStyle = const TextStyle(fontSize: 14.0, color: Colors.white);
    final _timeStyle = TextStyle(fontSize: 14.0, color: Theme.of(context).accentColor);

    return Container(
      margin: const EdgeInsets.only(bottom: 4, top: 4),
      padding: const EdgeInsets.all(4),
      color: debug ? Colors.black : _chatColor,
      child: Row(
        children: [
          
          // avatar
          Container(
            margin:  const EdgeInsets.only(right: 8),
            color: debug ? Colors.blue : _chatColor,
            child: Icon(
              Icons.face,
              color: Theme.of(context).accentColor,
              size: 40,
            ),
          ),

          // username  --->  time
          // text
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      flex: 70,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        color: debug ? Colors.white : _chatColor,
                        child: Text(
                          messagesList[0].getSenderName(),
                          style: _senderStyle,
                        )
                      ),
                    ),
                    Flexible(
                      flex: 30,
                      child: Container(
                        alignment: Alignment.centerRight,
                        color: debug ? Colors.red : _chatColor,
                        child: Text(
                          messagesList[0].getListTimeStamp(),
                          style: _timeStyle,
                        ),
                      )
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 3),
                  alignment: Alignment.centerLeft,
                  color: debug ? Colors.purple : _chatColor,
                  child: Text(
                    messagesList[0].text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: _textStyle,
                  ),
                ),
              ],
            )
          )
        ],
      ),
    );
  }
}