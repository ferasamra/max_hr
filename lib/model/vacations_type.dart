// To parse this JSON data, do
//
//     final vacationsDecoder = vacationsDecoderFromJson(jsonString);

import 'dart:convert';

VacationTypeDecoder vacationsDecoderFromJson(String str) => VacationTypeDecoder.fromJson(json.decode(str));

String vacationsDecoderToJson(VacationTypeDecoder data) => json.encode(data.toJson());

class VacationTypeDecoder {
  List<VacationType> vacations;

  VacationTypeDecoder({
    required this.vacations,
  });

  factory VacationTypeDecoder.fromJson(Map<String, dynamic> json) => VacationTypeDecoder(
    vacations: List<VacationType>.from(json["vacations"].map((x) => VacationType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "vacations": List<dynamic>.from(vacations.map((x) => x.toJson())),
  };
}

class VacationType {
  int vtId;
  String name;
  int isPaid;
  int frequentCount;
  int isFrequent;
  List<VacationDoc> vacationDocs;

  VacationType({
    required this.vtId,
    required this.name,
    required this.isPaid,
    required this.frequentCount,
    required this.isFrequent,
    required this.vacationDocs,
  });

  factory VacationType.fromJson(Map<String, dynamic> json) => VacationType(
    vtId: json["vt_id"],
    name: json["name"],
    isPaid: json["is_paid"],
    frequentCount: json["frequent_count"],
    isFrequent: json["is_frequent"],
    vacationDocs: List<VacationDoc>.from(json["vacation_docs"].map((x) => VacationDoc.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "vt_id": vtId,
    "name": name,
    "is_paid": isPaid,
    "frequent_count": frequentCount,
    "is_frequent": isFrequent,
    "vacation_docs": List<dynamic>.from(vacationDocs.map((x) => x.toJson())),
  };
}

class VacationDoc {
  int vtDocId;
  int docId;
  int vtId;
  int isRequired;
  String document;

  VacationDoc({
    required this.vtDocId,
    required this.docId,
    required this.vtId,
    required this.isRequired,
    required this.document,
  });

  factory VacationDoc.fromJson(Map<String, dynamic> json) => VacationDoc(
    vtDocId: json["vt_doc_id"],
    docId: json["doc_id"],
    vtId: json["vt_id"],
    isRequired: json["is_required"],
    document: json["document"],
  );

  Map<String, dynamic> toJson() => {
    "vt_doc_id": vtDocId,
    "doc_id": docId,
    "vt_id": vtId,
    "is_required": isRequired,
    "document": document,
  };
}
