import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app_constants/constants_appColors.dart';
import '../controllers/home_controller.dart';


class CustomBottomNavigationBarView extends GetView {
  const CustomBottomNavigationBarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    HomeController controller= Get.find<HomeController>();
    return Obx(() =>  BottomNavigationBar(
      currentIndex: controller.currentIndex.value,
      onTap: (val){
        controller.jumpToPage(val);
      },
      selectedItemColor:AppColors.bluishColor,
      unselectedItemColor: AppColors.greyTextColor,
      type: BottomNavigationBarType.shifting,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home),label: 'home'),
        BottomNavigationBarItem(icon: Icon(Icons.add_ic_call_rounded),label: 'Call'),
        BottomNavigationBarItem(icon: Icon(Icons.location_searching_outlined),label: 'Explore'),
        BottomNavigationBarItem(icon: Icon(Icons.mark_unread_chat_alt_outlined),label: 'Chat'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline_outlined),label: 'Account'),
      ],

    ));
  }
}
