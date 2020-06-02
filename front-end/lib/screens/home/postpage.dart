import 'package:flutter/material.dart';
import 'package:rw334/models/post.dart';
import 'package:rw334/models/comment.dart';
import 'package:rw334/service/httpService.dart';
import 'feed.dart';

class PostPage extends StatefulWidget {
  
  final Post post;
  
  PostPage({@required this.post});

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  
  final TextEditingController _commentController = TextEditingController();

  // this is for refresh purposes
  List<Comment> _additionalComments;

  Future<List<Comment>> _commentsFuture;
  @override
  void initState() {
    _additionalComments = [];
    this._commentsFuture = getCommentsOnPost(widget.post.id);
    super.initState();
  }

  void _postCommentSequence () {
    String txt = _commentController.text;
    int pid = widget.post.id;
    if (this._commentController.value.text.trimLeft().trimRight().length > 0) {
      
      // make and push the comment
      makeComment(txt, pid);
      this._commentController.clear();
      FocusScope.of(context).unfocus(); // to remove the keyboard
      setState(() {
        _additionalComments.add(Comment(
          postId: widget.post.id,
          text: _commentController.text,
          epochTime: (DateTime.now().millisecondsSinceEpoch/1000).round(),
        ));
        this._commentsFuture = getCommentsOnPost(widget.post.id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final _inputTextStyle = TextStyle(color: Colors.black, fontSize: 16.0);
    final _inputHintStyle = TextStyle(color: Colors.grey);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset(
          "assets/logo.png",
          width: 120,
        ),
      ),
      body: Container(
        color: Color.fromRGBO(41, 41, 41, 1),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[

                // post card with metadata widget below it
                Container(
                  padding: const EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width,
                  child: PostCard(
                    post: this.widget.post,
                    lineLimit: 100,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                MetadataWidget(
                  post: this.widget.post
                ),
                SizedBox(
                  height: 8,
                ),

                // then all the comments
                FutureBuilder<List<Comment>>(

                  future: this._commentsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done)
                      return Expanded(
                        child: Center(
                          child: Text(
                            'Waiting for comments...',
                            style: TextStyle( fontSize: 20, color: Colors.white ),
                          ),
                        ),
                      );
                    
                    if (snapshot.hasData) {
                      // if (_additionalComments.length > 0) _additionalComments.removeLast();
                      List<Comment> comments = [...snapshot.data, ..._additionalComments];
                      if (comments.length == 0) {
                        return Expanded(
                          child: Center(
                            child: Text(
                              'No comments.',
                              style: TextStyle( fontSize: 20, color: Colors.white ),
                            ),
                          ),
                        );
                      }
                      return Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: comments.length,
                          itemBuilder: (context, index) {
                            // to fix a bug where it displays weird empty comments
                            if (comments[index].text.trimRight().trimLeft().length == 0) return null;
                            return CommentCard(
                              comment: comments[index],
                            );
                          }
                        ),
                      );
                    }

                    return Center(
                      child: Text(
                        '???'
                      )
                    );
                  },
                ),

                // then the input widget for commenting
                Container(
                  width: double.infinity,
                  height: 70.0,
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
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
                            controller: _commentController,
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
                          onPressed: () async {
                            _postCommentSequence();
                          },
                          color: Color.fromRGBO(255, 153, 0, 1.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MetadataWidget extends StatelessWidget {
  
  final Post post;
  MetadataWidget({this.post});

  @override
  Widget build(BuildContext context) {

    TextStyle _styleEmphasis = TextStyle( color: Theme.of(context).accentColor, fontWeight: FontWeight.bold, fontSize: 14 );
    TextStyle _styleNormal = TextStyle( color: Colors.white70, fontSize: 14, );

    return Stack(
      alignment: Alignment.center,
      children: [
        Divider(
          color: Colors.white,
          endIndent: 4,
          indent: 4,
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          color: Color.fromRGBO(41, 41, 41, 1),
          child: RichText(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              // Posted <time> at <location>
              children: [
                TextSpan( text: 'Posted ', style: _styleNormal, ),
                TextSpan( text: '${this.post.getHHMM()}, ${this.post.getDDMMYY()}', style: _styleEmphasis, ),
                TextSpan( text: ' in ', style: _styleNormal ),
                TextSpan( text: '${this.post.locationname}', style: _styleEmphasis ),
              ]
            ),
          ),
        ),
      ]
    );
  }
}



class CommentCard extends StatefulWidget {
  
  final Comment comment;  
  CommentCard({this.comment});

  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  
  Future<String> _commentorName;

  @override
  void initState() { 
    _commentorName = getUsernameFromID(widget.comment.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // text styles
    TextStyle _styleHeaderEmphasis = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    TextStyle _styleHeaderNormal = TextStyle(
      color: Colors.white70,
      fontSize: 14,
    );
    TextStyle _styleBody = TextStyle(
      color: Colors.white,
      fontSize: 18,
    );

    return Container(
      margin: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      width: MediaQuery.of(context).size.width,
      
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(0, 7, 8, 0),
            // color: Colors.red,
            child: Icon(
              Icons.face,
              color: Theme.of(context).accentColor,
              size: 48,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color.fromRGBO(30, 30, 30, 1.0),
                borderRadius: BorderRadius.all(Radius.circular(4)),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0,2),
                    blurRadius: 1,
                    color: Colors.black.withOpacity(0.2),
                  )
                ]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // commenter, time, "said"
                  FutureBuilder(
                    future: this._commentorName,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done)
                        return Text(
                          'Loading...',
                          style: _styleHeaderEmphasis.copyWith(
                            color: Theme.of(context).accentColor,
                          )
                        );
                      if (snapshot.hasData) {
                        return RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: snapshot.data,
                                style: _styleHeaderEmphasis.copyWith(
                                  color: Theme.of(context).accentColor,
                                )
                              ),
                              TextSpan(
                                text: ' at ',
                                style: _styleHeaderNormal
                              ),
                              TextSpan(
                                text: widget.comment.getInPostTimeStamp(),
                                style: _styleHeaderEmphasis.copyWith(
                                  color: Theme.of(context).accentColor,
                                )
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Text(
                          'yeet',
                          style: _styleHeaderEmphasis.copyWith(
                            color: Theme.of(context).accentColor,
                          )
                        );
                      }
                    },
                  ),

                  // spacing
                  SizedBox(
                    height: 4,
                  ),

                  // comment body
                  Text(
                    widget.comment.text,
                    style: _styleBody,
                  )
                ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}