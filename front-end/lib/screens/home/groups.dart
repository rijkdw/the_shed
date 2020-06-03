import 'package:flutter/material.dart';
import 'package:rw334/models/group.dart';
import 'package:rw334/service/httpService.dart' as http;

class GroupsPage extends StatefulWidget {
  
  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  Future<List<Group>> _allGroups = http.getAllGroups();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset(
          "assets/logo.png",
          width: 120,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // mini: true,
        child: Icon(
          Icons.add,
          size: 30,
        ),
        onPressed: () => print('Open the group creator pls sir'),
      ),
      body: Container(
        color: Color.fromRGBO(41, 41, 41, 1.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder<List<Group>>(
          future: _allGroups,
          builder: (context, snapshot) {

            if (snapshot.connectionState != ConnectionState.done) {
              return Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              );
            }

            if (snapshot.hasData) {
              List<Group> groups = snapshot.data;
              return Container(
                padding: const EdgeInsets.all(6),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: groups.length,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      Group myGroup = groups[0];
                      myGroup.creatorID = http.userId;
                      return Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                        child: GroupCard(
                          group: myGroup,
                        ),
                      );
                    }
                    return Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                      child: GroupCard(
                        group: groups[index],
                      ),
                    );
                  }
                ),
              );
            }
            // dummy return
            return Expanded(
              child: Center(
                child: Icon(
                  Icons.error,
                  color: Colors.white,
                  size: 50,
                )
                // child: Text(
                //   'Waiting for posts...',
                //   style: TextStyle(fontSize: 20, color: Colors.white),
                // ),
              )
            );
          },
        ),
      ),
    );
  }
}

class GroupCard extends StatefulWidget {
  
  final Group group;
  GroupCard({@required this.group});

  @override
  _GroupCardState createState() => _GroupCardState();
}

class _GroupCardState extends State<GroupCard> {
  
  Future<String> _creatorName;
  
  @override
  void initState() { 
    super.initState();
    _creatorName = http.getUsernameFromID(widget.group.creatorID);
  }

  void _joinSequence() {
    print('Attempting to join \"${widget.group.name}\".');
  }

  void _deleteSequence() {
    print('Attempting to delete \"${widget.group.name}\".');
  }

  bool _userOwnsThisGroup() {
    return widget.group.creatorID == http.userId;
  }

  bool _userIsInThisGroup() {
    // TODO
    return false;
  }

  @override
  Widget build(BuildContext context) {

    var _titleStyle = TextStyle( color: Theme.of(context).accentColor, fontSize: 20 );
    var _subtitleStyle = TextStyle( color: Colors.white, fontSize: 18 );
    var _descStyle = TextStyle( color: Colors.white70, fontSize: 16 );
    var _expandedStyle = TextStyle( color: Colors.white70, fontSize: 14 );
    var _expandedStyleEmp = TextStyle( color: Theme.of(context).accentColor, fontSize: 16, fontWeight: FontWeight.bold );
    var _buttonStyle = TextStyle( color: Color.fromRGBO(30, 30, 30, 1.0), fontSize: 18, fontWeight: FontWeight.bold );

    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(30, 30, 30, 1.0),
        // borderRadius: BorderRadius.all(Radius.circular(4)),
        border: Border(
          left: BorderSide(
            color: Theme.of(context).accentColor.withOpacity(widget.group.creatorID == http.userId ? 1.0 : 0.0),
            width: 3,
          ),
        ),
      ),
      child: ExpansionTile(
        // initiallyExpanded: true,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 6),
          child: Text(
            widget.group.name,
            style: _titleStyle,
          ),
        ),
        subtitle: Text(
          widget.group.tag.trimRight().trimLeft().length > 0
              ? widget.group.tag
              : '(no tags)',
          style: _subtitleStyle,
        ),
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // the description
                Text(
                  widget.group.description.trimRight().trimLeft().length > 0
                      ? widget.group.description
                      : '(No description)',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 10,
                  style: _descStyle,
                ),
                SizedBox(
                  height: 4,
                ),
                // the rest
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // metadata
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Created at',
                                style: _expandedStyle
                              ),
                              TextSpan(
                                text: ' ${widget.group.timeCreated}',
                                style: _expandedStyleEmp
                              ),
                            ] 
                          ),
                        ),
                        FutureBuilder<String>(
                          future: _creatorName,
                          builder: (context, snapshot) {
                            if (snapshot.hasData)
                              return RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'by',
                                      style: _expandedStyle
                                    ),
                                    TextSpan(
                                      text: ' ${snapshot.data}',
                                      style: _expandedStyleEmp
                                    ),
                                  ] 
                                ),
                              );
                            return Text(
                              'Loading...',
                              overflow: TextOverflow.ellipsis,
                              style: _expandedStyle,
                            );
                          },
                        ),
                      ],
                    ),
                    // button
                    FlatButton(
                      onPressed: () {
                        print('Tapped on the action button for \"${widget.group.name}\".');
                        _userOwnsThisGroup()
                            ? this._deleteSequence()
                            : this._joinSequence();
                      },
                      color: Theme.of(context).accentColor,
                      child: Text(
                        _userOwnsThisGroup()
                            ? 'DELETE'
                            : 'JOIN', 
                        style: _buttonStyle
                      )
                    ),
                  ],
                )
              ],              
            )
          ),
        ],
        // children: <Widget>[
        //   Container(
        //     padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
        //     child: Row(
        //       children: <Widget>[
        //         Expanded(
        //           flex: 80,
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: <Widget>[
        //               Text(
        //                 widget.group.description.trimRight().trimLeft().length > 0
        //                     ? widget.group.description
        //                     : '(No description)',
        //                 overflow: TextOverflow.ellipsis,
        //                 maxLines: 10,
        //                 style: _expandedStyle,
        //               ),
        //               SizedBox(
        //                 height: 10,
        //               ),
        //               Text(
        //                 'Created at ${widget.group.timeCreated}',
        //                 overflow: TextOverflow.ellipsis,
        //                 style: _expandedStyle,
        //               ),
        //               SizedBox(
        //                 height: 10,
        //               ),
        //               FutureBuilder<String>(
        //                 future: _creatorName,
        //                 builder: (context, snapshot) {
        //                   if (snapshot.hasData)
        //                     return Text(
        //                       'by ${snapshot.data}',
        //                       overflow: TextOverflow.ellipsis,
        //                       style: _expandedStyle,
        //                     );
        //                   return Text(
        //                     'Loading...',
        //                     overflow: TextOverflow.ellipsis,
        //                     style: _expandedStyle,
        //                   );
        //                 },
        //               ),
        //             ],
        //           ),
        //         ),
        //         SizedBox(
        //           width: 10,
        //         ),
        //         Expanded(
        //           flex: 40,
        //           child: FlatButton(
        //             onPressed: () {
        //               print('Tapped on the action button for \"${widget.group.name}\".');
        //               _userOwnsThisGroup()
        //                   ? this._deleteSequence()
        //                   : this._joinSequence();
        //             },
        //             color: Theme.of(context).accentColor,
        //             child: Text(
        //               _userOwnsThisGroup()
        //                   ? 'DELETE'
        //                   : 'JOIN', 
        //               style: TextStyle(
        //                 fontSize: 18,
        //               ),
        //             )
        //           ),
        //         ),
        //       ],
        //     ),
        //   )
        // ],
      ),
    );
  }
}