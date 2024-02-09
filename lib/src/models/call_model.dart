/// id : "923323333333_1707226935287"
/// type : "call"
/// caller_number : "+923323333333"
/// receiver_number : "+921122334455"
/// duration : "0:8"
/// time : "1707226936003"
/// end_time : "1707226948105"
/// is_call_active : false
/// users : ["+923323333333","+921122334455"]

class CallModel {
  CallModel({
      String? id, 
      String? type, 
      String? callerNumber, 
      String? receiverNumber, 
      String? duration, 
      String? time, 
      String? endTime, 
      bool? isCallActive, 
      List<String>? users,}){
    _id = id;
    _type = type;
    _callerNumber = callerNumber;
    _receiverNumber = receiverNumber;
    _duration = duration;
    _time = time;
    _endTime = endTime;
    _isCallActive = isCallActive;
    _users = users;
}

  CallModel.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _callerNumber = json['caller_number'];
    _receiverNumber = json['receiver_number'];
    _duration = json['duration'];
    _time = json['time'];
    _endTime = json['end_time'];
    _isCallActive = json['is_call_active'];
    _users = json['users'] != null ? json['users'].cast<String>() : [];
  }
  String? _id;
  String? _type;
  String? _callerNumber;
  String? _receiverNumber;
  String? _duration;
  String? _time;
  String? _endTime;
  bool? _isCallActive;
  List<String>? _users;
CallModel copyWith({  String? id,
  String? type,
  String? callerNumber,
  String? receiverNumber,
  String? duration,
  String? time,
  String? endTime,
  bool? isCallActive,
  List<String>? users,
}) => CallModel(  id: id ?? _id,
  type: type ?? _type,
  callerNumber: callerNumber ?? _callerNumber,
  receiverNumber: receiverNumber ?? _receiverNumber,
  duration: duration ?? _duration,
  time: time ?? _time,
  endTime: endTime ?? _endTime,
  isCallActive: isCallActive ?? _isCallActive,
  users: users ?? _users,
);
  String? get id => _id;
  String? get type => _type;
  String? get callerNumber => _callerNumber;
  String? get receiverNumber => _receiverNumber;
  String? get duration => _duration;
  String? get time => _time;
  String? get endTime => _endTime;
  bool? get isCallActive => _isCallActive;
  List<String>? get users => _users;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['caller_number'] = _callerNumber;
    map['receiver_number'] = _receiverNumber;
    map['duration'] = _duration;
    map['time'] = _time;
    map['end_time'] = _endTime;
    map['is_call_active'] = _isCallActive;
    map['users'] = _users;
    return map;
  }

}