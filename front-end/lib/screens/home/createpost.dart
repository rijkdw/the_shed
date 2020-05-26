import 'package:flutter/material.dart';

class PostCreatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Create a Post',
          )),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(4),
        color: Color.fromRGBO(41, 41, 41, 1),
        child: Column(
          children: [
            PostFieldWidget(
              hintText: '// body',
              labelText: 'Post body',
            ),
            GroupSelector(),
          ],
        ),
      ),
    );
  }
}



class GroupSelector extends StatefulWidget {

  @override
  _GroupSelectorState createState() => _GroupSelectorState();
}

class _GroupSelectorState extends State<GroupSelector> {
  
  String selectedGroup = 'Ronaldo\'s Greenhouse';
  
  @override
  Widget build(BuildContext context) {

    final _style = TextStyle(fontSize: 20, color: Colors.black);
    final _labelStyle = TextStyle(color: Colors.white, fontSize: 18);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Post in group',
          style: _labelStyle,
        ),
        Container(
          padding: const EdgeInsets.all(4),
          margin: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: DropdownButton<String>(
            value: selectedGroup,
            icon: null,
            elevation: 8,
            isDense: true,
            style: _style,
            items: ['Ronaldo\'s Greenhouse', 'Rijk\'s Gaming Clan', 'Steve\'s Linux Disco']
              .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }
            ).toList(),
            onChanged: (String newValue) {
              print('\"$newValue\" has been selected as group');
            },
          ),
        ),
      ],
    );
  }
}



class PostFieldWidget extends StatefulWidget {

  final labelText;
  final hintText;

  PostFieldWidget({this.labelText, this.hintText});

  @override
  _PostFieldWidgetState createState() => _PostFieldWidgetState();
}

class _PostFieldWidgetState extends State<PostFieldWidget> {

  final TextEditingController bodyController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _labelStyle = TextStyle(color: Colors.white, fontSize: 18);
    final _inputTextStyle = TextStyle(color: Colors.black, fontSize: 18.0);
    final _inputHintStyle = TextStyle(color: Colors.grey, fontSize: 18.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: _labelStyle,
        ),
        Container(
          padding: const EdgeInsets.all(4),
          margin: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: TextField(
            style: _inputTextStyle,
            controller: bodyController,
            decoration: InputDecoration.collapsed(
              hintText: widget.hintText,
              hintStyle: _inputHintStyle,
            ),
          ),
        ),
      ],
    );
  }
}
