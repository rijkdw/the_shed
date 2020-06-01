import 'package:flutter/material.dart';
import 'package:rw334/models/post.dart';
import 'package:rw334/models/comment.dart';
import 'package:rw334/service/httpService.dart';
import 'feed.dart';

class PostPage extends StatelessWidget {
  
  final Post post;
  Future<List<Comment>> _commentsFuture;
  PostPage({@required this.post}) {
    this._commentsFuture = getCommentsOnPost(post.id);
  }

  final TextEditingController _commentController = TextEditingController();

  void _postCommentSequence () {
    String txt = _commentController.text;
    int pid = post.id;
    if (this._commentController.value.text.trimLeft().trimRight().length > 0) {
      // make and push the comment

      makeComment(txt, pid);
      this._commentController.clear();
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
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            iconSize: 30,
            onPressed: () {
              print('PostPage refresh button');
            },
          ),
        ],
      ),
      body: Container(
        color: Color.fromRGBO(41, 41, 41, 1),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[

            // post card with metadata widget below it
            Container(
              padding: const EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width,
              child: PostCard(
                post: this.post,
                lineLimit: 100,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            MetadataWidget(
              post: this.post
            ),
            SizedBox(
              height: 8,
            ),

            // then all the comments
            FutureBuilder<List<Comment>>(

              future: _commentsFuture,
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
                  List<Comment> comments = snapshot.data;
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
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      return CommentCard(
                        comment: comments[index],
                      );
                    }
                  );
                }

                return Text('???');
              },
            ),

            // then the input widget for commenting
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
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
              ),
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



class CommentCard extends StatelessWidget {
  
  Comment comment;
  CommentCard({this.comment});

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
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: comment.username,
                          style: _styleHeaderEmphasis.copyWith(
                            color: Theme.of(context).accentColor,
                          )
                        ),
                        TextSpan(
                          text: ' at ',
                          style: _styleHeaderNormal
                        ),
                        TextSpan(
                          text: comment.getInPostTimeStamp(),
                          style: _styleHeaderEmphasis.copyWith(
                            color: Theme.of(context).accentColor,
                          )
                        ),
                      ],
                    ),
                  ),

                  // spacing
                  SizedBox(
                    height: 4,
                  ),

                  // comment body
                  Text(
                    comment.text,
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