import 'dart:convert';
import 'package:http/http.dart';
import 'package:rw334/models/user.dart';
import 'package:location/location.dart';
import 'package:rw334/models/post.dart';

var token;
List<dynamic> allUserJson;
List<Post> allUserPosts;
var allPosts;
String owner;
int userId;

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
  final String url = "https://theshedapi.herokuapp.com/api/registration/";

  final response = await post(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  }, body: {
    "username": username,
    "password": psw
  });

  if (response.statusCode == 200) {
    var resBody = json.decode(response.body);
    print(resBody);
    return null;
  } else {
    print(response.statusCode);
    return null;
  }
}

Future<int> userID(String user) async {
  String url = "https://theshedapi.herokuapp.com/api/v1/Users/?username=";
  url = url + user;
  List<dynamic> list;
  int id;

  final response = await get(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': "Token " + token
  });

  if (response.statusCode == 200) {
    list = json.decode(response.body);
  }
  id = list[0]["id"];
  return id;
}

Future<String> loggedIn(String usr, String psw) async {
  String apiURL = "https://theshedapi.herokuapp.com/api-token-auth/";

  Response response =
      await post(apiURL, body: {"username": usr, "password": psw});
  if (response.statusCode == 200) {
    token = json.decode(response.body);
    token = token["token"];

    userId = await userID(usr);
    //print(userId);
    getAllUserPosts();
    //buildUser();

    return null;
  } else {
    print(response.statusCode);
    return null;
  }
}

Future makePost(String txt, int grp) async {
  Location location = new Location();

  PermissionStatus _permissionGranted;
  LocationData _locationData;
  _locationData = await location.getLocation();
  double lat;
  double long;

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.DENIED) {
    _permissionGranted = await location.requestPermission();
    lat = null;
    long = null;
  } else {
    lat = _locationData.latitude;
    long = _locationData.longitude;
  }

  lat = lat.roundToDouble();
  long = long.roundToDouble();
  String group = "https://theshedapi.herokuapp.com/api/v1/groups/";
  group = group + "$grp" + '/';

  String url = "https://theshedapi.herokuapp.com/api/v1/posts/";
  print(token);
  final response = await post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Token " + token
      },
      body: JsonEncoder().convert(
          {"text": txt, "latitude": lat, "longitude": long, "group": group}));
  print(response.statusCode);
}

Future<List> getAllUserPosts() async {
  print(userId);
  String url =
      "https://theshedapi.herokuapp.com/api/v1/posts/?owner=" + "$userId";
  final response = await get(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': "Token " + token
  });
  if (response.statusCode == 200) {
    allUserJson = json.decode(response.body);
    //allUserPosts = createPosts(allUserJson);
    print(allUserPosts);
  }
  print(response.statusCode);
  return null;
}

Future<List> getUserFeed() async {
  List<dynamic> data;
  List groups;
  String groupUrl;
  String temp;
  List<dynamic> result;

  String url =
      "https://theshedapi.herokuapp.com/api/v1/posts/?owner=" + "$userId";
  var response = await get(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': "Token " + token
  });
  if (response.statusCode == 200) {
    data = json.decode(response.body);
    groups = data[0]["groups"];
  }

  url = "https://theshedapi.herokuapp.com/api/v1/posts/?group=";
  for (int i = 0; i < groups.length; i++) {
    temp = groups[i] as String;
    url = url + temp;

    response = await get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': "Token " + token
    });

    data = json.decode(response.body);
    for (int j = 0; j < data.length; j++) {
      result.add(data[j]);
    }
  }

  print(response.statusCode);
  return result;
}

List<Post> createPosts(List<dynamic> all) {
  Post post = new Post();
  double long;
  double lat;
  String text;
  var time;
  List<Post> posts;

  for (int i = 0; i < all.length; i++) {
    long = all[i]["longitude"];
    lat = all[i]["latitude"];
    text = all[i]["text"];
    time = all[i]["timestamp"];
    post = Post(text: text, epochTime: time, userId: userId);

    posts.add(post);
  }
  return posts;
}
