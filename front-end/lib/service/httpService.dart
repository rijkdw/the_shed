
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rw334/models/user.dart';

Future<User> signedUp(String usrn, String psw) async {
  final String apiURL =  "https://theshedapi.herokuapp.com/api/v1/users/";

  final response = await http.post(apiURL, body: {
    "username": usrn,
    "password": psw
  });

  if (response.statusCode == 201) {
    Map<String, dynamic> reponseString = response.body as Map<String, dynamic>;
    print("passed");
    return User.fromJson(reponseString);
  }
  else {
    print(response.statusCode);
    return null;
}


}