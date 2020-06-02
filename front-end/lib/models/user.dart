import 'package:flutter/foundation.dart';
import 'package:rw334/service/httpService.dart';

class User extends ChangeNotifier {
  String email;
  String username;
  String picture;
  String name;
  int posts; // number of posts
  int follow; // number of followers
  bool login; // logged in?
  String password;
  int id;
  List<int> groups;

  //final Map following;

  User(
      {int id,
      String email,
      String username,
      String name,
      String picture,
      int post,
      int follow,
      String password}) {
    this.email = email ?? 'example@example.com';
    this.username = username ?? 'username';
    this.picture = picture ?? 'assets/user1.jpeg';
    this.name = name ?? 'name';
    this.posts = post ?? 0;
    this.follow = follow ?? 0;
    this.login = true;
    this.password = password ?? '1234';
    this.id = userId ?? 0;
    this.groups = userGroups;
    //this.followers,
    //this.following
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        password: json["password"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };

  String getEmail() {
    return this.email;
  }

  String getUsername() {
    return this.username;
  }

  String getPicture() {
    return this.picture;
  }

  String getName() {
    return this.name;
  }

  String getFollowing() {
    int fol = this.follow;
    String follow = fol.toString() + " ";
    return follow;
  }

  @override
  String toString() =>
      'User:  email=\"$email\", username=\"$username\", name=\"$name\", password=\"$password\"';

  String getPost() {
    int post = this.posts;
    String posts = post.toString() + " ";
    return posts;
  }

  List<String> getGroups() {
    List<String> ls = [];
    List<int> str = userGroups;
    String url = "https://theshedapi.herokuapp.com/api/v1/groups/";
    for (int i = 0; i < str.length; i++) {
      int temp = str[i];
      ls.add(url + "$temp");
    }
    return ls;
  }

  // ignore: missing_return
  String logout() {
    this.login = false;
    print("user loged out, take me to sign up page. ples pappy");
    notifyListeners();
    return null;
  }

  bool update(String username, String psw) {
    bool fine = false;
    this.username = username;
    this.password = psw;
    print(psw + " " + username);
    /* if (database allows username)
    *   fine = true;
    */
    fine = true;
    notifyListeners();
    return fine;
  }

//Get info from DB
}
