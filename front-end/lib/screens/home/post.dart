import 'package:flutter/material.dart';
import 'package:rw334/screens/home/bar.dart';

import 'body.dart';

class UserPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Own Thread Screen"),
      ),
      bottomNavigationBar: BarB(),
      body: Body1(),
    );

  }
}
