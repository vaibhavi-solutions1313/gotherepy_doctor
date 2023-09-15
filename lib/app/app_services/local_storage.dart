
import 'package:gotherepy_doctor/main.dart';
import '../data/doctor_user_info.dart';

class LocalStorage{
  DoctorProfileInfo doctorProfileInfo=DoctorProfileInfo.fromJson(localStorage.read('getDoctorProfileInfo'));


  ///Local Storage Key
  static String getDoctorProfileInfo='getDoctorProfileInfo';
  static String getAccessTokenKey='getAccessTokenKey';
}