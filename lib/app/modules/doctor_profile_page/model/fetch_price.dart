// To parse this JSON data, do
//
//     final sessionChatPriceModel = sessionChatPriceModelFromJson(jsonString);

import 'dart:convert';

SessionChatPriceModel sessionChatPriceModelFromJson(String str) => SessionChatPriceModel.fromJson(json.decode(str));

String sessionChatPriceModelToJson(SessionChatPriceModel data) => json.encode(data.toJson());

class SessionChatPriceModel {
  bool? status;
  String? message;
  PriceResults? results;

  SessionChatPriceModel({
    this.status,
    this.message,
    this.results,
  });

  factory SessionChatPriceModel.fromJson(Map<String, dynamic> json) => SessionChatPriceModel(
    status: json["status"],
    message: json["message"],
    results: PriceResults.fromJson(json["results"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "results": results!.toJson(),
  };
}

class PriceResults {
  List<SessionPrice>? sessionPrices;
  List<ChatPrice>? chatPrices;

  PriceResults({
    this.sessionPrices,
    this.chatPrices,
  });

  factory PriceResults.fromJson(Map<String, dynamic> json) => PriceResults(
    sessionPrices: List<SessionPrice>.from(json["session_prices"].map((x) => SessionPrice.fromJson(x))),
    chatPrices: List<ChatPrice>.from(json["chat_prices"].map((x) => ChatPrice.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "session_prices": List<dynamic>.from(sessionPrices!.map((x) => x.toJson())),
    "chat_prices": List<dynamic>.from(chatPrices!.map((x) => x.toJson())),
  };
}

class ChatPrice {
  int? id;
  dynamic chatSessionPrice;
  int? sessionTime;
  String? type;

  ChatPrice({
    this.id,
    this.chatSessionPrice,
    this.sessionTime,
    this.type,
  });

  factory ChatPrice.fromJson(Map<String, dynamic> json) => ChatPrice(
    id: json["id"],
    chatSessionPrice: json["chat_session_price"],
    sessionTime: json["session_time"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "chat_session_price": chatSessionPrice,
    "session_time": sessionTime,
    "type": type,
  };
}

class SessionPrice {
  int? id;
  int? sessionPrice;
  int? sessionTime;
  int? sessionCount;
  Type? type;

  SessionPrice({
    this.id,
    this.sessionPrice,
    this.sessionTime,
    this.sessionCount,
    this.type,
  });

  factory SessionPrice.fromJson(Map<String, dynamic> json) => SessionPrice(
    id: json["id"],
    sessionPrice: json["session_price"],
    sessionTime: json["session_time"],
    sessionCount: json["session_count"],
    type: typeValues.map[json["type"]],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "session_price": sessionPrice,
    "session_time": sessionTime,
    "session_count": sessionCount,
    "type": typeValues.reverse[type],
  };
}

enum Type {
  SESSION_PRICE
}

final typeValues = EnumValues({
  "session_price": Type.SESSION_PRICE
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}