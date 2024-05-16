/// eventId : "664207f6040489e86238079e"
/// userId : "66308eff24f3be297421a427"
/// transectionId : "123123asdasdasdasd"
/// ticketQty : "60"
/// ticketPrice : "100"
/// ticketTotalPrice : "6000"

class TicketModel {
  TicketModel({
      this.eventId, 
      this.userId, 
      this.transectionId, 
      this.ticketQty, 
      this.ticketPrice, 
      this.ticketTotalPrice,});

  TicketModel.fromJson(dynamic json) {
    eventId = json['eventId'];
    userId = json['userId'];
    transectionId = json['transectionId'];
    ticketQty = json['ticketQty'];
    ticketPrice = json['ticketPrice'];
    ticketTotalPrice = json['ticketTotalPrice'];
  }
  String? eventId;
  String? userId;
  String? transectionId;
  String? ticketQty;
  String? ticketPrice;
  String? ticketTotalPrice;
TicketModel copyWith({  String? eventId,
  String? userId,
  String? transectionId,
  String? ticketQty,
  String? ticketPrice,
  String? ticketTotalPrice,
}) => TicketModel(  eventId: eventId ?? this.eventId,
  userId: userId ?? this.userId,
  transectionId: transectionId ?? this.transectionId,
  ticketQty: ticketQty ?? this.ticketQty,
  ticketPrice: ticketPrice ?? this.ticketPrice,
  ticketTotalPrice: ticketTotalPrice ?? this.ticketTotalPrice,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['eventId'] = eventId;
    map['userId'] = userId;
    map['transectionId'] = transectionId;
    map['ticketQty'] = ticketQty;
    map['ticketPrice'] = ticketPrice;
    map['ticketTotalPrice'] = ticketTotalPrice;
    return map;
  }

}