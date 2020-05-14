import 'package:flutter/material.dart';
import 'package:rw334/screens/home/chats.dart';
import 'package:rw334/screens/home/home.dart';
import 'package:rw334/screens/home/liked.dart';
import 'package:rw334/screens/home/post.dart';
import 'package:rw334/screens/home/search.dart';
import 'constants.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  BuildContext context = settings.arguments;
  Navigator.popUntil(context,ModalRoute.withName(HOME));
  switch (settings.name) {
    case HOME:
      return MaterialPageRoute(builder: (context) => UserHomePage());
    case LIKE:
      return MaterialPageRoute(builder: (context) => UserLiked());
    case SEARCH:
      return MaterialPageRoute(builder: (context) => Search());
    case POST:
      return MaterialPageRoute(builder: (context) => UserPosts());
    case CHAT:
      return MaterialPageRoute(builder: (context)=> Chats());
  }
}