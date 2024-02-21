/// messageType : "call"
/// callType : "voice"
/// callId : "123"
/// callerNumber : "+1234567890"
/// callerName : "John Doe"
/// callerPhoneNumber : "+1234567890"
/// selectedNotificationPayload : "payload"

class CallDataModel {
  CallDataModel({
    String? messageType,
    String? name,
    String? callType,
    String? callId,
    String? callerNumber,
    String? callerName,
    String? callerPhoneNumber,
    String? selectedNotificationPayload,
  }) {
    _messageType = messageType;
    _name = name;
    _callType = callType;
    _callId = callId;
    _callerNumber = callerNumber;
    _callerName = callerName;
    _callerPhoneNumber = callerPhoneNumber;
    _selectedNotificationPayload = selectedNotificationPayload;
  }

  CallDataModel.fromJson(dynamic json) {
    _messageType = json['messageType'];
    _name = json['name'];
    _callType = json['callType'];
    _callId = json['callId'];
    _callerNumber = json['callerNumber'];
    _callerName = json['callerName'];
    _callerPhoneNumber = json['callerPhoneNumber'];
    _selectedNotificationPayload = json['selectedNotificationPayload'];
  }

  String? _messageType;
  String? _name;
  String? _callType;
  String? _callId;
  String? _callerNumber;
  String? _callerName;
  String? _callerPhoneNumber;
  String? _selectedNotificationPayload;

  CallDataModel copyWith({
    String? messageType,
    String? name,
    String? callType,
    String? callId,
    String? callerNumber,
    String? callerName,
    String? callerPhoneNumber,
    String? selectedNotificationPayload,
  }) =>
      CallDataModel(
        messageType: messageType ?? _messageType,
        name: name ?? _name,
        callType: callType ?? _callType,
        callId: callId ?? _callId,
        callerNumber: callerNumber ?? _callerNumber,
        callerName: callerName ?? _callerName,
        callerPhoneNumber: callerPhoneNumber ?? _callerPhoneNumber,
        selectedNotificationPayload:
            selectedNotificationPayload ?? _selectedNotificationPayload,
      );

  String? get messageType => _messageType;

  String? get name => _name;

  String? get callType => _callType;

  String? get callId => _callId;

  String? get callerNumber => _callerNumber;

  String? get callerName => _callerName;

  String? get callerPhoneNumber => _callerPhoneNumber;

  String? get selectedNotificationPayload => _selectedNotificationPayload;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['messageType'] = _messageType;
    map['name'] = _name;
    map['callType'] = _callType;
    map['callId'] = _callId;
    map['callerNumber'] = _callerNumber;
    map['callerName'] = _callerName;
    map['callerPhoneNumber'] = _callerPhoneNumber;
    map['selectedNotificationPayload'] = _selectedNotificationPayload;
    return map;
  }
}
