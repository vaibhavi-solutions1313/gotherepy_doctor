import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:gotherepy_doctor/app/app_constants/constants_end_points.dart';
import 'package:gotherepy_doctor/app/modules/home/views/home_view.dart';
import '../../../../main.dart';
import '../../../app_services/local_storage.dart';
import '../../../data/doctor_user_info.dart';
import '../../auth_page/views/auth_page_view.dart';
import '../../doctor_profile_page/views/doctor_profile_page_view.dart';

class SplashScreenController extends GetxController {
  //TODO: Implement SplashScreenController
  var opacity=false.obs;

void tryAutoLogin(){
  if (kDebugMode) {
    print('==========================tryAutoLogin===============================');
    print(localStorage.read(LocalStorage.getDoctorProfileInfo.toString()));
  }


    Future.delayed(Duration(seconds: 4),()async{
      if( localStorage.hasData(LocalStorage.getDoctorProfileInfo)){
        EndPoints.accessToken=localStorage.read(LocalStorage.getAccessTokenKey)??'';
        // doctorInfo= DoctorProfileInfo.fromJson(localStorage.read(LocalStorage.getDoctorProfileInfo));
        Get.off(() => const HomeView());
      } else{
        Get.off(() => const AuthPageView());
      }
    });
}
  @override
  void onInit() {
    super.onInit();
    tryAutoLogin();
    opacity.value=true;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
