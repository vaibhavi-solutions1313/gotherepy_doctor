/// status : true
/// message : "Status Changed"
/// result : null

class SetAvailability {
  SetAvailability({
    this.status,
    this.message,
    this.result,
  });

  SetAvailability.fromJson(dynamic json)
      : status = json['status'],
        message = json['message'],
        result = json['result'];

  bool? status;
  String? message;
  dynamic result;

  SetAvailability copyWith({
    bool? status,
    String? message,
    dynamic result,
  }) =>
      SetAvailability(
        status: status ?? this.status,
        message: message ?? this.message,
        result: result ?? this.result,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['result'] = result;
    return map;
  }
}