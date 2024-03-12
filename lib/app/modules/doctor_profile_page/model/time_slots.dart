import 'dart:convert';

TimeSlots timeSlotsFromJson(String str) => TimeSlots.fromJson(json.decode(str));

String timeSlotsToJson(TimeSlots data) => json.encode(data.toJson());

class TimeSlots {
  bool? status;
  String? msg;
  List<Results>? results;

  TimeSlots({this.status, this.msg, this.results});

  TimeSlots.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? id;
  List<String>? times;
  String? day;

  Results({this.id, this.times, this.day});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    times = json['times'].cast<String>();
    day = json['day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['times'] = this.times;
    data['day'] = this.day;
    return data;
  }
}
