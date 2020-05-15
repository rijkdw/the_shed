import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppBar(),
    );
  }
}

// using wisdom from the 60-day-flutter Medium page
class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height = new AppBar().preferredSize.height;

  // class constants

  // colors
  final _titlebarColor = Color.fromRGBO(10, 10, 10, 1.0);
  final _iconColor = Colors.white;

  // fonts
  final _headingFont = TextStyle(color: Colors.white, fontSize: 20);
  final _subheadingFont = TextStyle(color: Colors.white, fontSize: 16);

  // values to display
  final String username = 'Rijk';

  final AppBar dummy = new AppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar();
  }

  /*

  @override
  Widget build(BuildContext context) {
    
    double width = MediaQuery.of(context).size.width; // calculate the screen width
    return Material(
      child: Container(
        decoration: new BoxDecoration(
            boxShadow: [
            //adds a shadow to the appbar
            new BoxShadow(
              color: Colors.black,
              blurRadius: 5.0,
            )
          ]
        ),
        child: Container(
          color: _titlebarColor,
          child: Row(
            children: [
              Expanded(
                flex: 7,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          height: 70 - (width * .06),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Center(
                                  child: Icon( Icons.attach_file, color: _iconColor )
                                )
                              ),
                              Expanded(
                                  flex: 6,
                                  child: Container(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text( 'Rijk de Wet', style: _headingFont ),
                                      Text( '@rijkdw', style: _subheadingFont )
                                    ],
                                  )
                                )
                              ),
                            ],
                          )),
                      
                      //second row containing the buttons for media
                      Container(
                        height: 23,
                        padding: EdgeInsets.fromLTRB(20, 5, 5, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text( 'Photos', style: _subheadingFont ),
                            VerticalDivider( width: 30, color: _iconColor ),
                            Text( 'Videos', style: _subheadingFont ),
                            VerticalDivider( width: 30, color: _iconColor ),
                            Text( 'Files', style: _subheadingFont )
                          ],
                        )
                      ),
                    ],
                  )
                )
              ),

              //This is the display picture
              Expanded(
                flex: 3,
                child: Container(
                  child: Center(
                    child: CircleAvatar(
                      radius: (80 - (width * .06)) / 2,
                      // image
                      // backgroundImage: Image.asset(
                      //   Assets.user,
                      // ).image,
                    ),
                  ),
                )
              ),
            ]
          )
        )
      )
    );
  }

  */

  @override
  Size get preferredSize => Size.fromHeight(height);
  
}
