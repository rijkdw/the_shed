import 'package:flutter/material.dart';
import 'package:rw334/models/post.dart';
import 'package:rw334/service/constants.dart';
import 'feed.dart';

class PostPage extends StatelessWidget {
  
  final Post post;
  const PostPage(this.post);

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
      body: Container(
        color: Color.fromRGBO(41, 41, 41, 1),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: PostCard(
              post: this.post
            ),
          ),
        ),
      ),
    );
  }
}