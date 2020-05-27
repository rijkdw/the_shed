import 'timeable.dart';

class Post with Timeable {

  int id;
  String text;
  double latitude;
  double longitude;
  int userId;
  int groupId;
  var categories = <String>[];

  Post({int id, String text, int epochTime, double latitude, double longitude, int userId, int groupId, var categories}) {
    this.id = id ?? 0;
    this.text = text ?? 'TEXT';
    this.latitude = latitude ?? 0;
    this.longitude = longitude ?? 0;
    this.userId = userId ?? 0;
    this.groupId = groupId ?? 0;
    this.categories.addAll(categories);
    this.epochTime = epochTime ?? 0;
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      text: json['text'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      userId: json['userId'],
      groupId: json['groupId'],
      categories: json['categories'],
      epochTime: json['epochTime'],
    );
  }

  String get username => 'USERNAME';

  String get location => 'Stellenbosch, ZA';

  String get groupname => 'GROUPNAME';

  String get prettyCategories => this.categories.join('  |  ');

}