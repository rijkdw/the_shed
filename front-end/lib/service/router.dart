import 'package:flutter/material.dart';
import 'package:rw334/screens/home/chats.dart';
import 'package:rw334/screens/home/chatscreen.dart';
import 'package:rw334/screens/home/home.dart';
import 'constants.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  BuildContext context = settings.arguments;
  Navigator.popUntil(context, ModalRoute.withName(HOME));
  switch (settings.name) {
    case HOME:
      return MaterialPageRoute(builder: (context) => UserHomePage());
    case CHAT:
      return MaterialPageRoute(builder: (context) => Chats());
    case CHATSCREEN:
      return MaterialPageRoute(builder: (context) => ChatScreen());
  }
}
