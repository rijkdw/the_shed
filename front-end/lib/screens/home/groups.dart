import 'package:flutter/material.dart';
import 'package:rw334/models/group.dart';
import 'package:rw334/service/httpService.dart';

class GroupsPage extends StatelessWidget {
  
  Future<List<Group>> _allGroups = getAllGroups();

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
              return Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (snapshot.hasData) {
              List<Group> groups = snapshot.data;
              return Container(
                padding: const EdgeInsets.all(4),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: groups.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
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

class GroupCard extends StatelessWidget {
  
  final Group group;
  GroupCard({@required this.group});

  @override
  Widget build(BuildContext context) {

    var _titleStyle = TextStyle( color: Colors.white, fontSize: 20 );
    var _subtitleStyle = TextStyle( color: Colors.white60, fontSize: 16 );
    var _expandedStyle = TextStyle( color: Colors.white60, fontSize: 16 );

    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(30, 30, 30, 1.0),
        borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      child: ExpansionTile(
        initiallyExpanded: true,
        title: Text(
          group.name,
          style: _titleStyle,
        ),
        subtitle: Text(
          group.tag,
          style: _subtitleStyle,
        ),
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 8, 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        group.description,
                        overflow: TextOverflow.ellipsis,
                        style: _expandedStyle,
                      ),
                      Text(
                        'Created ${group.timeCreated}',
                        overflow: TextOverflow.ellipsis,
                        style: _expandedStyle,
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 20,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      child: Container(
                        // color: Colors.red,
                        child: Icon(
                          Icons.more_horiz,
                          color: Theme.of(context).accentColor,
                          size: 40,
                        ),
                      ),
                      onTap: () => print('Trying to open group \"${group.name}\"'),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}