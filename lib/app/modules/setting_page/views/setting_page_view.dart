import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../appWidgets/universalAppBar.dart';
import '../../../app_constants/constants_appColors.dart';
import '../controllers/setting_page_controller.dart';

class SettingPageView extends GetView<SettingPageController> {
  const SettingPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SettingPageController settingController=Get.put(SettingPageController());
    return Scaffold(
      appBar: CustomUniversalAppBar(title: 'Setting', appBar: AppBar(),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
              title: Text14by400(text: 'All Notification',fontSize: 12,color: Colors.black,),
              trailing:  InkWell(
                borderRadius: BorderRadius.circular(20.0),
                onTap: (){
                  settingController.isNotificationOn.value=!settingController.isNotificationOn.value;
                },
                child: Obx(()=>AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  padding: EdgeInsets.all(2.0),
                  height: 32,
                  width: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: settingController.isNotificationOn.value?AppColors.greenColor:AppColors.greyTextColor,)
                  ),
                  child: Icon(Icons.circle,color: settingController.isNotificationOn.value?AppColors.greenColor:AppColors.greyTextColor,),
                  alignment: settingController.isNotificationOn.value?Alignment.centerRight:Alignment.centerLeft,

                )),
              )),
          Container(
            width: Get.width,
            padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 16.0),
            color: AppColors.lightGreyTextColor.withOpacity(0.5),
              child: Text16by400(text: 'Product Notifications',fontSize: 13,)),
          SizedBox(height: 20,),
          Column(
            children: [
              ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                title: Text14by400(text: 'All Notification',fontSize: 12,color: Colors.black,),
                trailing:  InkWell(
                  borderRadius: BorderRadius.circular(20.0),
                  onTap: (){
                    settingController.isNotificationOn.value=!settingController.isNotificationOn.value;
                  },
                  child: Obx(()=>AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    padding: EdgeInsets.all(2.0),
                    height: 32,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: settingController.isNotificationOn.value?AppColors.greenColor:AppColors.greyTextColor,)
                    ),
                    child: Icon(Icons.circle,color: settingController.isNotificationOn.value?AppColors.greenColor:AppColors.greyTextColor,),
                    alignment: settingController.isNotificationOn.value?Alignment.centerRight:Alignment.centerLeft,

                  )),
                )),
              ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                title: Text14by400(text: 'Consult Q & A',fontSize: 12,color: Colors.black,),
                  trailing:  InkWell(
                    borderRadius: BorderRadius.circular(20.0),
                    onTap: (){
                      settingController.isFullscreenNotificationOn.value=!settingController.isFullscreenNotificationOn.value;
                    },
                    child: Obx(()=>AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      padding: EdgeInsets.all(2.0),
                      height: 32,
                      width: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: settingController.isFullscreenNotificationOn.value?AppColors.greenColor:AppColors.greyTextColor,)
                      ),
                      child: Icon(Icons.circle,color: settingController.isFullscreenNotificationOn.value?AppColors.greenColor:AppColors.greyTextColor,),
                      alignment: settingController.isFullscreenNotificationOn.value?Alignment.centerRight:Alignment.centerLeft,

                    )),
                  )),
              ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                title: Text14by400(text: 'Profile',fontSize: 12,color: Colors.black,),
                  trailing:  InkWell(
                    borderRadius: BorderRadius.circular(20.0),
                    onTap: (){
                      settingController.isPushNotificationOn.value=!settingController.isPushNotificationOn.value;
                    },
                    child: Obx(()=>AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      padding: EdgeInsets.all(2.0),
                      height: 32,
                      width: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: settingController.isPushNotificationOn.value?AppColors.greenColor:AppColors.greyTextColor,)
                      ),
                      child: Icon(Icons.circle,color: settingController.isPushNotificationOn.value?AppColors.greenColor:AppColors.greyTextColor,),
                      alignment: settingController.isPushNotificationOn.value?Alignment.centerRight:Alignment.centerLeft,

                    )),
                  )),
              ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                title: Text14by400(text: 'Reach',fontSize: 12,color: Colors.black,),
                  trailing:  InkWell(
                    borderRadius: BorderRadius.circular(20.0),
                    onTap: (){
                      settingController.isPushNotificationOn.value=!settingController.isPushNotificationOn.value;
                    },
                    child: Obx(()=>AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      padding: EdgeInsets.all(2.0),
                      height: 32,
                      width: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: settingController.isPushNotificationOn.value?AppColors.greenColor:AppColors.greyTextColor,)
                      ),
                      child: Icon(Icons.circle,color: settingController.isPushNotificationOn.value?AppColors.greenColor:AppColors.greyTextColor,),
                      alignment: settingController.isPushNotificationOn.value?Alignment.centerRight:Alignment.centerLeft,

                    )),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
