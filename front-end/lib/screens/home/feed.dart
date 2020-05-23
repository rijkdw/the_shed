import 'package:flutter/material.dart';
import 'package:rw334/service/constants.dart';
import 'package:rw334/models/post.dart';
import 'global.dart';
import 'postpage.dart';

class FeedPage extends StatelessWidget {
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
              Icons.near_me,
              color: Colors.grey,
            ),
            onPressed: () {
              Navigator.pushNamed(context, CHAT, arguments: context);
            },
          ),
        ],
      ),
      body: Container(
        color: Color.fromRGBO(41, 41, 41, 1),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          padding: const EdgeInsets.all(4),      
          itemCount: dummyPosts.length,    
          itemBuilder: (context, i) {
            return Container(
              padding: const EdgeInsets.all(4),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => PostPage(dummyPosts[i])));
                },
                child: PostCard(
                  post: dummyPosts[i],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}

class PostCard extends StatefulWidget {
  
  Post post;

  PostCard({Post post}) {
    this.post = post;
  }

  @override
  _PostCardState createState() => _PostCardState(this.post);
}

// state
class _PostCardState extends State<PostCard> {
  
  // variables
  Post post;

  // constructor
  _PostCardState(Post post) {
    this.post = post;
  }

  // class constants
  TextStyle _styleHeaderEmphasis = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );
  TextStyle _styleHeaderNormal = TextStyle(
    color: Colors.white70,
    fontSize: 11,
  );
  TextStyle _styleTitle = TextStyle(
    color: Colors.white,
    fontSize: 16,
  );
  TextStyle _styleFooter = TextStyle(
    color: Colors.white70,
    fontSize: 11,
  );

  // build method
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color.fromRGBO(20, 20, 20, 1.0),
        borderRadius: BorderRadius.all(Radius.circular(4)),
        boxShadow: [
          BoxShadow(
            offset: Offset(2,2),
            blurRadius: 1,
            color: Colors.black.withOpacity(0.3),
          )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // user in group
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: this.post.getUserName(),
                  style: _styleHeaderEmphasis
                ),
                TextSpan(
                  text: ' in ',
                  style: _styleHeaderNormal
                ),
                TextSpan(
                  text: this.post.getGroupName(),
                  style: _styleHeaderEmphasis
                ),
              ],
            ),
          ),
          
          // spacing
          SizedBox(
            height: 4,
          ),

          // title
          Text(
            this.post.text,
            style: _styleTitle,
          ),

          // spacing
          SizedBox(
            height: 6,
          ),

          // categories
          Text(
            this.post.getPrettyCategories(),
            style: _styleFooter,
          )
        ],
      ),
    );
  }
}