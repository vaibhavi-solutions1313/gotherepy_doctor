class FetchPriceById {
  bool? status;
  String? message;
  PriceDetailResult? results;

  FetchPriceById({
     this.status,
     this.message,
     this.results,
  });

  factory FetchPriceById.fromJson(Map<String, dynamic> json) {
    return FetchPriceById(
      status: json['status'],
      message: json['message'],
      results: PriceDetailResult.fromJson(json['results']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.results != null) {
      data['results'] = this.results!.toJson();
    }
    return data;
  }

}

class PriceDetailResult {
  int? id;
  int? doctorId;
  int? sessionCount;
  int? sessionPrice;
  String? discountPercentage;
  int? sessionTime;
  DateTime? createdAt;
  DateTime? updatedAt;

  PriceDetailResult({
     this.id,
     this.doctorId,
     this.sessionCount,
     this.sessionPrice,
     this.discountPercentage,
     this.sessionTime,
     this.createdAt,
     this.updatedAt,
  });

  factory PriceDetailResult.fromJson(Map<String, dynamic> json) {
    return PriceDetailResult(
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['doctor_id'] = this.doctorId;
    data['session_price'] = this.sessionPrice;
    data['session_count'] = this.sessionCount;
    data['discount_percentage'] = this.discountPercentage;
    data['session_time'] = this.sessionTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

}
