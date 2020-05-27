import 'timeable.dart';

class Comment with Timeable {

  int id;
  int userId;
  int postId;
  String text;

  Comment({int id, int userId, int postId, String text, int epochTime}) {
    this.id = id ?? 0;
    this.userId = userId ?? 0;
    this.postId = postId ?? 0;
    this.text = text ?? 'TEXT';
    this.epochTime = epochTime ?? 0;
  }

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      userId: json['userId'],
      postId: json['postId'],
      text: json['text'],
      epochTime: json['epochtime'],
    );
  }

  String getInPostTimeStamp() {
    if (this.isToday()) return getHHMM();
    else if (this.isYesterday()) return getHHMM() + ' yesterday';
    else if (this.isThisYear()) return getHHMM() + ' ' + getDDMM();
    else return getHHMM() + ' ' + getDDMMYY();
  }

  String get username => 'USERNAME';

}