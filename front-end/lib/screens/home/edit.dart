import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rw334/models/user.dart';

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
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Consumer<User>(
      builder: (context, user, child) {
        return Container(
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Username",
                ),
                controller: usernameController,
              ),

              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
                controller: passwordController,
              ),
              RaisedButton(
                child: Text("Save"),
                onPressed: () {
                  String username;
                  String password;
                  // final user = usr.dummy; // not necessary since we now get user from the Consumer above

                  if (usernameController.text != '') {
                    username = usernameController.text;
                  } else {
                    username = user.username;
                  }
                  if (passwordController.text != '') {
                    password = passwordController.text;
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
      },
    );
  }
}
