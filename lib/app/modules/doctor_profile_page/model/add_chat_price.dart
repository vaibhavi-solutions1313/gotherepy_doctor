import 'dart:convert';

AddChatPriceModel addChatPriceModelFromJson(String str) => AddChatPriceModel.fromJson(json.decode(str));

String addChatPriceModelToJson(AddChatPriceModel data) => json.encode(data.toJson());

class AddChatPriceModel {
  bool? status;
  String? msg;
  ChatPriceResults? results;

  AddChatPriceModel({
    this.status,
    this.msg,
    this.results,
  });

  factory AddChatPriceModel.fromJson(Map<String, dynamic> json) => AddChatPriceModel(
    status: json["status"],
    msg: json["msg"],
    results: ChatPriceResults.fromJson(json["results"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "results": results?.toJson(),
  };
}

class ChatPriceResults {
  int? doctorId;
  String? sessionPrice;
  String? sessionCount;
  String? discountPercentage;
  String? sessionTime;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  ChatPriceResults({
    this.doctorId,
    this.sessionPrice,
    this.sessionCount,
    this.discountPercentage,
    this.sessionTime,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory ChatPriceResults.fromJson(Map<String, dynamic> json) => ChatPriceResults(
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
