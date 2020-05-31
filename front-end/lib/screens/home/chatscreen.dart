import 'package:flutter/material.dart';
import 'package:rw334/models/message.dart';
import 'package:rw334/models/user.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {

  final List<Message> messagesList;
  final int otherUserID;
  const ChatScreen({@required this.messagesList, @required this.otherUserID});

  @override
  _ChatScreenState createState() => _ChatScreenState();

}

class _ChatScreenState extends State<ChatScreen> {
    
  List<Message> _messageList;
  int _otherUserID;
  final TextEditingController _inputController = new TextEditingController();
  final ScrollController _scrollController = new ScrollController();

  @override
  void initState() { 
    super.initState();
    this._messageList = widget.messagesList;
    this._otherUserID = widget.otherUserID;
  } 

  void sortMessages() => this._messageList.sort((a, b) => -b.epochTime.compareTo(a.epochTime));

  @override
  Widget build(BuildContext context) {

    int currentUserID = Provider.of<User>(context).id;

    int getOtherPersonId() {
      List<int> idsInvolved = [_messageList[0].senderId, _messageList[0].receiverId];
      idsInvolved.remove(currentUserID);
      return idsInvolved[0];
    }

    Message _generateMessage() => Message(
      text: this._inputController.value.text,
      senderId: currentUserID,
      receiverId: getOtherPersonId(),
      epochTime: (DateTime.now().millisecondsSinceEpoch/1000).floor()
    );

    void _pushMessageToFirestore(Message message) {
      Firestore.instance.collection('messages').add(message.toMap());
    }

    void _sendMessageSequence() {
      if (this._inputController.value.text.trimLeft().trimRight().length > 0) {
        _pushMessageToFirestore(_generateMessage());
        this._inputController.clear();
        this._scrollController.jumpTo(this._scrollController.position.maxScrollExtent);
      }      
    }

    final _inputTextStyle = TextStyle(color: Colors.black, fontSize: 16.0);
    final _inputHintStyle = TextStyle(color: Colors.grey);

    return Scaffold(
      appBar: AppBar(
        title: Text(this._messageList[0].senderName),
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

              StreamBuilder(
                stream: Firestore.instance.collection('messages').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(41, 41, 41, 1)
                      ),
                      child: Center(
                        child: Text('Loading...'),
                      ),
                    );
                  }
                  List<Message> messagesInThisChat = [];
                  List<int> validIDs = [this._otherUserID, currentUserID];
                  for (int i = 0; i < snapshot.data.documents.length; i++) {
                    Message msg = Message.fromDocumentSnapshot(snapshot.data.documents[i]);
                    if (validIDs.contains(msg.senderId) && validIDs.contains(msg.receiverId)) {
                      messagesInThisChat.add(msg);
                    }
                  }
                  messagesInThisChat.sort((a, b) => -b.epochTime.compareTo(a.epochTime));
                  return Flexible(
                    child: Container(
                      color: Color.fromRGBO(41, 41, 41, 1),
                      child: ListView.builder(
                        padding: EdgeInsets.all(10.0),
                        itemCount: messagesInThisChat.length,
                        controller: this._scrollController,
                        itemBuilder: (context, index) {
                          return MessageWidget(messagesInThisChat[index]);
                        },
                      ),
                    )
                  );
                }
              ),

              // input widget
              Container(
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
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        child: TextField(
                          style: _inputTextStyle,
                          controller: this._inputController,
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
                    Container(
                      margin: new EdgeInsets.symmetric(horizontal: 8.0),
                      child: new IconButton(
                        icon: new Icon(
                          Icons.send
                        ),
                        iconSize: 30,
                        onPressed: () {
                          _sendMessageSequence();
                        },
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ]
      )
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

    return Consumer<User>(
      builder: (context, user, child) {
        return Container(
          padding: const EdgeInsets.all(4),
          child: Column(
            crossAxisAlignment: user.id == message.senderId
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
                  color: user.id == message.senderId
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
      },
    );    
  }
}