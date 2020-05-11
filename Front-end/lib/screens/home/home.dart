import 'package:flutter/material.dart';
import 'package:rw334/screens/home/body.dart';
import 'chats.dart';
import 'package:rw334/screens/home/bar.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  void pressedB() {
    print('mooo');
  }
  @override
  _MyHomePageState createState() => _MyHomePageState();


}
class _MyHomePageState extends State<MyHomePage> {
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