import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gotherepy_doctor/app/modules/home/providers/home_provider.dart';
import '../../../../main.dart';
import '../model/user_appointment_model.dart';


class HomeController extends GetxController {
  //TODO: Implement HomeController
HomeProvider homeProvider=HomeProvider();
PageController pageController=PageController();
Rx<UsersAppointmentsModel> usersAppointmentsModel=UsersAppointmentsModel().obs;


  @override
  void onInit() {
    super.onInit();
    if(doctorInfo.records!=null && doctorInfo.records!=null && doctorInfo.records!.doctorId!=null) {
      getAppointmentById(doctorId: doctorInfo.records!.doctorId!.toString());
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  ///BottomNavigationBar
  var currentIndex=0.obs;
  jumpToPage(int index){
    currentIndex.value=index;
    // if(currentIndex.value==0)
    // {
    //   Get.to(() => HomeView());
    // }else if(currentIndex.value==1)
    // {
    //   // Get.to(() => ChatPageView());
    // } else if(currentIndex.value==2) {
    //   Get.to(() => SettingPageView());
    // }else if(currentIndex.value==3) {
    //   Get.to(() => ChatPageView());
    // }else {
    //   Get.to(() => DoctorProfilePageView());
    // }
  }
  getAppointmentById({required String doctorId}){
    homeProvider.fetchAppointmentById(doctorId: doctorId).then((appointmentsResponseValue) {
      usersAppointmentsModel.value=appointmentsResponseValue;
    });
  }
}
