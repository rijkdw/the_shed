import 'package:flutter/material.dart';
import 'package:rw334/screens/wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToolShed',
      home: Wrapper(),
    );
  }
}

