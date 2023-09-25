// To parse this JSON data, do
//
//     final ticketsDecoder = ticketsDecoderFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

TicketsDecoder ticketsDecoderFromJson(String str) => TicketsDecoder.fromJson(json.decode(str));

String ticketsDecoderToJson(TicketsDecoder data) => json.encode(data.toJson());

class TicketsDecoder {
  List<Ticket> tickets;

  TicketsDecoder({
    required this.tickets,
  });

  factory TicketsDecoder.fromJson(Map<String, dynamic> json) => TicketsDecoder(
    tickets: List<Ticket>.from(json["tickets"].map((x) => Ticket.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "tickets": List<dynamic>.from(tickets.map((x) => x.toJson())),
  };
}

class Ticket {
  int ticketId;
  int eId;
  int ttId;
  String note;
  DateTime requestedAt;
  String status;
  int mentionTo;
  int isArchive;
  String ticketType;
  String employee;
  String mentionToEmployee;
  RxBool loading = false.obs;

  Ticket({
    required this.ticketId,
    required this.eId,
    required this.ttId,
    required this.note,
    required this.requestedAt,
    required this.status,
    required this.mentionTo,
    required this.isArchive,
    required this.ticketType,
    required this.employee,
    required this.mentionToEmployee,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
    ticketId: json["ticket_id"],
    eId: json["e_id"],
    ttId: json["tt_id"],
    note: json["note"],
    requestedAt: DateTime.parse(json["requested_at"]),
    status: json["status"],
    mentionTo: json["mention_to"],
    isArchive: json["is_archive"],
    ticketType: json["ticket_type"],
    employee: json["employee"],
    mentionToEmployee: json["mention_to_employee"],
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
    "employee": employee,
    "mention_to_employee": mentionToEmployee,
  };
}
