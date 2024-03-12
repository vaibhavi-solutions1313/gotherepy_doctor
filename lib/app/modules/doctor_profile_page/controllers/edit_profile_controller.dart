import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gotherepy_doctor/app/modules/chat_page/views/chat_page_view.dart';
import 'package:gotherepy_doctor/app/modules/doctor_profile_page/providers/_provider.dart';
import 'package:gotherepy_doctor/app/modules/doctor_profile_page/views/edit_profile_view.dart';

import '../../../../main.dart';

class EditProfileController extends GetxController{
  ProfileProvider profileProvider = ProfileProvider();
  PageController pageController = PageController();
  // Rx<DoctorProfileModel> doctorProfiileModel = DoctorProfileModel().obs;

  @override
  void onInit() {
    if(doctorInfo.records!=null && doctorInfo.records!=null && doctorInfo.records!.doctorId!=null) {
      getAppointmentById(doctorId: doctorInfo.records!.doctorId!.toString());
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /// Bottom Navigation Bar

  var currentIndex = 0.obs;
  jumpToPage(int index){
    currentIndex.value = index;
    if(currentIndex.value == 0){
      Get.to(() => EditProfileView());
    } else{
      Get.to(() => ChatPageView());
    }
  }

  getAppointmentById({required String doctorId}){
    // profileProvider.fetchDoctorById(doctorId: doctorId).then((appointmentsResponseValue) {
    //   doctorProfileModel.value=appointmentsResponseValue;
    // });
  }

}