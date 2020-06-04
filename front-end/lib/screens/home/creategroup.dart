import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rw334/models/user.dart';
import 'package:rw334/service/httpService.dart';

class GroupCreatorPage extends StatefulWidget {
  
  final VoidCallback refreshCallback;
  GroupCreatorPage({@required this.refreshCallback});
  
  @override
  _GroupCreatorPageState createState() => _GroupCreatorPageState();
}

class _GroupCreatorPageState extends State<GroupCreatorPage> {
  
  Future<String> _locationName = getCurrentLocationName();
  TextEditingController textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _style = TextStyle(fontSize: 20, color: Colors.black);
    final _labelStyle = TextStyle(color: Colors.white, fontSize: 18);
    final _inputTextStyle = TextStyle(color: Colors.black, fontSize: 20.0);
    final _inputHintStyle = TextStyle(color: Colors.grey, fontSize: 20.0);
    return Consumer<User>(builder: (context, user, child) {
      return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
              'Creating Group',
            )),
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
                    hintText: 'Group Name',
                    hintStyle: _inputHintStyle,
                  ),
                ),
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
                      'CREATE',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  onPressed: () async {
                    print('Confirm button pressed');
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
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
