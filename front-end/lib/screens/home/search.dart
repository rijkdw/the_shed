import 'dart:math';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  List<String> results = [];

  void search(String query) {
    print('Received query \"$query\"');
    List<String> dummyList = [ 'Steve', 'Rijk', 'Ronaldo' ];
    int numToDisplay = (new Random()).nextInt(3)+2;
    List<String> returnUsers = [];
    for (int i = 0; i < numToDisplay; i++) {
      int nextIndex = (new Random()).nextInt(dummyList.length-1);
      returnUsers.add(dummyList[nextIndex]);
    }
    setState(() {
      results = returnUsers;
    });
  }

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
      body: Container(
        color: Color.fromRGBO(41, 41, 41, 1),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children:[
            SearchBar(
              searchCallback: search,
            ),
            Container(
              padding: const EdgeInsets.all(4),
              child: SearchResultsList(
                results: results
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SearchResultsList extends StatelessWidget {

  final List<String> results;
  SearchResultsList({@required this.results});

  @override
  Widget build(BuildContext context) {
    if (results.length == 0) {
      return Expanded(
        child: Center(
          child: Text(
            'Searching for...',
            style: TextStyle( color: Colors.white, fontSize: 20, ),
          ),
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: results.length,
      itemBuilder: (context, index) {
        return Text(
          results[index],
          style: TextStyle( color: Colors.white, fontSize: 18, ),
        );
      }
    );
  }
}

class SearchBar extends StatelessWidget { 

  final Function(String) searchCallback;
  SearchBar({@required this.searchCallback});

  final TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    final _inputTextStyle = TextStyle(color: Colors.black, fontSize: 16.0);
    final _inputHintStyle = TextStyle(color: Colors.grey);    

    return Container(
      // white rectangle
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
      child: Container(
        padding: const EdgeInsets.all(4),

        // grey rounded
        child: Container(
          padding: const EdgeInsets.only(left: 8),
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          
          // text
          child: TextField(
            style: _inputTextStyle,
            controller: controller,
            decoration: InputDecoration.collapsed(
              hintText: 'Search...',
              hintStyle: _inputHintStyle,
            ),
            // onChanged: searchCallback(controller.text),
          ),
        ),
      ),
    );
  }
}