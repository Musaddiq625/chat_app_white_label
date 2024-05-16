/// code : 200
/// message : "Operation successful"
/// description : ""
/// data : {"_id":"664466e91d98d12f648b045f","eventId":"664207f6040489e86238079e","userId":"66308eff24f3be297421a427","transectionId":"123123asdasdasdasd","ticketQty":60,"ticketPrice":100,"ticketTotalPrice":6000,"dateTime":"2024-05-15T07:40:25.392Z","created_at":"2024-05-15T07:40:25.392Z","updated_at":"2024-05-15T07:40:25.392Z","__v":0}
/// meta : null

class TicketModelWrapper {
  TicketModelWrapper({
      this.code, 
      this.message, 
      this.description, 
      this.ticket,
      this.meta,});

  TicketModelWrapper.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    description = json['description'];
    ticket = json['data'] != null ? Ticket.fromJson(json['data']) : null;
    meta = json['meta'];
  }
  num? code;
  String? message;
  String? description;
  Ticket? ticket;
  dynamic meta;
TicketModelWrapper copyWith({  num? code,
  String? message,
  String? description,
  Ticket? ticket,
  dynamic meta,
}) => TicketModelWrapper(  code: code ?? this.code,
  message: message ?? this.message,
  description: description ?? this.description,
  ticket: ticket ?? this.ticket,
  meta: meta ?? this.meta,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['message'] = message;
    map['description'] = description;
    if (ticket != null) {
      map['data'] = ticket?.toJson();
    }
    map['meta'] = meta;
    return map;
  }

}

/// _id : "664466e91d98d12f648b045f"
/// eventId : "664207f6040489e86238079e"
/// userId : "66308eff24f3be297421a427"
/// transectionId : "123123asdasdasdasd"
/// ticketQty : 60
/// ticketPrice : 100
/// ticketTotalPrice : 6000
/// dateTime : "2024-05-15T07:40:25.392Z"
/// created_at : "2024-05-15T07:40:25.392Z"
/// updated_at : "2024-05-15T07:40:25.392Z"
/// __v : 0

class Ticket {
  Ticket({
      this.id, 
      this.eventId, 
      this.userId, 
      this.transectionId, 
      this.ticketQty, 
      this.ticketPrice, 
      this.ticketTotalPrice, 
      this.dateTime, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  Ticket.fromJson(dynamic json) {
    id = json['_id'];
    eventId = json['eventId'];
    userId = json['userId'];
    transectionId = json['transectionId'];
    ticketQty = json['ticketQty'];
    ticketPrice = json['ticketPrice'];
    ticketTotalPrice = json['ticketTotalPrice'];
    dateTime = json['dateTime'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    v = json['__v'];
  }
  String? id;
  String? eventId;
  String? userId;
  String? transectionId;
  num? ticketQty;
  num? ticketPrice;
  num? ticketTotalPrice;
  String? dateTime;
  String? createdAt;
  String? updatedAt;
  num? v;
Ticket copyWith({  String? id,
  String? eventId,
  String? userId,
  String? transectionId,
  num? ticketQty,
  num? ticketPrice,
  num? ticketTotalPrice,
  String? dateTime,
  String? createdAt,
  String? updatedAt,
  num? v,
}) => Ticket(  id: id ?? this.id,
  eventId: eventId ?? this.eventId,
  userId: userId ?? this.userId,
  transectionId: transectionId ?? this.transectionId,
  ticketQty: ticketQty ?? this.ticketQty,
  ticketPrice: ticketPrice ?? this.ticketPrice,
  ticketTotalPrice: ticketTotalPrice ?? this.ticketTotalPrice,
  dateTime: dateTime ?? this.dateTime,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
  v: v ?? this.v,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['eventId'] = eventId;
    map['userId'] = userId;
    map['transectionId'] = transectionId;
    map['ticketQty'] = ticketQty;
    map['ticketPrice'] = ticketPrice;
    map['ticketTotalPrice'] = ticketTotalPrice;
    map['dateTime'] = dateTime;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}