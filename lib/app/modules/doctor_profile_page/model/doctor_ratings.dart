import 'dart:convert';

RatingsModel ratingsModelFromJson(String str) => RatingsModel.fromJson(json.decode(str));

String ratingsModelToJson(RatingsModel data) => json.encode(data.toJson());

class RatingsModel {
  bool? status;
  String? msg;
  List<RatingsResult>? results;

  RatingsModel({
    this.status,
    this.msg,
    this.results,
  });

  factory RatingsModel.fromJson(Map<String, dynamic> json) => RatingsModel(
    status: json["status"],
    msg: json["msg"],
    results: List<RatingsResult>.from(json["results"].map((x) => RatingsResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "results": List<dynamic>.from(results!. map((x) => x.toJson())),
  };
}

class RatingsResult {
  int? id;
  int? doctorId;
  int? userId;
  int? ratings;
  String? review;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? avatar;
  String? username;

  RatingsResult({
    this.id,
    this.doctorId,
    this.userId,
    this.ratings,
    this.review,
    this.createdAt,
    this.updatedAt,
    this.avatar,
    this.username,
  });

  factory RatingsResult.fromJson(Map<String, dynamic> json) => RatingsResult(
    id: json["id"],
    doctorId: json["doctor_id"],
    userId: json["user_id"],
    ratings: json["ratings"],
    review: json["review"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    avatar: json["avatar"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "doctor_id": doctorId,
    "user_id": userId,
    "ratings": ratings,
    "review": review,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "avatar": avatar,
    "username": username,
  };
}
