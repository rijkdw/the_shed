import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rw334/models/user.dart';
import 'package:rw334/screens/home/home.dart';
import 'package:rw334/screens/wrapper.dart';
import 'package:http/http.dart';
import 'dart:async';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({this.onSignedIn});
  final VoidCallback onSignedIn;

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  SignUpField emailField = SignUpField(hintText: 'email');
  SignUpField usernameField = SignUpField(hintText: 'username');
  SignUpField nameField = SignUpField(hintText: 'real name');
  SignUpField passwordField = SignUpField(
    hintText: 'password',
    obscureText: true,
  );
  SignUpField confirmPasswordField = SignUpField(
    hintText: 'confirm password',
    obscureText: true,
  );

  void printData() {
    print('USER SIGNING UP:');
    print(emailField.toDebugString());
    print(nameField.toDebugString());
    print(usernameField.toDebugString());
    print(passwordField.toDebugString());
    print(confirmPasswordField.toDebugString());
    print('Password match? ${doPasswordsMatch()}');
    print(createUserObject().toString());
  }

  User createUserObject() {
    return User(
      email: emailField.value,
      name: nameField.value,
      username: usernameField.value,
      password: passwordField.value,
    );
  }

  bool isValidData() {
    if (!doPasswordsMatch()) return false;
    // TODO:  check if valid email (regex?)
    return true;
  }

  bool doPasswordsMatch() => passwordField.value == confirmPasswordField.value;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/logo.png',
              scale: 1.5,
            ),
            SizedBox(
              height: 24,
            ),
            // username textbox
            emailField,
            nameField,
            usernameField,
            passwordField,
            confirmPasswordField,
            SizedBox(
              height: 24,
            ),
            // Login button
            RaisedButton(
              color: Theme.of(context).accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.0),
              ),
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'SIGN UP',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              onPressed: () {
                //printData();
                widget.onSignedIn();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Home()),
                        (Route<dynamic> route) => false);
              },
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class SignUpField extends StatelessWidget {
  String _hintText;
  bool _obscureText;

  SignUpField({hintText, obscureText}) {
    this._hintText = hintText;
    this._obscureText = obscureText ?? false;
  }

  TextEditingController _controller = TextEditingController();

  String get value => _controller.text;

  String toDebugString() => '$_hintText:  \"${_controller.value.text}\"';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      padding: const EdgeInsets.fromLTRB(14, 0, 10, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      child: TextField(
        obscureText: _obscureText,
        decoration: InputDecoration.collapsed(
          hintText: _hintText,
        ),
        controller: _controller,
      ),
    );
  }
}
