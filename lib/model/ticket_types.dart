// To parse this JSON data, do
//
//     final ticketTypesDecoder = ticketTypesDecoderFromJson(jsonString);

import 'dart:convert';

TicketTypesDecoder ticketTypesDecoderFromJson(String str) => TicketTypesDecoder.fromJson(json.decode(str));

String ticketTypesDecoderToJson(TicketTypesDecoder data) => json.encode(data.toJson());

class TicketTypesDecoder {
  List<TicketType> ticketTypes;

  TicketTypesDecoder({
    required this.ticketTypes,
  });

  factory TicketTypesDecoder.fromJson(Map<String, dynamic> json) => TicketTypesDecoder(
    ticketTypes: List<TicketType>.from(json["ticket_types"].map((x) => TicketType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ticket_types": List<dynamic>.from(ticketTypes.map((x) => x.toJson())),
  };
}

class TicketType {
  int ttId;
  String name;

  TicketType({
    required this.ttId,
    required this.name,
  });

  factory TicketType.fromJson(Map<String, dynamic> json) => TicketType(
    ttId: json["tt_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "tt_id": ttId,
    "name": name,
  };
}
