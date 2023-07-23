// To parse this JSON data, do
//
//     final overtimeDecoder = overtimeDecoderFromJson(jsonString);

import 'dart:convert';

OvertimeDecoder overtimeDecoderFromJson(String str) => OvertimeDecoder.fromJson(json.decode(str));

String overtimeDecoderToJson(OvertimeDecoder data) => json.encode(data.toJson());

class OvertimeDecoder {
  List<OverTime> overTime;

  OvertimeDecoder({
    required this.overTime,
  });

  factory OvertimeDecoder.fromJson(Map<String, dynamic> json) => OvertimeDecoder(
    overTime: List<OverTime>.from(json["overTime"].map((x) => OverTime.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "overTime": List<dynamic>.from(overTime.map((x) => x.toJson())),
  };
}

class OverTime {
  int otId;
  DateTime from;
  DateTime to;
  DateTime date;
  int eId;
  String note;
  int isArchive;
  int allRequestedMinutes;
  int allRequestedCount;
  String employee;
  List<Detail> details;
  int allMinutes;
  Approved approved;

  OverTime({
    required this.otId,
    required this.from,
    required this.to,
    required this.date,
    required this.eId,
    required this.note,
    required this.isArchive,
    required this.allRequestedMinutes,
    required this.allRequestedCount,
    required this.employee,
    required this.details,
    required this.allMinutes,
    required this.approved,
  });

  factory OverTime.fromJson(Map<String, dynamic> json) => OverTime(
    otId: json["ot_id"],
    from: DateTime.parse(json["_from"]),
    to: DateTime.parse(json["_to"]),
    date: DateTime.parse(json["date"]),
    eId: json["e_id"],
    note: json["note"],
    isArchive: json["is_archive"],
    allRequestedMinutes: json["all_requested_minutes"],
    allRequestedCount: json["all_requested_count"],
    employee: json["employee"],
    details: List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
    allMinutes: json["all_minutes"],
    approved: Approved.fromJson(json["approved"]),
  );

  Map<String, dynamic> toJson() => {
    "ot_id": otId,
    "_from": from.toIso8601String(),
    "_to": to.toIso8601String(),
    "date": date.toIso8601String(),
    "e_id": eId,
    "note": note,
    "is_archive": isArchive,
    "all_requested_minutes": allRequestedMinutes,
    "all_requested_count": allRequestedCount,
    "employee": employee,
    "details": List<dynamic>.from(details.map((x) => x.toJson())),
    "all_minutes": allMinutes,
    "approved": approved.toJson(),
  };
}

class Approved {
  int allRequestedMinutes;
  int allRequestedCount;

  Approved({
    required this.allRequestedMinutes,
    required this.allRequestedCount,
  });

  factory Approved.fromJson(Map<String, dynamic> json) => Approved(
    allRequestedMinutes: json["all_requested_minutes"],
    allRequestedCount: json["all_requested_count"],
  );

  Map<String, dynamic> toJson() => {
    "all_requested_minutes": allRequestedMinutes,
    "all_requested_count": allRequestedCount,
  };
}

class Detail {
  int otId;
  DateTime from;
  DateTime to;
  DateTime date;
  int eId;
  String note;
  int isArchive;
  String employee;
  int duration;
  String fromDate;
  String toDate;
  String fromTime;
  String toTime;
  List<LineManagere> lineManageres;

  Detail({
    required this.otId,
    required this.from,
    required this.to,
    required this.date,
    required this.eId,
    required this.note,
    required this.isArchive,
    required this.employee,
    required this.duration,
    required this.fromDate,
    required this.toDate,
    required this.fromTime,
    required this.toTime,
    required this.lineManageres,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    otId: json["ot_id"],
    from: DateTime.parse(json["_from"]),
    to: DateTime.parse(json["_to"]),
    date: DateTime.parse(json["date"]),
    eId: json["e_id"],
    note: json["note"],
    isArchive: json["is_archive"],
    employee: json["employee"],
    duration: json["duration"],
    fromDate: json["from_date"],
    toDate: json["to_date"],
    fromTime: json["from_time"],
    toTime: json["to_time"],
    lineManageres: List<LineManagere>.from(json["line_manageres"].map((x) => LineManagere.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ot_id": otId,
    "_from": from.toIso8601String(),
    "_to": to.toIso8601String(),
    "date": date.toIso8601String(),
    "e_id": eId,
    "note": note,
    "is_archive": isArchive,
    "employee": employee,
    "duration": duration,
    "from_date": fromDate,
    "to_date": toDate,
    "from_time": fromTime,
    "to_time": toTime,
    "line_manageres": List<dynamic>.from(lineManageres.map((x) => x.toJson())),
  };
}

class LineManagere {
  int lmOtId;
  int lmId;
  int state;
  int otId;
  String managerNote;
  String manager;
  String managerPosition;

  LineManagere({
    required this.lmOtId,
    required this.lmId,
    required this.state,
    required this.otId,
    required this.managerNote,
    required this.manager,
    required this.managerPosition,
  });

  factory LineManagere.fromJson(Map<String, dynamic> json) => LineManagere(
    lmOtId: json["lm_ot_id"],
    lmId: json["lm_id"],
    state: json["state"],
    otId: json["ot_id"],
    managerNote: json["manager_note"],
    manager: json["manager"],
    managerPosition: json["manager_position"]==null?"NaN":json["manager_position"],
  );

  Map<String, dynamic> toJson() => {
    "lm_ot_id": lmOtId,
    "lm_id": lmId,
    "state": state,
    "ot_id": otId,
    "manager_note": managerNote,
    "manager": manager,
  };
}
