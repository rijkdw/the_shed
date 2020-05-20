import 'package:flutter/material.dart';
import 'global.dart' as usr;

class Edit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text("Edit Profile"),
      ),
      body: EditBody(),
    );
  }
}

class EditBody extends StatelessWidget {
  final oneController = TextEditingController();
  final twoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Username",
            ),
            controller: oneController,
          ),

          TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
            controller: twoController,
          ),
          RaisedButton(
            child: Text("Save"),
            onPressed: () {
              String username;
              String password;
              final user = usr.dummy;

              if (oneController.text != '') {
                username = oneController.text;
              } else {
                username = user.username;
              }
              if (twoController.text != '') {
                password = twoController.text;
              } else {
                password = user.password;
              }
              bool fine = false;

              fine = user.update(username, password);

              if (fine) {
                Navigator.of(context).pop(true);
              }
            },
          ),
        ],
      ),
    );
  }
}
