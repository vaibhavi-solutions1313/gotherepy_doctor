import 'dart:convert';

EditChatPrice editChatPriceFromJson(String str) => EditChatPrice.fromJson(json.decode(str));

String editSessionPriceToJson(EditChatPrice data) => json.encode(data.toJson());

class EditChatPrice {
  bool? status;
  String? msg;
  EditChatPriceResult? results;

  EditChatPrice({
     this.status,
     this.msg,
     this.results,
  });

  factory EditChatPrice.fromJson(Map<String, dynamic> json) {
    return EditChatPrice(
      status: json['status'],
      msg: json['msg'],
      results: EditChatPriceResult.fromJson(json['results']),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "results": results?.toJson(),
  };

}

class EditChatPriceResult {
  int? id;
  int? doctorId;
  String? sessionCount;
  String? sessionPrice;
  String? discountPercentage;
  String? sessionTime;
  DateTime? createdAt;
  DateTime? updatedAt;

  EditChatPriceResult({
     this.id,
     this.doctorId,
     this.sessionCount,
     this.sessionPrice,
     this.discountPercentage,
     this.sessionTime,
     this.createdAt,
     this.updatedAt,
  });

  factory EditChatPriceResult.fromJson(Map<String, dynamic> json) {
    return EditChatPriceResult(
      doctorId: json['doctorId'],
      sessionPrice: json['sessionPrice'],
      sessionCount: json['sessionCount'],
      discountPercentage: json['discountPercentage'],
      sessionTime: json['sessionTime'],
      updatedAt: DateTime.parse(json['updatedAt']),
      createdAt: DateTime.parse(json['createdAt']),
      id: json['id'],
    );
  }

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
