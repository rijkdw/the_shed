import 'package:flutter/material.dart';
import 'package:rw334/screens/home/body.dart';
import 'chats.dart';
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
            IconButton(
              icon: const Icon(Icons.near_me, color: Colors.grey,),
              onPressed: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context)=> Chats()),
                );
              },
            ),
          ],
        ),

      bottomNavigationBar: BarB(),
      body: Body1(),
    );
  }
}