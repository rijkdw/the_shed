import 'timeable.dart';

class Post with Timeable {

  int id;
  String text;
  double latitude;
  double longitude;
  String locationname;
  int userId;
  String username; // for display purposes only
  int groupId;
  String groupname; // for display purposes only
  var categories = <String>[];

  Post({int id, String text, int epochTime, double latitude, double longitude, String locationname, int userId, String username, int groupId, String groupname, var categories}) {
    this.id = id ?? 0;
    this.text = text ?? 'TEXT';
    this.latitude = latitude ?? 0;
    this.longitude = longitude ?? 0;
    this.locationname = locationname ?? 'LOCATION';
    this.userId = userId ?? 0;
    this.groupId = groupId ?? 0;
    this.categories.addAll(categories);
    this.epochTime = epochTime ?? 0;
    this.groupname = groupname ?? 'GROUP_NAME';
    this.username = username ?? 'USER_NAME';
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

  String get prettyCategories => this.categories.join('  |  ');

  String getInFeedTimestamp() {
    // if today
    if (this.isToday()) {
      return getHHMM();
    // if yesterday
    } else if (this.isYesterday()) {
      return getHHMM() + ' yesterday';
    // if this year
    } else if (this.isThisYear()) {
      return getHHMM() + ' ' + getDDMM();
    // else
    } else {
      return getHHMM() + ' ' + getDDMMYYYY();
    }
  }

  String getInPostPageTimestamp() {
    // if today
    if (this.isToday()) {
      return getHHMM() + ' today';
    // if yesterday
    } else if (this.isYesterday()) {
      return getHHMM() + ' yesterday';
    // if this year
    } else if (this.isThisYear()) {
      return getHHMM() + ' ' + getDDMM();
    // else
    } else {
      return getHHMM() + ' ' + getDDMMYYYY();
    }
  }

}