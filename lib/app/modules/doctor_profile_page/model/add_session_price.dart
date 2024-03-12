import 'dart:convert';

AddSessionPriceModel addSessionPriceModelFromJson(String str) => AddSessionPriceModel.fromJson(json.decode(str));

String addSessionPriceModelToJson(AddSessionPriceModel data) => json.encode(data.toJson());

class AddSessionPriceModel {
  bool? status;
  String? msg;
  SessionPriceResults? results;

  AddSessionPriceModel({
     this.status,
     this.msg,
     this.results,
  });

  factory AddSessionPriceModel.fromJson(Map<String, dynamic> json) => AddSessionPriceModel(
    status: json["status"],
    msg: json["msg"],
    results: SessionPriceResults.fromJson(json["results"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "results": results?.toJson(),
  };
}

class SessionPriceResults {
  int? doctorId;
  String? sessionPrice;
  String? sessionCount;
  String? discountPercentage;
  String? sessionTime;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  SessionPriceResults({
     this.doctorId,
     this.sessionPrice,
     this.sessionCount,
     this.discountPercentage,
     this.sessionTime,
     this.updatedAt,
     this.createdAt,
     this.id,
  });

  factory SessionPriceResults.fromJson(Map<String, dynamic> json) => SessionPriceResults(
    doctorId: json["doctor_id"],
    sessionPrice: json["session_price"],
    sessionCount: json["session_count"],
    discountPercentage: json["discount_percentage"],
    sessionTime: json["session_time"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "doctor_id": doctorId,
    "session_price": sessionPrice,
    "session_count": sessionCount,
    "discount_percentage": discountPercentage,
    "session_time": sessionTime,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
  };
}