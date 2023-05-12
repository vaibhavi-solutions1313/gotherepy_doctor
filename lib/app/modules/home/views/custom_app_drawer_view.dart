import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../app_constants/app_images.dart';
import '../../../app_constants/constants_appColors.dart';
import '../../../app_constants/constants_end_points.dart';

class CustomAppDrawerView extends GetView {
  const CustomAppDrawerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> drawerItems = [
      {'image': AppImages.customerChatSupport, 'itemName': 'Customer ChatSupport'},
      {'image': AppImages.wallet, 'itemName': 'Wallet'},
      {'image': AppImages.orderHistory, 'itemName': 'Order History'},
      {'image': AppImages.getReport, 'itemName': 'Get Report'},
      {'image': AppImages.chatWithConunsellers, 'itemName': 'Chat With Counsellors'},
      {'image': AppImages.myFollowing, 'itemName': 'My Following'},
      {'image': AppImages.signUpAsCounseller, 'itemName': 'Sign Up As Counsellor'},
      {'image': AppImages.settings, 'itemName': 'Settings'},
      {'image': AppImages.liveSession, 'itemName': 'Live Session'},
      {'image': AppImages.logOut, 'itemName': 'LOG OUT'},
    ].obs;
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                DrawerHeader(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          child: Image.network(
                            EndPoints.netWorkImage,
                            width: 60,
                          ),
                        ),
                        Positioned(
                          bottom: 5.0,
                          right: -0.0,
                          child: InkWell(
                            // onTap: ()=>Get.to(()=>ProfilePageView()),
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: AppColors.tealColor,
                              child: Icon(
                                Icons.edit,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text16by400(
                          text: 'Amandeep Singh',
                          fontSize: 22,
                          maxLine: 2,
                        ),
                        Text14by400(
                          text: '+91 9999 999 1313',
                          color: AppColors.bluishColor,
                        ),
                      ],
                    ),
                  ],
                )),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    // scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: drawerItems.length,
                    itemBuilder: (context, index) {
                       if(index==9){
                        return ListTile(
                            onTap: () {
                              // Get.offAll(SignInView());
                            },
                            splashColor: AppColors.tealColor.withOpacity(0.2),
                            leading: Container(
                                height: 35,
                                width: 35,
                                padding: EdgeInsets.all(6.0),
                                child: Image.asset(drawerItems[index]['image']!)),
                            title: Text14by400(text: drawerItems[index]['itemName']!,color: Color(0xffDE0000),));
                      }else{
                        return ListTile(
                             onTap: () {
                               if(index<4) {
                                 if(index==0) {
                                   // Get.to(() => const HelpDeskPageView());
                                }else if(index==1){
                                   // Get.to(() => const WalletPageView());
                                 }else if(index==2){
                                   // Get.to(() => const OrderHistoryView());
                                 }else{
                                   // Get.to(() => const GetReportPageView());
                                 }
                              } else if(index>=4 && index<9)
                              {
                                if(index==4) {
                                 // Get.to(() => const NotificationPageView());
                               }else if(index==5){
                                 // Get.to(() => const GetReportPageView());
                               }else if(index==6){
                                 // Get.to(() => const JournalPageView());
                               }else if(index==7){
                                  // Get.to(() => const SettingView());
                                }
                              }else {
                               // Get.to(() => const WalletPageView());
                               }
                            },
                             splashColor: AppColors.tealColor.withOpacity(0.2),
                             leading: Container(
                                 height: 35,
                                 width: 35,
                                 padding: EdgeInsets.all(6.0),
                                 decoration: BoxDecoration(color: AppColors.containerColor, borderRadius: BorderRadius.circular(8.0)),
                                 child: Image.asset(drawerItems[index]['image']!)),
                             title: Text14by400(text: drawerItems[index]['itemName']!));
                       }
                    }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                Text14by400(text: 'Follow Us'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          padding: EdgeInsets.all(8),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(color: Color(0xff334C8C), shape: BoxShape.circle),
                          child: Image.asset(AppImages.fbLogo,color: Colors.white,)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Container(width: 50,height: 50, child: Image.asset(AppImages.instaLogo)),
                      ),
                      Container(
                          padding: EdgeInsets.all(8),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(color: Color(0xff44C3D4), shape: BoxShape.circle),
                          child: Image.asset(AppImages.twitterLogo)),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
