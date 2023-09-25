// To parse this JSON data, do
//
//     final myRequests = myRequestsFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';
import 'package:max_hr/model/tickets.dart';
import 'package:max_hr/model/vacations_type.dart';

MyRequests myRequestsFromJson(String str) => MyRequests.fromJson(json.decode(str));

String myRequestsToJson(MyRequests data) => json.encode(data.toJson());
class EmployeeRequestsDecoder {

  List<EmployeeRequest> requests;

  EmployeeRequestsDecoder({
    required this.requests,
  });

  factory EmployeeRequestsDecoder.fromJson(Map<String, dynamic> json) => EmployeeRequestsDecoder(
    requests: List<EmployeeRequest>.from(json["requests"].map((x) => EmployeeRequest.fromJson(x))),
  );

}
class MyRequests {
  List<VacationRequest> vacations;
  List<OvertimeRequest> overtimes;
  List<EmployeeRequest> requests;
  List<Ticket> tickets;

  MyRequests({
    required this.vacations,
    required this.overtimes,
    required this.requests,
    required this.tickets,
  });

  factory MyRequests.fromJson(Map<String, dynamic> json) => MyRequests(
    vacations: List<VacationRequest>.from(json["vacations"].map((x) => VacationRequest.fromJson(x))),
    overtimes: List<OvertimeRequest>.from(json["overtimes"].map((x) => OvertimeRequest.fromJson(x))),
    requests: List<EmployeeRequest>.from(json["requests"].map((x) => EmployeeRequest.fromJson(x))),
    tickets: List<Ticket>.from(json["tickets"].map((x) => Ticket.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "vacations": List<dynamic>.from(vacations.map((x) => x.toJson())),
    "overtimes": List<dynamic>.from(overtimes.map((x) => x.toJson())),
  };
}

class OvertimeRequest {
  int eId;
  String employee;
  int otId;
  String from;
  String from_date;
  String to_date;
  String to;
  DateTime date;
  String note;
  RxBool loading = false.obs;
  List<OvertimeLineManagere> lineManageres;

  OvertimeRequest({
    required this.eId,
    required this.employee,
    required this.otId,
    required this.from,
    required this.to,
    required this.date,
    required this.note,
    required this.lineManageres,
    required this.from_date,
    required this.to_date,
  });

  factory OvertimeRequest.fromJson(Map<String, dynamic> json) => OvertimeRequest(
    eId: json["e_id"],
    employee: json["employee"],
    otId: json["ot_id"],
    from: json["_from"],
    to: json["_to"],
    from_date: json["from_date"],
    to_date: json["to_date"],
    date: DateTime.parse(json["date"]),
    note: json["note"],
    lineManageres: List<OvertimeLineManagere>.from(json["line_manageres"].map((x) => OvertimeLineManagere.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "e_id": eId,
    "employee": employee,
    "ot_id": otId,
    "_from": from,
    "_to": to,
    "date": date.toIso8601String(),
    "note": note,
    "line_manageres": List<dynamic>.from(lineManageres.map((x) => x.toJson())),
  };
}

class OvertimeLineManagere {
  int lmOtId;
  int lmId;
  int state;
  int otId;
  dynamic managerNote;
  String manager;
  String managerPosition;


  OvertimeLineManagere({
    required this.lmOtId,
    required this.lmId,
    required this.state,
    required this.otId,
    this.managerNote,
    required this.manager,
    required this.managerPosition,
  });

  factory OvertimeLineManagere.fromJson(Map<String, dynamic> json) => OvertimeLineManagere(
    lmOtId: json["lm_ot_id"],
    lmId: json["lm_id"],
    state: json["state"],
    otId: json["ot_id"],
    managerNote: json["manager_note"],
    manager: json["manager"],
    managerPosition: json["manager_position"],
  );

  Map<String, dynamic> toJson() => {
    "lm_ot_id": lmOtId,
    "lm_id": lmId,
    "state": state,
    "ot_id": otId,
    "manager_note": managerNote,
    "manager": manager,
    "manager_position": managerPosition,
  };
}

class VacationRequest {
  int eId;
  int vtId;
  String vacationType;
  int isPaid;
  String employee;
  int vrId;
  String from;
  String to;
  DateTime date;
  String note;
  List<VacationLineManagere> lineManageres;
  List<RequestVacationDoc> docs;
  String systemNote;
  Paid paid;
  Unpaid unpaid;
  RxBool loading = false.obs;

  VacationRequest({
    required this.eId,
    required this.vtId,
    required this.vacationType,
    required this.isPaid,
    required this.employee,
    required this.vrId,
    required this.from,
    required this.to,
    required this.date,
    required this.note,
    required this.lineManageres,
    required this.docs,
    required this.systemNote,
    required this.paid,
    required this.unpaid,
  });

  factory VacationRequest.fromJson(Map<String, dynamic> json) => VacationRequest(
    eId: json["e_id"],
    vtId: json["vt_id"],
    vacationType: json["vacation_type"],
    isPaid: json["is_paid"],
    employee: json["employee"],
    vrId: json["vr_id"],
    from: json["_from"],
    to: json["_to"],
    date: DateTime.parse(json["date"]),
    note: json["note"],
    lineManageres: List<VacationLineManagere>.from(json["line_manageres"].map((x) => VacationLineManagere.fromJson(x))),
    docs: List<RequestVacationDoc>.from(json["docs"].map((x) => RequestVacationDoc.fromJson(x))),
    systemNote: json["system_note"],
    paid: Paid.fromJson(json["paid"]),
    unpaid: Unpaid.fromJson(json["unpaid"]),
  );

  Map<String, dynamic> toJson() => {
    "e_id": eId,
    "vt_id": vtId,
    "vacation_type": vacationType,
    "is_paid": isPaid,
    "employee": employee,
    "vr_id": vrId,
    "_from": from,
    "_to": to,
    "date": date.toIso8601String(),
    "note": note,
    "line_manageres": List<dynamic>.from(lineManageres.map((x) => x.toJson())),
    "docs": List<dynamic>.from(docs.map((x) => x)),
    "system_note": systemNote,
    "paid": paid.toJson(),
    "unpaid": unpaid.toJson(),
  };
}

class VacationLineManagere {
  int lmVrId;
  int state;
  dynamic note;
  int vrId;
  int lmId;
  String manager;
  String managerPosition;

  VacationLineManagere({
    required this.lmVrId,
    required this.state,
    this.note,
    required this.vrId,
    required this.lmId,
    required this.manager,
    required this.managerPosition,
  });

  factory VacationLineManagere.fromJson(Map<String, dynamic> json) => VacationLineManagere(
    lmVrId: json["lm_vr_id"],
    state: json["state"],
    note: json["note"],
    vrId: json["vr_id"],
    lmId: json["lm_id"],
    manager: json["manager"],
    managerPosition: json["manager_position"],
  );

  Map<String, dynamic> toJson() => {
    "lm_vr_id": lmVrId,
    "state": state,
    "note": note,
    "vr_id": vrId,
    "lm_id": lmId,
    "manager": manager,
    "manager_position": managerPosition,
  };
}

class Paid {
  String days;
  String hours;
  String vacationYouHave;

  Paid({
    required this.days,
    required this.hours,
    required this.vacationYouHave,
  });

  factory Paid.fromJson(Map<String, dynamic> json) => Paid(
    days: json["days"].toString(),
    hours: json["hours"].toString(),
    vacationYouHave: json["vacationYouHave"],
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
    days: json["days"].toString(),
    hours: json["hours"].toString(),
    vacationYouHave: json["vacationYouHave"],
  );

  Map<String, dynamic> toJson() => {
    "days": days,
    "hours": hours,
    "vacationYouHave": vacationYouHave,
  };
}

class RequestVacationDoc{
  int vrd_id;
  int vr_id;
  String type_name;
  String doc;

  RequestVacationDoc({
    required this.vrd_id,
    required this.vr_id,
    required this.type_name,
    required this.doc,
  });

  factory RequestVacationDoc.fromJson(Map<String, dynamic> json) => RequestVacationDoc(
    vrd_id: json["vrd_id"],
    vr_id: json["vr_id"],
    type_name: json["type_name"],
    doc: json["doc"],
  );

  Map<String, dynamic> toJson() => {
    "vrd_id": vrd_id,
    "vr_id": vr_id,
    "type_name": type_name,
    "doc": doc,
  };

}

class EmployeeRequest {
  int e_id;
  String employee;
  String request_type;
  int requests_id;
  DateTime requested_at;
  String note;
  RxBool loading = false.obs;
  List<EmployeeRequestLineManagere> lineManageres;

  EmployeeRequest({
    required this.e_id,
    required this.employee,
    required this.note,
    required this.lineManageres,
    required this.request_type,
    required this.requested_at,
    required this.requests_id,
  });

  factory EmployeeRequest.fromJson(Map<String, dynamic> json) => EmployeeRequest(
    e_id: json["e_id"],
    employee: json["employee"],
    request_type: json["request_type"],
    requests_id: json["requests_id"],
    requested_at: DateTime.parse(json["requested_at"]),
    note: json["note"]==null?"":json["note"],
    lineManageres: List<EmployeeRequestLineManagere>.from(json["line_manageres"].map((x) => EmployeeRequestLineManagere.fromJson(x))),
  );

}

class EmployeeRequestLineManagere {
  int lm_r_id;
  int lmId;
  int state;
  int requests_id;
  dynamic managerNote;
  String manager;
  String managerPosition;


  EmployeeRequestLineManagere({
    required this.lm_r_id,
    required this.lmId,
    required this.state,
    required this.requests_id,
    this.managerNote,
    required this.manager,
    required this.managerPosition,
  });

  factory EmployeeRequestLineManagere.fromJson(Map<String, dynamic> json) => EmployeeRequestLineManagere(
    lm_r_id: json["lm_r_id"],
    lmId: json["lm_id"],
    state: json["state"],
    requests_id: json["requests_id"],
    managerNote: json["manager_note"],
    manager: json["manager"],
    managerPosition: json["manager_position"],
  );

}
