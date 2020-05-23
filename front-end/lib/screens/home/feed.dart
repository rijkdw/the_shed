import 'package:flutter/material.dart';
import 'package:rw334/service/constants.dart';
import 'package:rw334/widgets/post.dart';

var _dummyPosts = [
  {
    'title': 'How to grow better carrots?',
    'categories': ['Gardening', 'Environmental', 'Sustainability'],
    'username': 'Ronaldo',
    'groupname': 'Ronaldo\'s Gardening Empire',
  },
  {
    'title': 'How to ride bicycle?',
    'categories': ['Sports', 'Lifestyle', 'Transportation'],
    'username': 'Rijk',
    'groupname': 'Being a Normal Person 101',
  },
  {
    'title': 'How to overthrow a lawfully elected government?',
    'categories': ['Politics', 'Military tactics', 'Genocide'],
    'username': 'Shmadolf Shmitler',
    'groupname': 'Local Politics Group',
  },
];

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
          itemCount: _dummyPosts.length,    
          itemBuilder: (context, i) {
            return Container(
              padding: const EdgeInsets.all(4),
              child: PostCard(
                title: _dummyPosts[i]['title'],
                categories: _dummyPosts[i]['categories'],
                username: _dummyPosts[i]['username'],
                groupname: _dummyPosts[i]['groupname'],
              ),
            );
          }
        ),
      ),
    );
  }
}
