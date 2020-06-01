import 'dart:convert';
import 'package:http/http.dart';
import 'package:rw334/models/user.dart';
import 'package:location/location.dart';
import 'package:rw334/models/post.dart';

var token;
List<dynamic> allUserPosts;
List<dynamic> allUserFeed;
List allFeed;
List allPosts;
String owner;
int userId;

Future getAllPosts() async {
  var data;
  String url = "https://theshedapi.herokuapp.com/api/v1/posts/";
  final response = await get(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': "Token " + token
  });
  if (response.statusCode == 200) {
    data = json.decode(response.body);
  }
  print(response.statusCode);
  return data;
}

Future signedUp(String username, String email, String psw) async {
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
//returns userID
Future userID(String user) async {
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
//returns user auth-token
Future loggedIn(String usr, String psw) async {
  String apiURL = "https://theshedapi.herokuapp.com/api-token-auth/";

  Response response =
      await post(apiURL, body: {"username": usr, "password": psw});
  if (response.statusCode == 200) {
    token = json.decode(response.body);
    token = token["token"];

    userId = await userID(usr);
    print(userId);
    makeUser();
    return null;
  } else {
    print(response.statusCode);
    return null;
  }
}

Future<void> makeUser() async {
  getAllUserPosts();
  getUserFeed();
  await new Future.delayed(const Duration(seconds : 6));
  allUserPosts = createPosts(allPosts);
  allUserFeed = createPosts(allFeed);
  // print List<Post>
  // print("Posts made by user: ");
  print(allUserPosts);
  // print("Posts user follow: ");
  print(allUserFeed);

}
//makes a post by post request
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

  final response = await post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Token " + token
      },
      body: JsonEncoder().convert(
          {"text": txt, "latitude": lat, "longitude": long, "group": group}));
  print(response.statusCode);
}
//returns all posts made by the Current user
Future getAllUserPosts() async {
  List temp;
  String url =
      "https://theshedapi.herokuapp.com/api/v1/posts/?owner=" + "$userId";
  final response = await get(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': "Token " + token
  });
  if (response.statusCode == 200) {
    temp = json.decode(response.body);
  }

  allPosts = temp;
  //print(allPosts);
}
// returns all the posts the current user is interested in
Future getUserFeed() async {
  var data;
  var groups;
  int temp;
  var result = [];

  String url =
      "https://theshedapi.herokuapp.com/api/v1/Users/?id=" + "$userId";
  var response = await get(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': "Token " + token
  });
  if (response.statusCode == 200) {
    data = json.decode(response.body);
    groups = data[0]["groups"];
  }

  for (int i = 0; i < groups.length; i++) {
    url = "https://theshedapi.herokuapp.com/api/v1/posts/?group=";
    temp = groups[i];
    url = url + "$temp";
    //print(url);

    response = await get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': "Token " + token
    });

    data = json.decode(response.body);

    for (int j = 0; j < data.length; j++) {
      result.add(data[j]);
    }
  }
  allFeed = result;
  //print(allFeed);
}

//takes in a list of data
//returns a list of type <Post>
List createPosts(var all) {
  Post post;
  double long;
  double lat;
  String text;
  var time;
  List posts = [];

  for (int i = 0; i < all.length; i++) {
    print("succ");
    long = all[i]["longitude"];
    lat = all[i]["latitude"];
    text = all[i]["text"];
    time = all[i]["timestamp"];
    time = convertTime(time);
    post = new Post(text: text, epochTime: time, latitude:lat, longitude:long, categories: ['Gardening', 'Environmental', 'Sustainability']);

    posts.add(post);
  }
  return posts;
}


int convertTime (String time) {
  var parsedDate = DateTime.parse(time);
  int epoch = parsedDate.toUtc().millisecondsSinceEpoch;
  return epoch;

}