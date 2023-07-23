// To parse this JSON data, do
//
//     final latenessDecoder = latenessDecoderFromJson(jsonString);

import 'dart:convert';

LatenessDecoder latenessDecoderFromJson(String str) => LatenessDecoder.fromJson(json.decode(str));

String latenessDecoderToJson(LatenessDecoder data) => json.encode(data.toJson());

class LatenessDecoder {
  List<Lateness> lateness;

  LatenessDecoder({
    required this.lateness,
  });

  factory LatenessDecoder.fromJson(Map<String, dynamic> json) => LatenessDecoder(
    lateness: List<Lateness>.from(json["lateness"].map((x) => Lateness.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "lateness": List<dynamic>.from(lateness.map((x) => x.toJson())),
  };
}

class Lateness {
  int lId;
  DateTime date;
  int eId;
  int minutes;
  int amountOfDeduction;
  String formatedDate;

  Lateness({
    required this.lId,
    required this.date,
    required this.eId,
    required this.minutes,
    required this.amountOfDeduction,
    required this.formatedDate,
  });

  factory Lateness.fromJson(Map<String, dynamic> json) => Lateness(
    lId: json["l_id"],
    date: DateTime.parse(json["date"]),
    eId: json["e_id"],
    minutes: json["minutes"],
    amountOfDeduction: json["amount_of_deduction"],
    formatedDate: json["formated_date"],
  );

  Map<String, dynamic> toJson() => {
    "l_id": lId,
    "date": date.toIso8601String(),
    "e_id": eId,
    "minutes": minutes,
    "amount_of_deduction": amountOfDeduction,
    "formated_date": formatedDate,
  };
}
