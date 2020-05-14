import 'package:flutter/material.dart';
import 'bar.dart';
import 'body.dart';

class UserLiked extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Screen"),
      ),
      bottomNavigationBar: BarB(),
      body: Body1(),
    );
  }
}
