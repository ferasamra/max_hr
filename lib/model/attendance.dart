// To parse this JSON data, do
//
//     final attendanceDecoder = attendanceDecoderFromJson(jsonString);

import 'dart:convert';

AttendanceDecoder attendanceDecoderFromJson(String str) => AttendanceDecoder.fromJson(json.decode(str));

String attendanceDecoderToJson(AttendanceDecoder data) => json.encode(data.toJson());

class AttendanceDecoder {
  List<Attendance> attendance;

  AttendanceDecoder({
    required this.attendance,
  });

  factory AttendanceDecoder.fromJson(Map<String, dynamic> json) => AttendanceDecoder(
    attendance: List<Attendance>.from(json["attendance"].map((x) => Attendance.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "attendance": List<dynamic>.from(attendance.map((x) => x.toJson())),
  };
}

class Attendance {
  DateTime dayDate;
  String dayName;
  Data data;

  Attendance({
    required this.dayDate,
    required this.dayName,
    required this.data,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
    dayDate: DateTime.parse(json["dayDate"]),
    dayName: json["dayName"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "dayDate": "${dayDate.year.toString().padLeft(4, '0')}-${dayDate.month.toString().padLeft(2, '0')}-${dayDate.day.toString().padLeft(2, '0')}",
    "dayName": dayName,
    "data": data.toJson(),
  };
}

class Data {
  int? ioId;
  DateTime? inDateTime;
  DateTime? outDateTime;
  int? eId;
  String? inLocation;
  String? outLocation;
  int? durationAllDay;
  String employee;
  int employeeDuration;
  String date;
  List<Detail> details;
  List<Holiday> holiday;
  List<OvertimeAttenadance> overtime;
  List<Absence> absence;
  List<LatenessAttenadance> lateness;
  List<AttendanceVacation> vacations;
  int countOfAllData;

  Data({
    this.ioId,
    this.inDateTime,
    this.outDateTime,
    this.eId,
    this.inLocation,
    this.outLocation,
    this.durationAllDay,
    required this.employee,
    required this.employeeDuration,
    required this.date,
    required this.details,
    required this.holiday,
    required this.overtime,
    required this.absence,
    required this.lateness,
    required this.vacations,
    required this.countOfAllData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    ioId: json["io_id"],
    inDateTime: json["in_date_time"] == null ? null : DateTime.parse(json["in_date_time"]),
    outDateTime: json["out_date_time"] == null ? null : DateTime.parse(json["out_date_time"]),
    eId: json["e_id"],
    inLocation: json["in_location"],
    outLocation: json["out_location"],
    durationAllDay: json["duration_all_day"],
    employee: json["employee"],
    employeeDuration: json["employee_duration"],
    date: json["date"],
    details: List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
    holiday: List<Holiday>.from(json["holiday"].map((x) => Holiday.fromJson(x))),
    overtime: List<OvertimeAttenadance>.from(json["overtime"].map((x) => OvertimeAttenadance.fromJson(x))),
    absence: List<Absence>.from(json["absence"].map((x) => Absence.fromJson(x))),
    lateness: List<LatenessAttenadance>.from(json["lateness"].map((x) => LatenessAttenadance.fromJson(x))),
    vacations: List<AttendanceVacation>.from(json["vacations"].map((x) => AttendanceVacation.fromJson(x))),
    countOfAllData: json["count_of_all_data"],
  );

  Map<String, dynamic> toJson() => {
    "io_id": ioId,
    "in_date_time": inDateTime?.toIso8601String(),
    "out_date_time": outDateTime?.toIso8601String(),
    "e_id": eId,
    "in_location": inLocation,
    "out_location": outLocation,
    "duration_all_day": durationAllDay,
    "employee": employee,
    "employee_duration": employeeDuration,
    "date": date,
    "details": List<dynamic>.from(details.map((x) => x.toJson())),
    "holiday": List<dynamic>.from(holiday.map((x) => x.toJson())),
    "overtime": List<dynamic>.from(overtime.map((x) => x.toJson())),
    "absence": List<dynamic>.from(absence.map((x) => x.toJson())),
    "lateness": List<dynamic>.from(lateness.map((x) => x.toJson())),
    "vacations": List<dynamic>.from(vacations.map((x) => x.toJson())),
    "count_of_all_data": countOfAllData,
  };
}

class Absence {
  int aId;
  int eId;
  DateTime date;

  Absence({
    required this.aId,
    required this.eId,
    required this.date,
  });

  factory Absence.fromJson(Map<String, dynamic> json) => Absence(
    aId: json["a_id"],
    eId: json["e_id"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "a_id": aId,
    "e_id": eId,
    "date": date.toIso8601String(),
  };
}

class Detail {
  int ioId;
  int? duration;
  int eId;
  String inTime;
  String? outTime;
  String inDate;
  String? outDate;
  String inForCopy;
  String? outForCopy;

  Detail({
    required this.ioId,
    required this.duration,
    required this.eId,
    required this.inTime,
    required this.outTime,
    required this.inDate,
    required this.outDate,
    required this.inForCopy,
    required this.outForCopy,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    ioId: json["io_id"],
    duration: json["duration"],
    eId: json["e_id"],
    inTime: json["in_time"],
    outTime: json["out_time"],
    inDate: json["in_date"],
    outDate: json["out_date"],
    inForCopy: json["in_for_copy"],
    outForCopy: json["out_for_copy"],
  );

  Map<String, dynamic> toJson() => {
    "io_id": ioId,
    "duration": duration,
    "e_id": eId,
    "in_time": inTime,
    "out_time": outTime,
    "in_date": inDate,
    "out_date": outDate,
    "in_for_copy": inForCopy,
    "out_for_copy": outForCopy,
  };
}

class Holiday {
  int hId;
  String name;
  DateTime date;

  Holiday({
    required this.hId,
    required this.name,
    required this.date,
  });

  factory Holiday.fromJson(Map<String, dynamic> json) => Holiday(
    hId: json["h_id"],
    name: json["name"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "h_id": hId,
    "name": name,
    "date": date.toIso8601String(),
  };
}

class LatenessAttenadance {
  int lId;
  DateTime date;
  int eId;
  int minutes;
  int amountOfDeduction;

  LatenessAttenadance({
    required this.lId,
    required this.date,
    required this.eId,
    required this.minutes,
    required this.amountOfDeduction,
  });

  factory LatenessAttenadance.fromJson(Map<String, dynamic> json) => LatenessAttenadance(
    lId: json["l_id"],
    date: DateTime.parse(json["date"]),
    eId: json["e_id"],
    minutes: json["minutes"],
    amountOfDeduction: json["amount_of_deduction"],
  );

  Map<String, dynamic> toJson() => {
    "l_id": lId,
    "date": date.toIso8601String(),
    "e_id": eId,
    "minutes": minutes,
    "amount_of_deduction": amountOfDeduction,
  };
}

class OvertimeAttenadance {
  int eId;
  int duration;
  String fromDate;
  String toDate;
  String employee;
  int otId;
  String from;
  String to;
  String date;
  String note;

  OvertimeAttenadance({
    required this.eId,
    required this.duration,
    required this.fromDate,
    required this.toDate,
    required this.employee,
    required this.otId,
    required this.from,
    required this.to,
    required this.date,
    required this.note,
  });

  factory OvertimeAttenadance.fromJson(Map<String, dynamic> json) => OvertimeAttenadance(
    eId: json["e_id"],
    duration: json["duration"],
    fromDate: json["from_date"],
    toDate: json["to_date"],
    employee: json["employee"],
    otId: json["ot_id"],
    from: json["_from"],
    to: json["_to"],
    date: json["date"],
    note: json["note"],
  );

  Map<String, dynamic> toJson() => {
    "e_id": eId,
    "duration": duration,
    "from_date": fromDate,
    "to_date": toDate,
    "employee": employee,
    "ot_id": otId,
    "_from": from,
    "_to": to,
    "date": date,
    "note": note,
  };
}

class AttendanceVacation {
  String vacationType;
  int eId;
  String employee;
  int vrId;
  String from;
  String to;
  DateTime date;
  String note;

  AttendanceVacation({
    required this.vacationType,
    required this.eId,
    required this.employee,
    required this.vrId,
    required this.from,
    required this.to,
    required this.date,
    required this.note,
  });

  factory AttendanceVacation.fromJson(Map<String, dynamic> json) => AttendanceVacation(
    vacationType: json["vacation_type"],
    eId: json["e_id"],
    employee: json["employee"],
    vrId: json["vr_id"],
    from: json["_from"],
    to: json["_to"],
    date: DateTime.parse(json["date"]),
    note: json["note"],
  );

  Map<String, dynamic> toJson() => {
    "vacation_type": vacationType,
    "e_id": eId,
    "employee": employee,
    "vr_id": vrId,
    "_from": from,
    "_to": to,
    "date": date.toIso8601String(),
    "note": note,
  };
}
