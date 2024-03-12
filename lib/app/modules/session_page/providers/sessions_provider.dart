import 'dart:convert';

import 'package:get/get.dart';
import 'package:gotherepy_doctor/app/app_constants/constants_end_points.dart';
import 'package:gotherepy_doctor/app/modules/home/model/session_appointment_model.dart';
import 'package:http/http.dart' as http;

class SessionsProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'http://gotherapy.care/public/api/doctor';
  }

  Future<void> acceptAppointment(
      {required String appointmentId, required String type}) async {
    var headers = {'Authorization': 'Bearer ${EndPoints.accessToken}'};
    var request = http.MultipartRequest('POST', Uri.parse('http://gotherapy.care/public/api/doctor/approve-booking'));
    request.fields.addAll({
      'appointment_id': appointmentId,
      'booking_type': type
    });

    request.headers.addAll(headers);
    try {
      // Send the request and get the response
      http.Response response = await http.Response.fromStream(await request.send());

      // Handle the response
      if (response.statusCode == 200) {
        String responseBody = response.body;
        print("-------Approved Pending Session: ${responseBody}--------");
        print(responseBody);
        // Handle the response as needed
      } else {
        print("Failed to approve appointment: ${response.reasonPhrase}");
        // Handle the error
      }
    } catch (error) {
      print("Error during request: $error");
      // Handle the error
    }
    // http.StreamedResponse response = await request.send();
    // String responseBody = await response.stream.bytesToString();
    // print(responseBody);
    // print("-------Approved Pending Session: ${responseBody}--------");
    // if (response.statusCode == 200) {
    //   print(await response.stream.bytesToString());
    // }
    // else {
    //   print(response.reasonPhrase);
    // }
  }

  Future<void> cancelAppointment(
      {required String appointmentId, required String cancelBy, required String reason}) async {
    var headers = {'Authorization': 'Bearer ${EndPoints.accessToken}'};
    var request = http.MultipartRequest('POST', Uri.parse('http://gotherapy.care/public/api/user/cancel-appointment'));
    request.fields.addAll({
      'appointment_id': appointmentId,
      'cancel_by': cancelBy,
      'reason': reason
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    print(responseBody);
    print("-------Delete Pending Session: ${responseBody}--------");

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  /*Future<SessionPendingAppointmentModel?> fetchPendingSessionAppointment()async{
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vZ290aGVyYXB5LmNhcmUvYmFja2VuZC9wdWJsaWMvYXBpL2RvY3Rvci9sb2dpbiIsImlhdCI6MTcwNjA4NzQ0NiwiZXhwIjoxNzA2NjkyMjQ2LCJuYmYiOjE3MDYwODc0NDYsImp0aSI6Imo3SjdqSW1yc1R2d2tIbFoiLCJzdWIiOiIxMyIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.LGDKWdBySikOZbeVzkaLC098RIEQwCwNxBOHK7inW24'
    };
    var request = http.Request('GET', Uri.parse('http://gotherapy.care/public/api/user/get-pending-appointment-list'));
    request.body = json.encode({
      "doctor_id": "13"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }

  }*/

  Future<SessionPendingAppointmentModel?> fetchPendingSessionAppointment({
    required String doctorId}) async{
    var headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    var request = http.Request('GET', Uri.parse('http://gotherapy.care/public/api/user/get-pending-appointment-list'));
    request.body = json.encode({
      "doctor_id": doctorId,
    });

    /*var request = http.Request('GET', Uri.parse('http://gotherapy.care/backend/public/api/user/get-pending-appointment-list'));
    request.body = json.encode({
      "doctor_id": doctorId,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print('fetching data....');
    print(request.body);*/

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    print(responseBody);

    if(response.statusCode == 200){
      SessionPendingAppointmentModel? _model = sessionPendingAppointmentModelFromJson(responseBody);
      return _model;
      // return SessionPendingAppointmentModel.fromJson(jsonDecode(await response.stream.bytesToString()));
    } else{
      print(response.reasonPhrase);
      // return SessionPendingAppointmentModel();
    }
  }
  Future<http.StreamedResponse> submitReport(
      {required String appointmentId,
      required String reportText,
      required List<String> imagePaths}) async {
    var headers = {'Authorization': 'Bearer ${EndPoints.accessToken}'};
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://gotherapy.care/public/api/user/submit-report-image'));
    request.fields.addAll({'appointment_id': appointmentId});
    for (var x in imagePaths) {
      request.files.add(await http.MultipartFile.fromPath('report[]', x));
    }

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    return response;
  }
}
