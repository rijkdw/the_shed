import 'package:rw334/models/timeable.dart';

class Group with Timeable {

  String name, description, tag;
  int id, creatorID;

  Group({this.name, this.description, this.tag, this.id, this.creatorID, int epochTime}) {
    this.epochTime = epochTime;
  }

  String get timeCreated {
    if (this.isToday()) return '${this.getHHMM()}, today';
    if (this.isYesterday()) return '${this.getHHMM()}, yesterday';
    if (this.isThisYear()) return '${this.getHHMM()}, ${this.getDDMM()}';
    return '${this.getHHMM()}, ${this.getDDMMYY()}';
  }

}