import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rw334/models/user.dart';

class LoginScreen extends StatefulWidget {
  
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  bool _rememberMe = true;

  @override
  Widget build(BuildContext context) {
    
    return Consumer<User>(
      builder: (context, user, child) {

        TextEditingController usernameController = TextEditingController(
          text: user.username,
        );
        TextEditingController passwordController = TextEditingController();

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
                  height: 32,
                ),
                // username textbox
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
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
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),
                    ),
                  ),
                  onPressed: () {
                    print('I want to login as \"${usernameController.value.text}\" with password \"${passwordController.value.text}\".');
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}