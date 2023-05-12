import 'package:get/get.dart';
import 'package:gotherepy_doctor/app/modules/doctor_profile_page/views/doctor_profile_page_view.dart';
import 'package:gotherepy_doctor/app/modules/home/views/home_view.dart';
import 'package:gotherepy_doctor/app/modules/setting_page/views/setting_page_view.dart';

import '../../chat_page/views/chat_page_view.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  @override
  void onInit() {
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

  ///BottomNavigationBar
  var currentIndex=0.obs;
  jumpToPage(int index){
    currentIndex.value=index;
    if(currentIndex.value==0)
    {
      Get.to(() => HomeView());
    }else if(currentIndex.value==1)
    {
      // Get.to(() => ChatPageView());
    } else if(currentIndex.value==2) {
      Get.to(() => SettingPageView());
    }else if(currentIndex.value==3) {
      Get.to(() => ChatPageView());
    }else {
      Get.to(() => DoctorProfilePageView());
    }
  }
}
