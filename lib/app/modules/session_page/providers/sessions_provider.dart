import 'package:get/get.dart';
import 'package:gotherepy_doctor/app/app_constants/constants_end_points.dart';
import 'package:http/http.dart'as http;
class SessionsProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
  Future<http.StreamedResponse> acceptAppointment({required String appointmentId,})async{
    var headers = {
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    var request = http.MultipartRequest('POST', Uri.parse('http://gotherapy.care/backend/public/api/doctor/approve-booking'));
    request.fields.addAll({
      'appointment_id': appointmentId
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

   return response;

  }
 Future<http.StreamedResponse> submitReport({required String appointmentId,required String reportText,required List<String> imagePaths})async{
    var headers = {
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    var request = http.MultipartRequest('POST', Uri.parse('http://gotherapy.care/backend/public/api/user/submit-report-image'));
    request.fields.addAll({
      'appointment_id': appointmentId
    });
    for(var x in imagePaths){
      request.files.add(await http.MultipartFile.fromPath('report[]',x ));
    }

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    return response;
  }
}
