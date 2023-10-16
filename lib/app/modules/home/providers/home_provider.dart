import 'dart:convert';

import 'package:get/get.dart';
import 'package:gotherepy_doctor/app/app_constants/constants_end_points.dart';
import 'package:http/http.dart'as http;

import '../model/user_appointment_model.dart';
class HomeProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
  Future<UsersAppointmentsModel>fetchAppointmentById({required String doctorId})async{
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    var request = http.Request('GET', Uri.parse('http://gotherapy.care/backend/public/api/doctor/get-appointment-list'));
    request.body = json.encode({
      "doctor_id": doctorId
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    UsersAppointmentsModel appointmentsModel=UsersAppointmentsModel();
    if (response.statusCode == 200) {
      var data=jsonDecode(await response.stream.bytesToString());
      return appointmentsModel=UsersAppointmentsModel.fromJson(data);
    }
    else {
      print(response.reasonPhrase);
      return appointmentsModel;
    }

  }
}
