import 'package:flutter/material.dart';

class SettingsDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 90,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20),
            color: Colors.deepOrange,
            child: Center(
              child: Text(
                "Options",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 150,
            color: Colors.white,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  onTap: null,
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text(
                    "Settings",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  onTap: null,
                ),
                ListTile(
                  leading: Icon(Icons.arrow_back),
                  title: Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  onTap: null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
