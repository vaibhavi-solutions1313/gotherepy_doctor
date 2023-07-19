class DoctorProfileInfo {
  bool? status;
  String? msg;
  Records? records;

  DoctorProfileInfo({status, msg, records});

  DoctorProfileInfo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    records =
    json['records'] != null ?  Records.fromJson(json['records']) : null;
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
  List<DoctorProfile>? doctorProfile;
  List<dynamic>? counselling;

  Records({doctorProfile, counselling});

  Records.fromJson(Map<String, dynamic> json) {
    if (json['doctor_profile'] != null) {
      doctorProfile = <DoctorProfile>[];
      json['doctor_profile'].forEach((v) {
        doctorProfile!.add( DoctorProfile.fromJson(v));
      });
    }
    if (json['counselling'] != null) {
      counselling = <Null>[];
      json['counselling'].forEach((v) {
        counselling!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (doctorProfile != null) {
      data['doctor_profile'] =
          doctorProfile!.map((v) => v.toJson()).toList();
    }
    if (counselling != null) {
      data['counselling'] = counselling!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DoctorProfile {
  dynamic id;
  dynamic doctorId;
  dynamic name;
  dynamic degree;
  dynamic title;
  dynamic exp;
  dynamic rate;
  dynamic idProof;
  dynamic about;
  dynamic gender;
  dynamic avatar;
  dynamic educationProof;
  dynamic createdAt;
  dynamic updatedAt;
  String? email;
  String? phone;
  dynamic activation;

  DoctorProfile(
      {id,
        doctorId,
        name,
        degree,
        title,
        exp,
        rate,
        idProof,
        about,
        gender,
        avatar,
        educationProof,
        createdAt,
        updatedAt,
        email,
        phone,
        activation});

  DoctorProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    email = json['email'];
    phone = json['phone'];
    activation = json['activation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['doctor_id'] = doctorId;
    data['name'] = name;
    data['degree'] = degree;
    data['title'] = title;
    data['exp'] = exp;
    data['rate'] = rate;
    data['id_proof'] = idProof;
    data['about'] = about;
    data['gender'] = gender;
    data['avatar'] = avatar;
    data['education_proof'] = educationProof;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['email'] = email;
    data['phone'] = phone;
    data['activation'] = activation;
    return data;
  }
}
