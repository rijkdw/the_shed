import 'package:flutter/material.dart';
import 'package:rw334/screens/wrapper.dart';
import 'package:rw334/service/constants.dart';
import 'service/router.dart' as router;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        accentColor: Color.fromRGBO(255, 153, 0, 1.0),
      ),
      home: RootPage(),
      onGenerateRoute: router.generateRoute,
      initialRoute: HOME,
    );
  }
}
