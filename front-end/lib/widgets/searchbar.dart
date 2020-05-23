import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {

  // constants

  // styles
  final _inputTextStyle = TextStyle(color: Colors.black, fontSize: 15.0);
  final _inputHintStyle = TextStyle(color: Colors.grey);

  final TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Container(
      // white rectangle
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: Container(
        // grey rounded
        padding: const EdgeInsets.all(6),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          // text
          child: TextField(
            style: _inputTextStyle,
            controller: controller,
            decoration: InputDecoration.collapsed(
              hintText: 'Search...',
              hintStyle: _inputHintStyle,
            ),
          ),
        ),
      ),
    );
  }
}