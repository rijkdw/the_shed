class Post {

  int id = 0;
  String text = 'TEXT';
  int countryId = 0;
  int userId = 0;
  int groupId = 0;
  var categories = <String>[];

  Post({int id, String text, int countryId, int userId, int groupId, var categories}) {
    this.id = id;
    this.text = text;
    this.countryId = countryId;
    this.userId = userId;
    this.groupId = groupId;
    this.categories.addAll(categories);
  }

  String getUserName() => 'USERNAME';

  String getCountryName() => 'COUNTRY';

  String getGroupName() => 'GROUPNAME';

  String getPrettyCategories() => this.categories.join('  |  ');

}