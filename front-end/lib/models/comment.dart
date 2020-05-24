class Comment {

  int id = 0;
  int userId = 0;
  int postId = 0;
  String text = 'COMMENT_TEXT';
  int epochTime = 0;

  Comment({this.id, this.userId, this.postId, this.text, this.epochTime});

  bool isToday() {
    var nowDT = DateTime.now();
    int messageEpochMS = this.epochTime*1000;
    var msgDT = DateTime.fromMillisecondsSinceEpoch(messageEpochMS);

    return ((msgDT.day == nowDT.day) && (msgDT.month == nowDT.month) && (msgDT.year == nowDT.year));
  }

  bool isYesterday() {
    var nowDT = DateTime.now();
    int messageEpochMS = this.epochTime*1000;
    var msgDT = DateTime.fromMillisecondsSinceEpoch(messageEpochMS);

    return ((msgDT.day == nowDT.day-1) && (msgDT.month == nowDT.month) && (msgDT.year == nowDT.year));
  }
  
  bool isThisYear() {
    var nowDT = DateTime.now();
    int messageEpochMS = this.epochTime*1000;
    var msgDT = DateTime.fromMillisecondsSinceEpoch(messageEpochMS);

    return (nowDT.year == msgDT.year);
  }

  DateTime getDateTime() => DateTime.fromMillisecondsSinceEpoch(this.epochTime*1000);
  
  String getMinute() => this.getDateTime().minute.toString().padLeft(2, '0');

  String getHour() => this.getDateTime().hour.toString().padLeft(2, '0');

  String getDay() => this.getDateTime().day.toString().padLeft(2, '0');

  String getMonth() => this.getDateTime().month.toString().padLeft(2, '0');

  String getYear(bool short) => short
    ? this.getDateTime().year.toString().substring(2, 4)
    : this.getDateTime().year.toString();

  String getHHMM() => this.getHour() + ':' + this.getMinute();

  String getDDMM() => this.getDay() + '/' + this.getMonth();

  String getDDMMYY() => this.getDay() + '/' + this.getMonth() + '/' + this.getYear(true);

  String getDDMMYYYY() => this.getDay() + '/' + this.getMonth() + '/' + this.getYear(false);

  String getInPostTimeStamp() {
    if (this.isToday()) return getHHMM();
    else if (this.isYesterday()) return getHHMM() + ' yesterday';
    else if (this.isThisYear()) return getHHMM() + '  ' + getDDMM();
    else return getHHMM() + '  ' + getDDMMYY();
  }

  String getUsername() => 'USERNAME';

}