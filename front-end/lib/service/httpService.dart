
import 'dart:convert';

import 'package:http/http.dart';
import 'package:rw334/models/user.dart';

Future<User> signedUp() async {
  Response res = await get(
      "https://theshedapi.herokuapp.com/api/v1/users/"
  );

  if (res.statusCode == 200) {
    print(jsonDecode(res.body));
  }
}