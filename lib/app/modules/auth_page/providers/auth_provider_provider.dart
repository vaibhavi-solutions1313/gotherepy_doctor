import 'dart:convert';

import 'package:get/get.dart';
import 'package:gotherepy_doctor/app/app_services/local_storage.dart';
import 'package:http/http.dart'as http;

import '../../../app_constants/constants_end_points.dart';
class AuthProviderProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
  Future<http.StreamedResponse> loginUser({required String email, required String password, required String deviceToken}) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(EndPoints.baseUrl+EndPoints().login));
    request.body = json.encode({
      "email": email,
      "password": password
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
 return response;

  }
  Future<http.StreamedResponse> registerUser(Map data) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(EndPoints.baseUrl+EndPoints().register));
    request.body = json.encode({
      "email": data['email'],
      "phone": data['phone'],
      "password": data['password'],
      "confirm_password": data['confirm_password'],
      "doctor_type": data['doctor_type']
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    return response;

  }
  Future<http.StreamedResponse> verifyNumber(String mob)async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(EndPoints.baseUrl+EndPoints().sendOtp));
    request.body = json.encode({
      "mobile": mob
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    return response;
  }
  Future<http.StreamedResponse> getDoctorProfileInfo()async{
    var headers = {
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    var request = http.Request('GET', Uri.parse('${EndPoints.baseUrl}get-doctor-profile'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    return response;
  }
}
