// To parse this JSON data, do
//
//     final requestTypesDecoder = requestTypesDecoderFromJson(jsonString);

import 'dart:convert';

RequestTypesDecoder requestTypesDecoderFromJson(String str) => RequestTypesDecoder.fromJson(json.decode(str));

String requestTypesDecoderToJson(RequestTypesDecoder data) => json.encode(data.toJson());

class RequestTypesDecoder {
  List<RequestType> requestTypes;

  RequestTypesDecoder({
    required this.requestTypes,
  });

  factory RequestTypesDecoder.fromJson(Map<String, dynamic> json) => RequestTypesDecoder(
    requestTypes: List<RequestType>.from(json["request_types"].map((x) => RequestType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "request_types": List<dynamic>.from(requestTypes.map((x) => x.toJson())),
  };
}

class RequestType {
  int rtId;
  String name;

  RequestType({
    required this.rtId,
    required this.name,
  });

  factory RequestType.fromJson(Map<String, dynamic> json) => RequestType(
    rtId: json["rt_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "rt_id": rtId,
    "name": name,
  };
}
