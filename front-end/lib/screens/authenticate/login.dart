import 'package:flutter/material.dart';
import 'package:rw334/models/user.dart';
import 'package:rw334/screens/authenticate/signup.dart';
import 'package:rw334/screens/home/home.dart';
import 'package:rw334/service/httpService.dart';


class EmailFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Email can\'t be empty' : null;
  }
}

class PasswordFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Password can\'t be empty' : null;
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({this.onSignedIn});
  final VoidCallback onSignedIn;



  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

enum FormType {
  login,
  register,
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _rememberMe = true;

  Future<void> validateAndSubmit() async {

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
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
              height: 32,
            ),
            // username textbox
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: TextField(
                decoration: InputDecoration.collapsed(
                  hintText: 'Username',
                ),
                controller: usernameController,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            // password textbox
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration.collapsed(
                  hintText: 'Password',
                ),
                controller: passwordController,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            // Remember me
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Remember me',
                  style: TextStyle(
                    fontSize: 16,
                    // fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Container(
                  child: Checkbox(
                    activeColor: Theme.of(context).accentColor,
                    onChanged: (bool newValue) {
                      setState(() {
                        _rememberMe = newValue;
                        // widget.onSignedIn();
                      });
                    },
                    value: _rememberMe,
                  ),
                ),
              ],
            ),
            // Login button
            RaisedButton(
              color: Theme.of(context).accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.0),
              ),
              child: Container(
                width: 90,
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Text(
                    'LOGIN',
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
              onPressed: () async {

                FocusScope.of(context).unfocus(); // to remove the keyboard
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Material(
                      type: MaterialType.transparency,
                      child: Center(
                        child: CircularProgressIndicator(),
                      )
                    )
                  )
                );
                // showDialog<void>(
                //   context: context,
                //   barrierDismissible: false,
                //   builder: (BuildContext context) => Material(
                //     type: MaterialType.transparency,
                //     child: Center(
                //       child: CircularProgressIndicator(),
                //     )
                //   )
                // );
                String username = usernameController.value.text;
                String psw = passwordController.value.text;
                await loggedIn(username, psw);
                //getAllPosts();
                Navigator.pop(context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Home(psw:psw)),
                        (Route<dynamic> route) => false);
                },
            ),
            // sign up button
            RaisedButton(
              color: Theme.of(context).accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.0),
              ),
              child: Container(
                width: 90,
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Text(
                    'SIGN UP',
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SignUpScreen()
                  )
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
