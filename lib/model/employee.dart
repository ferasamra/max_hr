// To parse this JSON data, do
//
//     final employeeDecoder = employeeDecoderFromJson(jsonString);

import 'dart:convert';

EmployeeDecoder employeeDecoderFromJson(String str) => EmployeeDecoder.fromJson(json.decode(str));

String employeeDecoderToJson(EmployeeDecoder data) => json.encode(data.toJson());

class EmployeeDecoder {
  Employee employee;

  EmployeeDecoder({
    required this.employee,
  });

  factory EmployeeDecoder.fromJson(Map<String, dynamic> json) => EmployeeDecoder(
    employee: Employee.fromJson(json["employee"]),
  );

  Map<String, dynamic> toJson() => {
    "employee": employee.toJson(),
  };
}

class Employee {
  int eId;
  String name;
  String email;
  String username;
  String password;
  int gradeId;
  int cId;
  int roleId;
  int isActive;
  int? duration;
  int isFlixable;
  String? inTime;
  String? outTime;
  int regionId;
  String nationality;
  DateTime? dateOfBirth;
  String passportNumber;
  String personalPhoneNumber;
  String countryOfResidence;
  String emirate;
  String homeAddress;
  String educationalLevel;
  String academicMajor;
  String emergencyNumbers;
  int? experienceYear;
  int? experienceYearRelated;
  DateTime? joiningDate;
  String officeName;
  String visaUnder;
  String businessEmail;
  String businessNumber;
  String internetAndCallPakage;
  double? salaryAsPerEmployeeContract;
  double? basicSalary;
  double? transpSalary;
  double? otherSalary;
  String modeOfPayment;
  String image;
  int hasVacations;
  String employeeState;
  List<Company> companies;
  List<Notification> notification;
  int absenceCount;
  int latnessCount;
  int latnessMinutes;
  double attendancePercentPerMonth;
  LastOperation? lastOperation;
  String token;

  Employee({
    required this.eId,
    required this.name,
    required this.email,
    required this.username,
    required this.password,
    required this.gradeId,
    required this.cId,
    required this.roleId,
    required this.isActive,
    required this.duration,
    required this.isFlixable,
    required this.inTime,
    required this.outTime,
    required this.regionId,
    required this.nationality,
    this.dateOfBirth,
    required this.passportNumber,
    required this.personalPhoneNumber,
    required this.countryOfResidence,
    required this.emirate,
    required this.homeAddress,
    required this.educationalLevel,
    required this.academicMajor,
    required this.emergencyNumbers,
    required this.experienceYear,
    required this.experienceYearRelated,
    required this.joiningDate,
    required this.officeName,
    required this.visaUnder,
    required this.businessEmail,
    required this.businessNumber,
    required this.internetAndCallPakage,
    required this.salaryAsPerEmployeeContract,
    required this.basicSalary,
    required this.transpSalary,
    required this.otherSalary,
    required this.modeOfPayment,
    required this.image,
    required this.hasVacations,
    required this.employeeState,
    required this.companies,
    required this.absenceCount,
    required this.latnessCount,
    required this.latnessMinutes,
    required this.attendancePercentPerMonth,
    required this.lastOperation,
    required this.token,
    required this.notification,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    eId: json["e_id"],
    name: json["name"],
    email: json["email"],
    username: json["username"],
    password: json["password"],
    gradeId: json["grade_id"],
    cId: json["c_id"],
    roleId: json["role_id"],
    isActive: json["is_active"],
    duration: json["duration"],
    isFlixable: json["is_flixable"],
    inTime: json["in_time"],
    outTime: json["out_time"],
    regionId: json["region_id"],
    nationality: json["nationality"],
    dateOfBirth: json["date_of_birth"]==null?null:DateTime.parse(json["date_of_birth"]),
    passportNumber: json["passport_number"],
    personalPhoneNumber: json["personal_phone_number"],
    countryOfResidence: json["country_of_residence"],
    emirate: json["emirate"],
    homeAddress: json["home_address"],
    educationalLevel: json["educational_level"],
    academicMajor: json["academic_major"],
    emergencyNumbers: json["emergency_numbers"],
    experienceYear: json["experience_year"],
    experienceYearRelated: json["experience_year_related"],
    joiningDate: json["joining_date"]==null?null:DateTime.parse(json["joining_date"]),
    officeName: json["office_name"],
    visaUnder: json["visa_under"],
    businessEmail: json["business_email"],
    businessNumber: json["business_number"],
    internetAndCallPakage: json["internet_and_call_pakage"],
    salaryAsPerEmployeeContract: json["salary_as_per_employee_contract"]==null?null:double.parse(json["salary_as_per_employee_contract"].toString()),
    basicSalary: json["basic_salary"]==null?null:double.parse(json["basic_salary"].toString()),
    transpSalary: json["transp_salary"]==null?null:double.parse(json["transp_salary"].toString()),
    otherSalary: json["other_salary"]==null?null:double.parse(json["other_salary"].toString()) ,
    modeOfPayment: json["mode_of_payment"],
    image: json["image"],
    hasVacations: json["has_vacations"],
    employeeState: json["employee_state"],
    companies: List<Company>.from(json["companies"].map((x) => Company.fromJson(x))),
    absenceCount: json["absence_count"],
    latnessCount: json["latness_count"],
    latnessMinutes: json["latness_minutes"],
    attendancePercentPerMonth: json["attendance_percent_per_month"]==null?0:double.parse(json["attendance_percent_per_month"].toString()) ,
    lastOperation: LastOperation.fromJson(json["last_operation"]),
    token: json["token"],
    notification: List<Notification>.from(json["notification"].map((x) => Notification.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "e_id": eId,
    "name": name,
    "email": email,
    "username": username,
    "password": password,
    "grade_id": gradeId,
    "c_id": cId,
    "role_id": roleId,
    "is_active": isActive,
    "duration": duration,
    "is_flixable": isFlixable,
    "in_time": inTime,
    "out_time": outTime,
    "region_id": regionId,
    "nationality": nationality,
    "date_of_birth": dateOfBirth!.toIso8601String(),
    "passport_number": passportNumber,
    "personal_phone_number": personalPhoneNumber,
    "country_of_residence": countryOfResidence,
    "emirate": emirate,
    "home_address": homeAddress,
    "educational_level": educationalLevel,
    "academic_major": academicMajor,
    "emergency_numbers": emergencyNumbers,
    "experience_year": experienceYear,
    "experience_year_related": experienceYearRelated,
    "joining_date": joiningDate!.toIso8601String(),
    "office_name": officeName,
    "visa_under": visaUnder,
    "business_email": businessEmail,
    "business_number": businessNumber,
    "internet_and_call_pakage": internetAndCallPakage,
    "salary_as_per_employee_contract": salaryAsPerEmployeeContract,
    "basic_salary": basicSalary,
    "transp_salary": transpSalary,
    "other_salary": otherSalary,
    "mode_of_payment": modeOfPayment,
    "image": image,
    "has_vacations": hasVacations,
    "employee_state": employeeState,
    "companies": List<dynamic>.from(companies.map((x) => x.toJson())),
    "notification": List<dynamic>.from(notification.map((x) => x.toJson())),
    "absence_count": absenceCount,
    "latness_count": latnessCount,
    "latness_minutes": latnessMinutes,
    "attendance_percent_per_month": attendancePercentPerMonth,
    "last_operation": lastOperation!.toJson(),
    "token": token,
  };
}

class Company {
  int ceId;
  int companyId;
  int eId;
  String company;

  Company({
    required this.ceId,
    required this.companyId,
    required this.eId,
    required this.company,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    ceId: json["ce_id"],
    companyId: json["company_id"],
    eId: json["e_id"],
    company: json["company"],
  );

  Map<String, dynamic> toJson() => {
    "ce_id": ceId,
    "company_id": companyId,
    "e_id": eId,
    "company": company,
  };
}

class LastOperation {
  int ioId;
  DateTime inDateTime;
  DateTime? outDateTime;
  int eId;
  String? inLocation;
  String? outLocation;
  String in_time;
  String? out_time;
  String in_date;
  String? out_date;

  LastOperation({
    required this.ioId,
    required this.inDateTime,
    required this.outDateTime,
    required this.eId,
    required this.inLocation,
    required this.outLocation,
    required this.in_date,
    required this.in_time,
    required this.out_date,
    required this.out_time,
  });

  factory LastOperation.fromJson(Map<String, dynamic> json) => LastOperation(
    ioId: json["io_id"],
    inDateTime: DateTime.parse(json["in_date_time"]),
    outDateTime: json["out_date_time"] == null?null:DateTime.parse(json["out_date_time"]),
    eId: json["e_id"],
    inLocation: json["in_location"],
    outLocation: json["out_location"],
    in_date: json["in_date"],
    in_time: json["in_time"],
    out_date: json["out_date"],
    out_time: json["out_time"],
  );

  Map<String, dynamic> toJson() => {
    "io_id": ioId,
    "in_date_time": inDateTime.toIso8601String(),
    "out_date_time": outDateTime!.toIso8601String(),
    "e_id": eId,
    "in_location": inLocation,
    "out_location": outLocation,
  };

}

class Notification {
  int notificationId;
  String title;
  String body;
  String? data;
  DateTime createdAt;
  int eId;
  int isRead;

  Notification({
    required this.notificationId,
    required this.title,
    required this.body,
    required this.data,
    required this.eId,
    required this.createdAt,
    required this.isRead,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    notificationId: json["notification_id"],
    title: json["title"],
    body: json["body"],
    data: json["data"],
    eId: json["e_id"],
    isRead: json["is_read"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "notification_id": notificationId,
    "title": title,
    "body": body,
    "data": data,
    "e_id": eId,
    "is_read": isRead,
    "created_at": createdAt.toIso8601String(),
  };
}