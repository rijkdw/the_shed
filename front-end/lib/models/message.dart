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
  
  bool isThisYear() {
    var nowDT = DateTime.now();
    int messageEpochMS = this.epochTime*1000;
    var msgDT = DateTime.fromMillisecondsSinceEpoch(messageEpochMS);

    return (nowDT.year == msgDT.year);
  }

  String getListTimeStamp() {
    int messageEpochMS = this.epochTime*1000;
    var msgDT = DateTime.fromMillisecondsSinceEpoch(messageEpochMS);
    
    // if same day, month, year, i.e. if today:
    if (this.isToday()) {
      return msgDT.hour.toString() + ':' + msgDT.minute.toString();
    } else if (this.isThisYear()) {
      return msgDT.day.toString() + '/' + msgDT.month.toString();
    } else {
      return msgDT.day.toString() + '/' + msgDT.month.toString() + '/' + msgDT.year.toString().substring(2,4);
    }
  }
  
  String getTimeStamp() {
    int messageEpochMS = this.epochTime*1000;
    var msgDT = DateTime.fromMillisecondsSinceEpoch(messageEpochMS);
    
    // if same day, month, year, i.e. if today:
    if (this.isToday()) {
      return msgDT.hour.toString() + ':' + msgDT.minute.toString();
    } else {
      return msgDT.hour.toString() + ':' + msgDT.minute.toString() + ', ' + msgDT.day.toString() + '/' + msgDT.month.toString() + '/' + msgDT.year.toString();
    }
  }

  String getSenderName() => 'USERNAME';

}