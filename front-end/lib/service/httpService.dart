import 'dart:convert';
import 'package:geocoder/geocoder.dart';
import 'package:http/http.dart';
import 'package:rw334/models/comment.dart';
import 'package:location/location.dart';
import 'package:rw334/models/group.dart';
import 'package:rw334/models/post.dart';

var token;
List<dynamic> allUserPosts;
List<dynamic> allUserFeed;
List allFeed;
List allPosts;
String owner;
String globalUsername;
int userId;
int numberPost = 0;
Set<String> globalGroupsID = {};
Set<String> globalGroups = {};

List<String> getGlobalGroups() {
  List ls = globalGroups.toList();
  return ls;
}

List<String> getGlobalGroupsID() {
  List ls = globalGroupsID.toList();
  return ls;
}

Future makeComment(String txt, int pid) async {
  String url = "https://theshedapi.herokuapp.com/api/v1/Comments/";
  final res = await post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': "Token " + token
    },
    body: JsonEncoder().convert(
      {
        "text": txt,
        "post": pid,
        "owner": userId,
      },
    ),
  );
  return null;
}

Future signedUp(String username, String email, String psw) async {
  final String url = "https://theshedapi.herokuapp.com/api/registration/";

  final response = await post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: JsonEncoder().convert(
      {
        "username": username,
        "password": psw,
        "email": email,
        "groups": [51],
      },
    ),
  );

  if (response.statusCode == 200) {
    var resBody = json.decode(response.body);
    return null;
  } else {
    //print(response.statusCode);
    return null;
  }
}

//returns userID of user with this username
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

Future<String> getUsernameFromID(int id) async {
  String url = "https://theshedapi.herokuapp.com/api/v1/Users/?id=";
  url = url + '${id.toString()}';
  List<dynamic> list;
  String res;

  final response = await get(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': "Token " + token
  });

  if (response.statusCode == 200) {
    list = json.decode(response.body);
    res = list[0]['username'];
    return res;
  } else {
    return 'DEF_USERNAME';
  }
}

// returns user auth-token
Future loggedIn(String usr, String psw) async {
  String apiURL = "https://theshedapi.herokuapp.com/api-token-auth/";

  Response response =
      await post(apiURL, body: {"username": usr, "password": psw});
  if (response.statusCode == 200) {
    token = json.decode(response.body);
    token = token["token"];

    userId = await userID(usr);
    //print(userId);
    makeUser();
    return null;
  } else {
    //print(response.statusCode);
    return null;
  }
}

Future<void> makeUser() async {
  globalUsername = await getUsernameFromID(userId);
  getAllUserPosts();
  getUserFeed('Time', 'Asc');
}

/// Get a List<Group> of all the groups that exist.
Future<List<Group>> getAllGroups() async {
  List data = [];
  List<Group> results = [];
  String url = "https://theshedapi.herokuapp.com/api/v1/groups/";
  final response = await get(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': "Token " + token
  });
  if (response.statusCode == 200) {
    data = json.decode(response.body);
  }
  for (int i = 0; i < data.length; i++) {
    // evaluating data[j]
    results.add(
      Group(
        id: data[i]['id'] ?? 'DEF_ID',
        epochTime: convertTime(data[i]['date_created']) ?? 'DEF_TIME',
        name: data[i]['name'] ?? 'DEF_NAME',
        tag: data[i]['tag'] ?? 'DEF_TAG',
        description: data[i]['description'] ?? 'DEF_DESC',
      ),
    );
  }
  allPosts = results;
  numberPost = allPosts.length;

  return results;
}

/// Get the name of the location at the given coordinates.
Future<String> getLocationFromCoords(double lat, double long) async {
  if (lat > 90.0 || lat < -90.0 || long > 180.0 || long < -180.0) {
    return '!!!';
  }
  try {
    final coordinates = Coordinates(lat, long);
    List<Address> addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    // print('${addresses.first.locality}');
    return '${addresses.first.locality}, ${addresses.first.countryCode}';
  } on Exception catch (e) {
    //print(e.toString());
    return '???';
  }
}

/// Get the name of location the device is currently at.
Future<String> getCurrentLocationName() async {
  Location location = new Location();

  PermissionStatus _permissionGranted;
  LocationData _locationData;
  _locationData = await location.getLocation();
  double lat;
  double long;

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.DENIED) {
    _permissionGranted = await location.requestPermission();
    // Stellenbosch's location
    lat = -33.93;
    long = 18.86;
  } else {
    lat = _locationData.latitude;
    long = _locationData.longitude;
  }

  return await getLocationFromCoords(lat, long);
}

/// Makes a post with the given text in the given group.
Future makePost(String txt, String grp) async {
  //print('Making post \"$txt\" in \"$grp\"');
  Location location = new Location();

  PermissionStatus _permissionGranted;
  LocationData _locationData;
  _locationData = await location.getLocation();
  double lat;
  double long;

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.DENIED) {
    _permissionGranted = await location.requestPermission();
    // Stellenbosch's location
    lat = -33.93;
    long = 18.86;
  } else {
    lat = _locationData.latitude;
    long = _locationData.longitude;
  }

  String locationName = await getLocationFromCoords(lat, long);
  print(locationName);

  String url = "https://theshedapi.herokuapp.com/api/v1/posts/";
  var temp = getGlobalGroups();
  var temp2 = getGlobalGroupsID();
  String group = temp2[temp.indexOf(grp)];
  //print(group);

  final response = await post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Token " + token
      },
      body: JsonEncoder().convert(
          {"text": txt, "latitude": lat, "longitude": long, "group": group}));
  //print(response.statusCode);
}

/// Get all the posts made by the current user.
Future<List<Post>> getAllUserPosts() async {
  List data;
  List<Post> results = [];
  String url =
      "https://theshedapi.herokuapp.com/api/v1/posts/?owner=" + "$userId";
  final response = await get(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': "Token " + token
  });
  if (response.statusCode == 200) {
    data = json.decode(response.body);
  }
  for (int j = 0; j < data.length; j++) {
    // evaluating data[j]
    String locationName =
        await getLocationFromCoords(data[j]['latitude'], data[j]['longitude']);
    results.add(
      Post(
        id: data[j]['id'],
        longitude: data[j]['longitude'],
        latitude: data[j]['latitude'],
        text: data[j]['text'],
        epochTime: convertTime(data[j]['timestamp']),
        categories: ['Cat 1', 'Cat 2', 'Cat 3'],
        username: data[j]['owner'],
        groupname: data[j]['group_name'],
        locationname: locationName,
      ),
    );
  }
  allPosts = results;
  numberPost = allPosts.length;

  return results;
}
void joinGroup(String url) async {
  //url = na group
  String url_prof = "https://theshedapi.herokuapp.com/api/v1/Users/$userId/";

  //var response = await patch();
}

/// Get all the comments on the post with the given ID.
Future<List<Comment>> getCommentsOnPost(int postID) async {
  List<Comment> results = [];

  String url =
      'https://theshedapi.herokuapp.com/api/v1/Comments/?post=${postID.toString()}';
  var response = await get(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': "Token " + token
  });
  if (response.statusCode != 200) {
    return [];
  }
  var data = json.decode(response.body);
  for (int i = 0; i < data.length; i++) {
    results.add(
      Comment(
        id: data[i]['id'],
        text: data[i]['text'],
        epochTime: convertTime(data[i]['timestamp']),
        postId: postID,
        username: data[i]['owner'],
        // username: 'UNDEFINED_USERNAME',
      ),
    );
  }
  results.sort((a, b) => -b.epochTime.compareTo(a.epochTime));
  return results;
}

/// returns all the posts the current user is interested in
Future<List<Post>> getUserFeed(String sortKey, String sortOrder) async {
  var data;
  List<int> groups;
  var temp;
  List<Post> results = [];

  String url = "https://theshedapi.herokuapp.com/api/v1/Users/?id=" + "$userId";
  var response = await get(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': "Token " + token
  });
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    //temp =
    groups = new List<int>.from(data[0]["groups"]);
    // groups = data[0]["groups"];
    temp = "https://theshedapi.herokuapp.com/api/v1/groups/";
    for (int i = 0; i < groups.length; i++) {
      var gid = groups[i];
      globalGroupsID.add(temp + "$gid" + '/');
    }

    temp = null;
  }

  for (int i = 0; i < groups.length; i++) {
    url = "https://theshedapi.herokuapp.com/api/v1/posts/?group=";
    temp = groups[i];
    url = url + "$temp";

    response = await get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Token " + token
      },
    );

    data = json.decode(response.body);

    for (int j = data.length - 1; j >= 0; j--) {
      // evaluating data[j]

      // String username = await getUsernameFromID(data[j]['owner_id']);
      globalGroups.add(data[j]["group_name"]);
      String locationName = await getLocationFromCoords(
          data[j]['latitude'], data[j]['longitude']);
      results.add(
        Post(
          longitude: data[j]['longitude'],
          latitude: data[j]['latitude'],
          text: data[j]['text'],
          epochTime: convertTime(data[j]['timestamp']),
          categories: ['Cat 1', 'Cat 2', 'Cat 3'],
          username: data[j]['owner'],
          locationname: locationName,
          groupname: data[j]['group_name'],
          id: data[j]['id'],
          userId: data[j]['owner_id'],
        ),
      );
    }
  }

  // sort
  int sortOrderNegator = sortOrder == 'Asc' ? 1 : -1;
  switch (sortKey) {
    case 'Time':
      results.sort(
          (a, b) => -sortOrderNegator * a.epochTime.compareTo(b.epochTime));
      break;
    case 'Location':
      results.sort((a, b) =>
          sortOrderNegator * a.locationname.compareTo(b.locationname));
      break;
    case 'User':
      results
          .sort((a, b) => sortOrderNegator * a.username.compareTo(b.username));
      break;
    case 'Category':
      results.sort((a, b) =>
          sortOrderNegator *
          a.categories.length.compareTo(b.categories.length));
      break;
    case 'Likes':
      break;
    default:
      break;
  }

  allFeed = results;
  //print(globalGroupsID);
  //print(globalGroups);
  return results;
}

Future<bool> updateProfile(String newUsr) async {
  String url = "https://theshedapi.herokuapp.com/api/v1/Users/";
  url = url + "$userId" + '/';
  var response = await patch(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': "Token " + token
    },
    body: JsonEncoder().convert(
      {
        "username": newUsr,
      },
    ),
  );

  if (response.statusCode != 200) {
    return false;
  }
  return true;
}

int convertTime(String time) {
  var parsedDate = DateTime.parse(time);
  int epoch = (parsedDate.toUtc().millisecondsSinceEpoch / 1000).round();
  return epoch;
}


Future makeGroup(String name, String desc, String tag) async {
  String url = "https://theshedapi.herokuapp.com/api/v1/groups/";
  var response = await post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': "Token " + token
    },
    body: JsonEncoder().convert({
      "name": name,
      "description": desc,
      "tag": tag
    }),
  );

  if (response.statusCode == 200) return true;
  else {
    return false;
  }
}


//TODO: Still in production!
Future joinGroup(String grp) async {
  //url = na group
  String url_prof = "https://theshedapi.herokuapp.com/api/v1/Users/$userId/";
  var temp = getGlobalGroups();
  var temp2 = getGlobalGroupsID();
  String group = temp2[temp.indexOf(grp)];


  //var response = await patch();
}