class User {
  final String email;
  final String username;
  final String picture;
  final Map followers;
  final Map following;

  const User(
      {
        this.email,
        this.username,
        this.picture,
        this.followers,
        this.following
  }
);
  //Get info from DB
}