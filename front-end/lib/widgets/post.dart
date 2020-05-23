import 'package:flutter/material.dart';

// widget
class PostCard extends StatefulWidget {
  
  String title;
  String username;
  String groupname;
  var categories = <String>[];

  PostCard({String title, var categories, String username, String groupname}) {
    this.title = title;
    this.categories.addAll(categories);
    this.username = username;
    this.groupname = groupname;
  }  

  @override
  _PostCardState createState() => _PostCardState(this.title, this.categories, this.username, this.groupname);
}

// state
class _PostCardState extends State<PostCard> {
  
  // variables
  String title;
  String username;
  String groupname;
  var categories = <String>[];

  // constructor
  _PostCardState(String title, var categories, String username, String groupname) {
    this.title = title;
    this.categories.addAll(categories);
    this.username = username;
    this.groupname = groupname;
  }

  // class constants
  TextStyle _styleHeaderEmphasis = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );
  TextStyle _styleHeaderNormal = TextStyle(
    color: Colors.white70,
    fontSize: 11,
  );
  TextStyle _styleTitle = TextStyle(
    color: Colors.white,
    fontSize: 16,
  );
  TextStyle _styleFooter = TextStyle(
    color: Colors.white70,
    fontSize: 11,
  );

  // pretty categories method
  String prettyCategories() {
    return this.categories.join('  |  ');
  }

  // build method
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('Tap me harder daddy');
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color.fromRGBO(20, 20, 20, 1.0),
          borderRadius: BorderRadius.all(Radius.circular(4)),
          boxShadow: [
            BoxShadow(
              offset: Offset(2,2),
              blurRadius: 1,
              color: Colors.black.withOpacity(0.3)
            )
          ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // user in group
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: this.username,
                    style: _styleHeaderEmphasis
                  ),
                  TextSpan(
                    text: ' in ',
                    style: _styleHeaderNormal
                  ),
                  TextSpan(
                    text: this.groupname,
                    style: _styleHeaderEmphasis
                  ),
                ],
              ),
            ),
            
            // spacing
            SizedBox(
              height: 4,
            ),

            // title
            Text(
              this.title,
              style: _styleTitle,
            ),

            // spacing
            SizedBox(
              height: 6,
            ),

            // categories
            Text(
              this.prettyCategories(),
              style: _styleFooter,
            )
          ],
        ),
      ),
    );
  }
}
