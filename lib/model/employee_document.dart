// To parse this JSON data, do
//
//     final employeeDocumentDecoder = employeeDocumentDecoderFromJson(jsonString);

import 'dart:convert';

EmployeeDocumentDecoder employeeDocumentDecoderFromJson(String str) => EmployeeDocumentDecoder.fromJson(json.decode(str));

String employeeDocumentDecoderToJson(EmployeeDocumentDecoder data) => json.encode(data.toJson());

class EmployeeDocumentDecoder {
  List<EmployeeDocument> employeeDocument;

  EmployeeDocumentDecoder({
    required this.employeeDocument,
  });

  factory EmployeeDocumentDecoder.fromJson(Map<String, dynamic> json) => EmployeeDocumentDecoder(
    employeeDocument: List<EmployeeDocument>.from(json["employee_document"].map((x) => EmployeeDocument.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "employee_document": List<dynamic>.from(employeeDocument.map((x) => x.toJson())),
  };
}

class EmployeeDocument {
  int roleDocId;
  int docId;
  int roleId;
  int isRequired;
  int documentCount;
  DateTime? expiredDate;
  String? document;
  int? deId;
  String name;
  int hasExpiredDate;

  EmployeeDocument({
    required this.roleDocId,
    required this.docId,
    required this.roleId,
    required this.isRequired,
    required this.documentCount,
    this.expiredDate,
    this.document,
    this.deId,
    required this.name,
    required this.hasExpiredDate,
  });

  factory EmployeeDocument.fromJson(Map<String, dynamic> json) => EmployeeDocument(
    roleDocId: json["role_doc_id"],
    docId: json["doc_id"],
    roleId: json["role_id"],
    isRequired: json["is_required"],
    documentCount: json["document_count"],
    expiredDate: json["expired_date"] == null ? null : DateTime.parse(json["expired_date"]),
    document: json["document"],
    deId: json["de_id"],
    name: json["name"],
    hasExpiredDate: json["has_expired_date"],
  );

  Map<String, dynamic> toJson() => {
    "role_doc_id": roleDocId,
    "doc_id": docId,
    "role_id": roleId,
    "is_required": isRequired,
    "document_count": documentCount,
    "expired_date": expiredDate?.toIso8601String(),
    "document": document,
    "de_id": deId,
    "name": name,
    "has_expired_date": hasExpiredDate,
  };
}
