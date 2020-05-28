import 'package:flutter/material.dart';
import 'authenticate/login.dart';
import 'home/home.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => new _RootPageState();
}

enum AuthStatus { notSignedIn, signedIn }

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn;

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        return new LoginScreen(
          onSignedIn: _signedIn,
        );

      //case AuthStatus.signedIn:
      //  return new Home(
      //    onSignedOut: _signedOut,
      //  );
    }
    return null;
  }
}
