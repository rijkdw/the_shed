import 'package:flutter/material.dart';

class Demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Center(
        child: Text(
          "Signed up",
          style: TextStyle(
            fontSize: 20,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
