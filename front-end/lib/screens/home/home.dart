import 'package:flutter/material.dart';
import 'package:rw334/screens/home/body.dart';
import 'package:rw334/service/constants.dart';
import 'package:rw334/screens/home/bar.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: UserHomePage(),
    );
  }
}
class UserHomePage extends StatefulWidget {
  void pressedB() {
    print('mooo');
  }
  @override
  _UserHomePageState createState() => _UserHomePageState();


}
class _UserHomePageState extends State<UserHomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Image.asset("assets/logo.png",
            width: 120,
          ),
          actions: <Widget>[
            // button to open one chat (only for debug purposes) - Rijk
            IconButton(
              icon: const Icon(Icons.face, color: Colors.grey,),
              onPressed: () {
                Navigator.pushNamed(context, CHATSCREEN, arguments: context);
              },
            ),
            // button to open chats
            IconButton(
              icon: const Icon(Icons.near_me, color: Colors.grey,),
              onPressed: () {
                Navigator.pushNamed(context, CHAT, arguments: context);
              },
            ),
          ],
        ),

      bottomNavigationBar: BarB(),
      body: Body1(),
    );
  }
}