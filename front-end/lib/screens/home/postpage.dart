import 'package:flutter/material.dart';
import 'package:rw334/models/post.dart';
import 'package:rw334/models/comment.dart';
import 'global.dart';
import 'feed.dart';

class PostPage extends StatelessWidget {
  
  final Post post;
  const PostPage(this.post);

  List<CommentCard> getCommentCards() {
    List<CommentCard> returnList = [];
    for (Comment comment in dummyComments) {
      if (comment.postId == this.post.id)
        returnList.add( CommentCard(comment: comment) );
    }
    return returnList;
  }

  List<Widget> getColumnChildren() {
    List<Widget> returnList = [
      Container(
        padding: const EdgeInsets.all(8),
        child: PostCard(
          post: this.post,
          lineLimit: 100,
        ),
      ),
    ];
    returnList.addAll(getCommentCards());
    return returnList;    
  }

  @override
  Widget build(BuildContext context) {

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
          width: MediaQuery.of(context).size.width,
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        comment.text,
      ),
    );
  }
}