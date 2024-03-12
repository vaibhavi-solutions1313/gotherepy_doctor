
class DoctorProfileInfo {
  bool? status;
  String? msg;
  Records? records;

  DoctorProfileInfo({this.status, this.msg, this.records});

  DoctorProfileInfo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    records = json['records'] != null ?  Records.fromJson(json['records']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['status'] = status;
    data['msg'] = msg;
    if (records != null) {
      data['records'] = records!.toJson();
    }
    return data;
  }
}

class Records {
  dynamic profileId;
  String? email;
  String? phone;
  dynamic username;
  dynamic doctorType;
  String? createdAt;
  String? updatedAt;
  int? doctorId;
  String? name;
  String? degree;
  String? title;
  dynamic exp;
  dynamic rate;
  String? idProof;
  String? about;
  String? gender;
  String? avatar;
  String? educationProof;
  String? doctorTypeName;
  dynamic counsellingId;
  dynamic icon;
  List<String>? specialization;
  List<Counseling>? counseling;

  Records(
      {this.profileId,
        this.email,
        this.phone,
        this.username,
        this.doctorType,
        this.createdAt,
        this.updatedAt,
        this.doctorId,
        this.name,
        this.degree,
        this.title,
        this.exp,
        this.rate,
        this.idProof,
        this.about,
        this.gender,
        this.avatar,
        this.educationProof,
        this.doctorTypeName,
        this.counsellingId,
        this.icon,
        this.specialization,
        this.counseling});

  Records.fromJson(Map<String, dynamic> json) {
    profileId = json['profile_id'];
    email = json['email'];
    phone = json['phone'];
    username = json['username'];
    doctorType = json['doctor_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    doctorId = json['doctor_id'];
    name = json['name'];
    degree = json['degree'];
    title = json['title'];
    exp = json['exp'];
    rate = json['rate'];
    idProof = json['id_proof'];
    about = json['about'];
    gender = json['gender'];
    avatar = json['avatar'];
    educationProof = json['education_proof'];
    doctorTypeName = json['doctor_type_name'];
    counsellingId = json['counselling_id'];
    icon = json['icon'];
    specialization = json['specialization'].cast<String>();
    if (json['counseling'] != null) {
      counseling = <Counseling>[];
      json['counseling'].forEach((v) {
        counseling!.add(new Counseling.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_id'] = this.profileId;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['username'] = this.username;
    data['doctor_type'] = this.doctorType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['doctor_id'] = this.doctorId;
    data['name'] = this.name;
    data['degree'] = this.degree;
    data['title'] = this.title;
    data['exp'] = this.exp;
    data['rate'] = this.rate;
    data['id_proof'] = this.idProof;
    data['about'] = this.about;
    data['gender'] = this.gender;
    data['avatar'] = this.avatar;
    data['education_proof'] = this.educationProof;
    data['doctor_type_name'] = this.doctorTypeName;
    data['counselling_id'] = this.counsellingId;
    data['icon'] = this.icon;
    data['specialization'] = this.specialization;
    if (this.counseling != null) {
      data['counseling'] = this.counseling!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Counseling {
  String? name;

  Counseling({this.name});

  Counseling.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
