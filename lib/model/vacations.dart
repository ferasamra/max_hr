// To parse this JSON data, do
//
//     final vacationDecoder = vacationDecoderFromJson(jsonString);

import 'dart:convert';

VacationDecoder vacationDecoderFromJson(String str) => VacationDecoder.fromJson(json.decode(str));

String vacationDecoderToJson(VacationDecoder data) => json.encode(data.toJson());

class VacationDecoder {
  List<Vacation> vacations;

  VacationDecoder({
    required this.vacations,
  });

  factory VacationDecoder.fromJson(Map<String, dynamic> json) => VacationDecoder(
    vacations: List<Vacation>.from(json["vacations"].map((x) => Vacation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "vacations": List<dynamic>.from(vacations.map((x) => x.toJson())),
  };
}

class Vacation {
  int vrId;
  int eId;
  int vtId;
  int isPaid;
  DateTime from;
  DateTime to;
  String note;
  String requestedAt;
  int isArchive;
  String vacation;
  int isPaidVacationType;
  String employee;
  int duration;
  String fromDate;
  String toDate;
  String fromTime;
  String toTime;
  List<LineManagere> lineManageres;
  List<Doc> docs;
  String systemNote;
  Paid paid;
  Unpaid unpaid;

  Vacation({
    required this.vrId,
    required this.eId,
    required this.vtId,
    required this.isPaid,
    required this.from,
    required this.to,
    required this.note,
    required this.requestedAt,
    required this.isArchive,
    required this.vacation,
    required this.isPaidVacationType,
    required this.employee,
    required this.duration,
    required this.fromDate,
    required this.toDate,
    required this.fromTime,
    required this.toTime,
    required this.lineManageres,
    required this.docs,
    required this.systemNote,
    required this.paid,
    required this.unpaid,
  });

  factory Vacation.fromJson(Map<String, dynamic> json) => Vacation(
    vrId: json["vr_id"],
    eId: json["e_id"],
    vtId: json["vt_id"],
    isPaid: json["is_paid"],
    from: DateTime.parse(json["_from"]),
    to: DateTime.parse(json["_to"]),
    note: json["note"],
    requestedAt: json["requested_at"],
    isArchive: json["is_archive"],
    vacation: json["vacation"],
    isPaidVacationType: json["is_paid_vacation_type"],
    employee: json["employee"],
    duration: json["duration"],
    fromDate: json["from_date"],
    toDate: json["to_date"],
    fromTime: json["from_time"],
    toTime: json["to_time"],
    lineManageres: List<LineManagere>.from(json["line_manageres"].map((x) => LineManagere.fromJson(x))),
    docs: List<Doc>.from(json["docs"].map((x) => Doc.fromJson(x))),
    systemNote: json["system_note"],
    paid: Paid.fromJson(json["paid"]),
    unpaid: Unpaid.fromJson(json["unpaid"]),
  );

  Map<String, dynamic> toJson() => {
    "vr_id": vrId,
    "e_id": eId,
    "vt_id": vtId,
    "is_paid": isPaid,
    "_from": from.toIso8601String(),
    "_to": to.toIso8601String(),
    "note": note,
    "requested_at": requestedAt,
    "is_archive": isArchive,
    "vacation": vacation,
    "is_paid_vacation_type": isPaidVacationType,
    "employee": employee,
    "duration": duration,
    "from_date": fromDate,
    "to_date": toDate,
    "from_time": fromTime,
    "to_time": toTime,
    "line_manageres": List<dynamic>.from(lineManageres.map((x) => x.toJson())),
    "docs": List<dynamic>.from(docs.map((x) => x.toJson())),
    "system_note": systemNote,
    "paid": paid.toJson(),
    "unpaid": unpaid.toJson(),
  };
}

class Doc {
  int vrdId;
  String typeName;
  String doc;
  int vrId;

  Doc({
    required this.vrdId,
    required this.typeName,
    required this.doc,
    required this.vrId,
  });

  factory Doc.fromJson(Map<String, dynamic> json) => Doc(
    vrdId: json["vrd_id"],
    typeName: json["type_name"],
    doc: json["doc"],
    vrId: json["vr_id"],
  );

  Map<String, dynamic> toJson() => {
    "vrd_id": vrdId,
    "type_name": typeName,
    "doc": doc,
    "vr_id": vrId,
  };
}


class LineManagere {
  int lmVrId;
  int state;
  String managerNote;
  int vrId;
  int lmId;
  String manager;
  String managerPosition;

  LineManagere({
    required this.lmVrId,
    required this.state,
    required this.managerNote,
    required this.vrId,
    required this.lmId,
    required this.manager,
    required this.managerPosition,
  });

  factory LineManagere.fromJson(Map<String, dynamic> json) => LineManagere(
    lmVrId: json["lm_vr_id"],
    state: json["state"],
    managerNote: json["note"]==null?"":json["note"],
    vrId: json["vr_id"],
    lmId: json["lm_id"],
    manager: json["manager"],
    managerPosition: json["manager_position"],
  );

  Map<String, dynamic> toJson() => {
    "lm_vr_id": lmVrId,
    "state": state,
    "note": managerNote,
    "vr_id": vrId,
    "lm_id": lmId,
    "manager": manager,
  };
}

class Paid {
  int days;
  int hours;
  String vacationYouHave;

  Paid({
    required this.days,
    required this.hours,
    required this.vacationYouHave,
  });

  factory Paid.fromJson(Map<String, dynamic> json) => Paid(
    days: json["days"],
    hours: json["hours"],
    vacationYouHave: json["vacationYouHave"]!,
  );

  Map<String, dynamic> toJson() => {
    "days": days,
    "hours": hours,
    "vacationYouHave": vacationYouHave,
  };
}

class Unpaid {
  String days;
  String hours;
  String vacationYouHave;

  Unpaid({
    required this.days,
    required this.hours,
    required this.vacationYouHave,
  });

  factory Unpaid.fromJson(Map<String, dynamic> json) => Unpaid(
    days: json["days"],
    hours: json["hours"],
    vacationYouHave: json["vacationYouHave"],
  );

  Map<String, dynamic> toJson() => {
    "days": days,
    "hours": hours,
    "vacationYouHave": vacationYouHave,
  };
}