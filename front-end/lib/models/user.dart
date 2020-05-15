class User {
  String email;
  String username;
  String picture;

  //final Map followers;
  //final Map following;

  User(String email, String username, String picture) {
    this.email = email;
    this.username = username;
    this.picture = picture;
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
//Get info from DB
}
