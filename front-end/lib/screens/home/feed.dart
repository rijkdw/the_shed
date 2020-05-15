import 'package:flutter/material.dart';

class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.pop(context, true);
        return false;
      },
      child: Container(
      color: Color.fromRGBO(41, 41, 41, 1),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                  child: FittedBox(
                      child: Material(
                          color: Colors.black45,
                          elevation: 10.0,
                          shadowColor: Colors.black12,
                          child: Row(
                            children: <Widget>[
                              Container(
                                  height: 70,
                                  child: CircleAvatar(
                                    radius:25,
                                    backgroundImage: AssetImage("assets/user1.jpeg"),
                                  )
                              ),
                              Container(
                                  child: Column(
                                      children:[
                                        Text(
                                          'Stellebosch, 15:00',
                                          style: TextStyle(
                                            color: Color.fromRGBO(255, 163, 26, 1),
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          'gardening (420)',
                                          style: TextStyle(
                                            color: Color.fromRGBO(255, 163, 26, 1),
                                            fontSize: 24,
                                          ),
                                        )
                                      ]
                                  )
                              )
                            ],
                          )
                      )
                  )
              )
          )
        ],
      ),
    )
    );
  }
}