
import 'package:gotherepy_doctor/app/app_services/local_storage.dart';
import 'package:gotherepy_doctor/main.dart';

class EndPoints{
  static String netWorkImage='https://picsum.photos/200';
  static String baseUrl='http://gotherapy.care/backend/public/api/doctor/';
  static String accessToken=localStorage.read(LocalStorage.getAccessTokenKey)??'';

  ///Auth
   String login='login';
   String register='register';
  String sendOtp='resend-otp';

  ///Doctor Profile
  String getDoctorProfile='get-doctor-profile';
}