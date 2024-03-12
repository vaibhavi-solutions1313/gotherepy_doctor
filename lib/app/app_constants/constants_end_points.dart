
import 'package:get/get.dart';
import 'package:gotherepy_doctor/app/app_services/local_storage.dart';
import 'package:gotherepy_doctor/main.dart';

import '../app_services/services.dart';

class EndPoints{
  static String netWorkImage='https://picsum.photos/200';
  static String baseUrl='http://gotherapy.care/public/api/doctor/';
  static String imageBaseUrl='http://gotherapy.care/public/';
  // static String accessToken=localStorage.read(LocalStorage.getAccessTokenKey)??'';
  static String accessToken=Get.find<Services>().box.read('accessToken') ?? '';

  ///Auth
   String login='login';
   String register='register';
  String sendOtp='http://gotherapy.care/public/api/user/resend-otp';

  ///Doctor Profile
  String getDoctorProfile='get-doctor-profile';
}