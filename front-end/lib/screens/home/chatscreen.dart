import 'package:flutter/material.dart';
import 'package:rw334/models/message.dart';
import 'package:rw334/models/user.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {

  final List<Message> messageList;
  const ChatScreen(this.messageList);

  @override
  _ChatScreenState createState() => _ChatScreenState();

}

class _ChatScreenState extends State<ChatScreen> {
    
  List<Message> _messageList;

  @override
  void initState() { 
    super.initState();
    this._messageList = widget.messageList;
  }

  void addMessageToList(Message message) {
    setState(() {
      this._messageList.add(message);
      sortMessages();
    });
  }

  void sortMessages() => this._messageList.sort((a, b) => -b.epochTime.compareTo(a.epochTime));

  @override
  Widget build(BuildContext context) {

    sortMessages();

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
              ConversationWidget(this._messageList),
              InputWidget(addMessageToList)
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

  final Function(Message) addMessageToList;
  InputWidget(this.addMessageToList);

  final TextEditingController controller = new TextEditingController();  

  Message generateMessage(User sender) => Message(
    id: getValidMessageId(),
    text: this.controller.value.text,
    senderId: sender.id,
    receiverId: getOtherPersonId(),
    epochTime: (DateTime.now().millisecondsSinceEpoch/1000).floor()
  );

  // TODO make these actually get the correct values
  int getValidMessageId() => 0;
  int getOtherPersonId() {
    List<int> idsInvolved = [];
    return 1; // for now
  }

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
                borderRadius: BorderRadius.all(Radius.circular(25)),
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
          Consumer<User>(
            builder: (context, user, child) {
              return Container(
                margin: new EdgeInsets.symmetric(horizontal: 8.0),
                child: new IconButton(
                  icon: new Icon(
                    Icons.send
                  ),
                  iconSize: 30,
                  onPressed: () {
                    addMessageToList(generateMessage(user));
                  },
                  color: Theme.of(context).accentColor,
                ),
              );
            },
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