import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rw334/models/user.dart';
import 'package:provider/provider.dart';
import 'drawer.dart';

class ProfilePage extends StatelessWidget {
//http request-get
  @override
  Widget build(BuildContext context) {
    return Consumer<User>(
      builder: (context, user, child) {
        return Scaffold(
          appBar: new AppBar(
            backgroundColor: Colors.deepOrange,
            title: Text(
              user.getUsername()
            ),
          ),
          endDrawer: SettingsDrawer(),
          body: Container(
            color: Color.fromRGBO(41, 41, 41, 1),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                //TODO: profile card
                Container(
                  padding: EdgeInsets.all(8),
                  color: Colors.black,
                  height: 125,
                  child: Row(
                    children: [

                      // profile picture and display name
                      Container(
                        child: Row(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(user.getPicture()),
                                    radius: 40,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 5, left: 2),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      user.getName(),
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        letterSpacing: 0.7,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      // posts
                      Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 35, top: 28),
                            child: Align(
                              //alignment: Alignment.topRight,
                              child: Text(
                                user.getPost(),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  letterSpacing: 0.7,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 35),
                            child: Align(
                              //alignment: Alignment.topRight,
                              child: Text(
                                "POSTS ",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  letterSpacing: 0.7,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      // followers
                      Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 25, top: 28),
                            child: Align(
                              //alignment: Alignment.topRight,
                              child: Text(
                                user.getFollowing(),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  letterSpacing: 0.7,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 25),
                            child: Align(
                              //alignment: Alignment.topRight,
                              child: Text(
                                "FOLLOWING ",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  letterSpacing: 0.7,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
