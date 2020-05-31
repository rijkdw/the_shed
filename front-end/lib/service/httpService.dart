import 'dart:convert';
import 'package:http/http.dart';
import 'package:rw334/models/user.dart';

var token;
var allPosts;
var userGroups;
var userId;
// owner = url to current user
var owner;

// Todo: global variables that contain stuff for the buildUser()

Future<List> getAllPosts() async {
  String url = "https://theshedapi.herokuapp.com/api/v1/posts/";

  final response = await get(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': "Token " + token
  });

  if (response.statusCode == 200) {
    allPosts = json.decode(response.body);
    //print(allPosts);
  }
  print(response.statusCode);

  return null;
}

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
    return null;
  } else {
    print(response.statusCode);
    return null;
  }
}

Future<String> logedIn(String usr, String psw) async {
  String apiURL = "https://theshedapi.herokuapp.com/api-token-auth/";

  Response response =
      await post(apiURL, body: {"username": "user", "password": "password"});

  if (response.statusCode == 200) {
    token = json.decode(response.body);
    // resBody returns token
    // token used in get requests\
    // Token: <token>
    token = token["token"];

    buildUser();

    return null;
  } else {
    print(response.statusCode);
    return null;
  }
}

// Todo: return posts that belong to the group the current user is following
List userFeed() {
  List res;

  for (int i = 0; i < allPosts.lenght; i++) {
    //if user is in a group
    if (userGroups.contains(allPosts[i]["owner"])) res.add(allPosts[i]);
  }
  return res;
}

List userPosts() {
  List res;

  for (int i = 0; i < allPosts.length; i++) {
    //if user is in a group
    if (owner == allPosts[i]["owner"]) res.add(allPosts[i]);
  }
  return res;
}

// Todo: This will set up the data for user object &
// Todo: data for feed screen posts
void buildUser() {
  userId = 1;
  owner = "https://theshedapi.herokuapp.com/api/v1/Users/${userId}";
  List userP = userPosts();
  List userF = userFeed();

}