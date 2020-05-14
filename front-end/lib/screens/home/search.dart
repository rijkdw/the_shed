import 'package:flutter/material.dart';
import 'package:rw334/screens/home/bar.dart';

import 'body.dart';

class Search extends StatelessWidget {
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
