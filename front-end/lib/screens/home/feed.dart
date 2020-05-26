import 'package:flutter/material.dart';
import 'package:rw334/models/post.dart';
import 'global.dart';
import 'postpage.dart';
import 'createpost.dart';

class FeedPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset(
          "assets/logo.png",
          width: 120,
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            iconSize: 30,
            onPressed: () {
              print('FeedPage refresh pressed');
            },
          ),
        ],
      ),
      body: Container(
        color: Color.fromRGBO(41, 41, 41, 1),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Column(
              children: [
                SortingBar(),
                FeedWidget(),
              ],          
            ),
          ]
        ),
      ),
      floatingActionButton: NewPostButton()
    );
  }
}

class NewPostButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      mini: true,
      child: Icon(
        Icons.add,
        size: 30,
      ),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => PostCreatorPage()));
      },
    );
  }
}

class FeedWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        child: ListView.builder(
          padding: const EdgeInsets.all(4),      
          itemCount: dummyPosts.length,    
          itemBuilder: (context, i) {
            return Container(
              padding: const EdgeInsets.all(4),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => PostPage(dummyPosts[i])));
                },
                child: PostCard(
                  post: dummyPosts[i],
                  lineLimit: 3,
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}


class SortingBar extends StatefulWidget {

  @override
  _SortingBarState createState() => _SortingBarState();
}

class _SortingBarState extends State<SortingBar> {
  
  String sortingKey = 'Time';
  String sortingOrder = 'Asc'; 

  @override
  Widget build(BuildContext context) {

    final TextStyle _style = TextStyle(fontSize: 16, color: Colors.black);

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 4, 14, 4),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 3),
            blurRadius: 1,
            color: Colors.black.withOpacity(0.2),
          )
        ]
      ),
      child: Row(
        children: [
          
          // the label
          Text(
            'Sort by...',
            style: _style,
          ),

          // sort by time, group, user, etc
          Container(
            margin: const EdgeInsets.only(left: 12),
            child: DropdownButton<String>(
              value: sortingKey,
              icon: null,
              elevation: 8,
              isDense: true,
              style: _style,
              items: <String>['Time', 'Location', 'User', 'Category', 'Likes']
                .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }
              ).toList(),
              onChanged: (String newValue) {
                print('\"$newValue\" has been selected as sorting key');
                setState(() { sortingKey = newValue; });                
              },
            ),
          ),

          // sort ascending or descending
          Container(
            margin: const EdgeInsets.only(left: 12),
            child: DropdownButton<String>(
              value: sortingOrder,
              icon: null,
              elevation: 8,
              isDense: true,
              style: _style,
              items: <String>['Asc', 'Desc']
                .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }
              ).toList(),
              onChanged: (String newValue) {
                print('\"$newValue\" has been selected as sorting order');
                setState(() { sortingOrder = newValue; });                
              },
            ),
          ),

          // confirm
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              width: 40,
              child: RaisedButton(
                color: Colors.white,
                onPressed: () => print('uwu'),
                child: Text(
                  'Go'
                )
              ),
            ),
          )
        ],
      )
    );
  }
}



class PostCard extends StatefulWidget {
  
  Post post;
  int lineLimit;

  PostCard({Post post, int lineLimit}) {
    this.post = post;
    this.lineLimit = lineLimit;
  }

  @override
  _PostCardState createState() => _PostCardState();
}

// state
class _PostCardState extends State<PostCard> {
  
  // variables
  final categoriesAccented = false;  

  RichText getPrettyCategories() {

    TextStyle _styleFooter = TextStyle(
      color: Colors.white70,
      fontSize: 16,
    );

    List<TextSpan> returnList = [];
    int i = 0;
    for (String category in widget.post.categories) {
      returnList.add(
        TextSpan(
          text: category,
          style: _styleFooter.copyWith(
            color: Theme.of(context).accentColor
          )
        )
      );
      if (i < widget.post.categories.length) {
        returnList.add(
          TextSpan(
            text: '  |  ',
            style: _styleFooter,
          )
        );
      }
      i++;
    }
    return RichText(
      text: TextSpan(
        children: returnList
      )
    );
  }

  // build method
  @override
  Widget build(BuildContext context) {

    TextStyle _styleHeaderEmphasis = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    TextStyle _styleHeaderNormal = TextStyle(
      color: Colors.white70,
      fontSize: 14,
    );
    TextStyle _styleTitle = TextStyle(
      color: Colors.white,
      fontSize: 20,
    );
    TextStyle _styleFooter = TextStyle(
      color: Colors.white70,
      fontSize: 16,
    );

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color.fromRGBO(30, 30, 30, 1.0),
        borderRadius: BorderRadius.all(Radius.circular(4)),
        boxShadow: [
          BoxShadow(
            offset: Offset(0,2),
            blurRadius: 1,
            color: Colors.black.withOpacity(0.2),
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
                  text: widget.post.username,
                  style: _styleHeaderEmphasis.copyWith( color: Theme.of(context).accentColor ),
                ),
                TextSpan(
                  text: ' in ',
                  style: _styleHeaderNormal
                ),
                TextSpan(
                  text: widget.post.groupname,
                  style: _styleHeaderEmphasis.copyWith( color: Theme.of(context).accentColor ),
                ),
              ],
            ),
          ),
          
          // spacing
          SizedBox(
            height: 4,
          ),

          // text
          Text(
            widget.post.text,
            maxLines: widget.lineLimit,
            overflow: TextOverflow.ellipsis,
            style: _styleTitle,
          ),

          // spacing
          SizedBox(
            height: 6,
          ),

          categoriesAccented
          // accented categories
          ? this.getPrettyCategories()

          // plain white categories
          : Text(
            widget.post.prettyCategories,
            style: _styleFooter,
          )
        ],
      ),
    );
  }
}