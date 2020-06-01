import 'package:flutter/material.dart';
import 'package:rw334/service/httpService.dart';

class PostCreatorPage extends StatefulWidget {
  
  @override
  _PostCreatorPageState createState() => _PostCreatorPageState();
}

class _PostCreatorPageState extends State<PostCreatorPage> {
  
  String _selectedGroup = 'Ronaldo\'s Greenhouse';
  String get selectedGroup => _selectedGroup;

  TextEditingController textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    final _style = TextStyle(fontSize: 20, color: Colors.black);
    final _labelStyle = TextStyle(color: Colors.white, fontSize: 18);
    final _metadataFieldStyle = TextStyle(color: Theme.of(context).accentColor, fontSize: 18, fontWeight: FontWeight.bold);
    final _metadataValueStyle = TextStyle(color: Colors.white, fontSize: 18);
    final _inputTextStyle = TextStyle(color: Colors.black, fontSize: 20.0);
    final _inputHintStyle = TextStyle(color: Colors.grey, fontSize: 20.0);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Posting',
        )
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        color: Color.fromRGBO(41, 41, 41, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            // post body
            Container(
              padding: const EdgeInsets.fromLTRB(4, 0, 4, 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: TextField(
                maxLength: 200,
                maxLengthEnforced: true,
                // expands: true,
                minLines: 1,
                maxLines: 10,
                style: _inputTextStyle,
                controller: textController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Body',
                  hintStyle: _inputHintStyle,
                ),
              ),
            ),
            
            BigSpacer(),        
            
            // group selection
            Text(
              'in group',
              style: _labelStyle,
            ),
            SmallSpacer(),  
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedGroup,
                icon: null,
                elevation: 8,
                isDense: true,
                style: _style,
                items: ['Ronaldo\'s Greenhouse', 'Rijk\'s Gaming Clan', 'Steve\'s Linux Disco']
                  .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    );
                  }
                ).toList(),
                onChanged: (String newValue) {
                  print('\"$newValue\" has been selected as group');
                  setState(() {
                    this._selectedGroup = newValue;
                  });
                },
              ),
            ),

            BigSpacer(),
      
            // metadata (such as location, time, etc)
            Text(
              'with metadata',
              style: _labelStyle,
            ),
            SmallSpacer(),
            Table(
              columnWidths: {
                0: FractionColumnWidth(.35),
                // 1: FractionColumnWidth(.7),
              },
              children: [
                TableRow(
                  children: [
                    Text( 'USERNAME', style: _metadataFieldStyle ),
                    Text( 'Rice Balls', style: _metadataValueStyle ),
                  ]
                ),
                TableRow(
                  children: [
                    Text( 'TIME', style: _metadataFieldStyle ),
                    Text( '${DateTime.now().hour.toString().padLeft(2)}:${DateTime.now().minute.toString().padLeft(2)}', style: _metadataValueStyle ),
                  ]
                ),
                TableRow(
                  children: [
                    Text( 'LOCATION', style: _metadataFieldStyle ),
                    Text( 'Stellenbosch, ZA', style: _metadataValueStyle ),
                  ]
                ),
              ],
            ),

            BigSpacer(),

            // submit button
            Center(
              child: RaisedButton(
                color: Theme.of(context).accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0),
                ),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'POST',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                onPressed: () async{
                  String txt = textController.text;
                  makePost(txt, userId);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BigSpacer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 14);
  }
}

class SmallSpacer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 4);
  }
}