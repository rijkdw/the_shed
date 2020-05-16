class User {
  String email;
  String username;
  String picture;
  String name;
  int posts;
  int follow;
  //final Map followers;
  //final Map following;

  User(String email, String username, String name, String picture, int post,
      int follow) {
    this.email = email;
    this.username = username;
    this.picture = picture;
    this.name = name;
    this.posts = post;
    this.follow = follow;
    //this.followers,
    //this.following
  }

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

  String getPost() {
    int post = this.posts;
    String posts = post.toString() + " ";
    return posts;
  }

//Get info from DB
}
