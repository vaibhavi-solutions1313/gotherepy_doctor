import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotherepy_doctor/app/modules/doctor_profile_page/controllers/edit_profile_controller.dart';
import '../../../app_constants/constants_appColors.dart';

class EditProfileBottomNavBar extends GetView {
  const EditProfileBottomNavBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    EditProfileController controller= Get.find<EditProfileController>();
    return Obx(() =>  BottomNavigationBar(
      currentIndex: controller.currentIndex.value,
      onTap: (val){
        controller.currentIndex.value=val;
        controller.pageController.jumpToPage(controller.currentIndex.value);
        // controller.pageController.page=val;
      },
      selectedItemColor:AppColors.appThemeColor,
      unselectedItemColor: AppColors.greyTextColor,
      type: BottomNavigationBarType.shifting,
      items: const [
         BottomNavigationBarItem(icon: Icon(Icons.person_2_rounded, size: 16,),
                label: 'Profile',),
              BottomNavigationBarItem(icon: Icon(Icons.chat_rounded, size: 16,),
                label: 'Chat',),
            ],
    ));
  }
}
