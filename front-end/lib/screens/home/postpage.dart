import 'package:flutter/material.dart';
import 'package:rw334/models/post.dart';
import 'package:rw334/models/comment.dart';
import 'global.dart';
import 'feed.dart';

class PostPage extends StatelessWidget {
  
  final Post post;
  const PostPage(this.post);

  @override
  Widget build(BuildContext context) {

    List<CommentCard> getCommentCards() {
      
      List<CommentCard> returnList = [];
      for (Comment comment in dummyComments) {
        if (comment.postId == this.post.id)
          returnList.add( CommentCard(comment: comment) );
      }
      returnList.sort((a, b) => -b.comment.epochTime.compareTo(a.comment.epochTime));      
      return returnList;
    }

    List<Widget> getColumnChildren() {
      List<Widget> returnList = [
        Container(
          padding: const EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width,
          child: PostCard(
            post: this.post,
            lineLimit: 100,
          ),
        ),
      ];
      returnList.add(SizedBox(height: 6,));
      returnList.addAll(getCommentCards());
      return returnList;    
    }

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
              color: Colors.grey,
            ),
            onPressed: () {
              print('Menu button');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromRGBO(41, 41, 41, 1),
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: getColumnChildren(),
          ),
        ),
      ),
    );
  }
}

class CommentCard extends StatelessWidget {
  
  Comment comment;
  CommentCard({this.comment});

  // text styles
  TextStyle _styleHeaderEmphasis = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );
  TextStyle _styleHeaderNormal = TextStyle(
    color: Colors.white70,
    fontSize: 11,
  );
  TextStyle _styleBody = TextStyle(
    color: Colors.white,
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      width: MediaQuery.of(context).size.width,
      
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            // color: Colors.red,
            child: Icon(
              Icons.face,
              color: Theme.of(context).accentColor,
              size: 32,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(6, 8, 4, 8),
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
                          text: comment.getUsername(),
                          style: _styleHeaderEmphasis.copyWith(
                            color: Theme.of(context).accentColor,
                          )
                        ),
                        TextSpan(
                          text: ' said ',
                          style: _styleHeaderNormal
                        ),
                        TextSpan(
                          text: '@' + comment.getInPostTimeStamp(),
                          style: _styleHeaderEmphasis.copyWith(
                            color: Theme.of(context).accentColor,
                          )
                        ),
                      ],
                    ),
                  ),

                  // spacing
                  SizedBox(
                    height: 2,
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