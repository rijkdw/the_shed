import 'dart:convert';
import 'package:http/http.dart';
import 'package:rw334/models/user.dart';

Future<User> signedUp(String username, String email, String psw) async {
  final String apiURL = "https://theshedapi.herokuapp.com/api/registration/";

  final response = await post(apiURL, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  }, body: {
    "username": username,
    "password": psw
  });

  if (response.statusCode == 200) {
    var resBody = json.decode(response.body);
    return User.fromJson(resBody);
  } else {
    print(response.statusCode);
    return null;
  }
}

Future<User> logedIn(String usr, String psw) async {
  String apiURL =
      "https://theshedapi.herokuapp.com/api-token-auth/";

  Response response = await post(apiURL, body: {
    "username": "user",
    "password": "password"
  });

  if (response.statusCode == 200) {
    var resBody = json.decode(response.body);
    // resBody returns token
    // token used in get requests
    // user -- group
    print(resBody);
    return User.fromJson(resBody);
  } else {
    print(response.statusCode);
    return null;
  }
}
