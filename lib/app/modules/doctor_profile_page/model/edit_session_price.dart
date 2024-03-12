import 'dart:convert';

EditSessionPrice editSessionPriceFromJson(String str) => EditSessionPrice.fromJson(json.decode(str));

String editSessionPriceToJson(EditSessionPrice data) => json.encode(data.toJson());

class EditSessionPrice {
  bool? status;
  String? msg;
  EditSessionPriceResults? results;

  EditSessionPrice({
    this.status,
    this.msg,
    this.results,
  });

  factory EditSessionPrice.fromJson(Map<String, dynamic> json) => EditSessionPrice(
    status: json["status"],
    msg: json["msg"],
    results: EditSessionPriceResults.fromJson(json["results"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "results": results?.toJson(),
  };
}

class EditSessionPriceResults {
  int? id;
  int? doctorId;
  String? sessionCount;
  String? sessionPrice;
  String? discountPercentage;
  String? sessionTime;
  DateTime? createdAt;
  DateTime? updatedAt;

  EditSessionPriceResults({
    this.id,
    this.doctorId,
    this.sessionCount,
    this.sessionPrice,
    this.discountPercentage,
    this.sessionTime,
    this.createdAt,
    this.updatedAt,
  });

  factory EditSessionPriceResults.fromJson(Map<String, dynamic> json) => EditSessionPriceResults(
    id: json["id"],
    doctorId: json["doctor_id"],
    sessionCount: json["session_count"],
    sessionPrice: json["session_price"],
    discountPercentage: json["discount_percentage"],
    sessionTime: json["session_time"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "doctor_id": doctorId,
    "session_count": sessionCount,
    "session_price": sessionPrice,
    "discount_percentage": discountPercentage,
    "session_time": sessionTime,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
