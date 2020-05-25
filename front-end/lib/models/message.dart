class Message {

  int id = 0;
  String text = 'MESSAGE_TEXT';
  int senderId = 0;
  int epochTime = 0;

  Message({int id, String text, int senderId, int epochTime}) {
    this.id = id;
    this.text = text;
    this.senderId = senderId;
    this.epochTime = epochTime;
  }
  
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

  String getListTimeStamp() {    
    // if same day & month & year (i.e. if today) return HH:mm
    if (this.isToday()) {
      return getHHMM();
    // if yesterday, say yesterday
    } else if (this.isYesterday()) {
      return 'Yesterday';
    // if same year at least, return DD/MM
    } else if (this.isThisYear()) {
      return getDDMM();
    // if past year, return DD/MM/YY
    } else {
      return getDDMMYY();
    }
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

  String getInChatTimeStamp() {   
    // if today
    if (this.isToday()) {
      return getHHMM();
    // if yesterday
    } else if (this.isYesterday()) {
      return getHHMM() + ' yesterday';
    // if this year
    } else if (this.isThisYear()) {
      return getHHMM() + '  ' + getDDMM();
    // else
    } else {
      return getHHMM() + '  ' + getDDMMYYYY();
    }
  }

  String getSenderName() => 'USERNAME';

}