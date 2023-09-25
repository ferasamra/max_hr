// To parse this JSON data, do
//
//     final ticketsDetailsDecoder = ticketsDetailsDecoderFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

TicketsDetailsDecoder ticketsDetailsDecoderFromJson(String str) => TicketsDetailsDecoder.fromJson(json.decode(str));

String ticketsDetailsDecoderToJson(TicketsDetailsDecoder data) => json.encode(data.toJson());

class TicketsDetailsDecoder {
  List<TicketReplay> ticketReplay;
  TicketDetails ticketDetails;

  TicketsDetailsDecoder({
    required this.ticketReplay,
    required this.ticketDetails,
  });

  factory TicketsDetailsDecoder.fromJson(Map<String, dynamic> json) => TicketsDetailsDecoder(
    ticketReplay: List<TicketReplay>.from(json["ticket_replay"].map((x) => TicketReplay.fromJson(x))),
    ticketDetails: TicketDetails.fromJson(json["ticket_details"]),
  );

  Map<String, dynamic> toJson() => {
    "ticket_replay": List<dynamic>.from(ticketReplay.map((x) => x.toJson())),
    "ticket_details": ticketDetails.toJson(),
  };
}

class TicketDetails {
  int ticketId;
  int eId;
  int ttId;
  String note;
  DateTime requestedAt;
  String status;
  int mentionTo;
  int isArchive;
  String ticketType;

  TicketDetails({
    required this.ticketId,
    required this.eId,
    required this.ttId,
    required this.note,
    required this.requestedAt,
    required this.status,
    required this.mentionTo,
    required this.isArchive,
    required this.ticketType,
  });

  factory TicketDetails.fromJson(Map<String, dynamic> json) => TicketDetails(
    ticketId: json["ticket_id"],
    eId: json["e_id"],
    ttId: json["tt_id"],
    note: json["note"],
    requestedAt: DateTime.parse(json["requested_at"]),
    status: json["status"],
    mentionTo: json["mention_to"],
    isArchive: json["is_archive"],
    ticketType: json["ticket_type"],
  );

  Map<String, dynamic> toJson() => {
    "ticket_id": ticketId,
    "e_id": eId,
    "tt_id": ttId,
    "note": note,
    "requested_at": requestedAt.toIso8601String(),
    "status": status,
    "mention_to": mentionTo,
    "is_archive": isArchive,
    "ticket_type": ticketType,
  };
}

class TicketReplay {
  int trId;
  int fromEId;
  int toEId;
  int ticketId;
  String msg;
  DateTime createdAt;
  String toEmployee;
  String fromEmployee;
  String toEmployeeImage;
  String fromEmployeeImage;
  RxBool isSent = true.obs;

  TicketReplay({
    required this.trId,
    required this.fromEId,
    required this.toEId,
    required this.ticketId,
    required this.msg,
    required this.createdAt,
    required this.toEmployee,
    required this.fromEmployee,
    required this.toEmployeeImage,
    required this.fromEmployeeImage,
  });

  factory TicketReplay.fromJson(Map<String, dynamic> json) => TicketReplay(
    trId: json["tr_id"],
    fromEId: json["from_e_id"],
    toEId: json["to_e_id"],
    ticketId: json["ticket_id"],
    msg: json["msg"],
    createdAt: DateTime.parse(json["created_at"]),
    toEmployee: json["to_employee"],
    fromEmployee: json["from_employee"],
    toEmployeeImage: json["to_employee_image"],
    fromEmployeeImage: json["from_employee_image"],
  );

  Map<String, dynamic> toJson() => {
    "tr_id": trId,
    "from_e_id": fromEId,
    "to_e_id": toEId,
    "ticket_id": ticketId,
    "msg": msg,
    "created_at": createdAt.toIso8601String(),
    "to_employee": toEmployee,
    "from_employee": fromEmployee,
    "to_employee_image": toEmployeeImage,
    "from_employee_image": fromEmployeeImage,
  };
}
