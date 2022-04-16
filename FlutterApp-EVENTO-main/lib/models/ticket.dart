class Ticket {
  String? message;
  List<TicketData>? data;
  bool? isSuccess;

  Ticket({this.message, this.data, this.isSuccess});

  Ticket.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(TicketData.fromJson(v));
      });
    }
    isSuccess = json['isSuccess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    data['isSuccess'] = this.isSuccess;
    return data;
  }
}

class TicketData {
  int? user;
  int? eventId;
  int? partnerId;
  int? personalSkillId;
  int? ticketId;
  String? transId;
  String? ticketNo;
  String? paymentStatus;
  String? category;
  String? name;
  String? address;
  String? date;
  String? img;
  double? amount;
  String? roomName;
  String? receiver;
  String? holderName;
  String? holderContact;

  TicketData({
    this.user,
    this.eventId,
    this.partnerId,
    this.personalSkillId,
    this.ticketId,
    this.transId,
    this.ticketNo,
    this.paymentStatus,
    this.category,
    this.name,
    this.address,
    this.img,
    this.amount,
    this.date,
    this.holderContact,
    this.holderName,
    this.receiver,
    this.roomName,
  });

  TicketData.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    eventId = json['eventId'];
    partnerId = json['partnerId'];
    personalSkillId = json['personalSkillId'];
    ticketId = json['ticketId'];
    transId = json['trans_Id'];
    ticketNo = json['ticket_no'];
    paymentStatus = json['payment_status'];
    category = json['category'];
    name = json['name'];
    address = json['address'];
    date = json['date'];
    img = json['img'];
    amount = json['amount'];
    holderName = json['holdername'];
    holderContact = json['holdercontact'];
    roomName = json['roomname'];
    receiver = json['receiver'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['eventId'] = this.eventId;
    data['partnerId'] = this.partnerId;
    data['personalSkillId'] = this.personalSkillId;
    data['ticketId'] = this.ticketId;
    data['trans_Id'] = this.transId;
    data['ticket_no'] = this.ticketNo;
    data['payment_status'] = this.paymentStatus;
    data['category'] = this.category;
    data['name'] = this.name;
    data['address'] = this.address;
    data['date'] = this.date;
    data['img'] = this.img;
    data['amount'] = this.amount;
    data['holdername'] = this.holderName;
    data['holdercontact'] = this.holderContact;
    data['roomname'] = this.roomName;
    data['receiver'] = this.receiver;
    return data;
  }
}
