import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotherepy_doctor/app/modules/auth_page/bindings/auth_page_binding.dart';
import 'package:gotherepy_doctor/app/modules/auth_page/views/auth_page_view.dart';
import 'package:gotherepy_doctor/app/modules/doctor_profile_page/views/doctor_profile_page_view.dart';
import 'package:gotherepy_doctor/app/modules/doctor_profile_page/views/edit_profile_view.dart';
import '../../main.dart';
import '../app_constants/app_images.dart';
import '../app_constants/constants_appColors.dart';
import '../modules/home/views/wallet_page_view.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final AppBar appBar;
  final double titleTextSize;
  final FontWeight titleFontWeight;
  final bool isCenterTitle;
  const CustomAppBar(
      {Key? key, required this.title, this.titleTextSize = 16, this.titleFontWeight = FontWeight.w500, this.isCenterTitle = false, required this.appBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // toolbarHeight: 300,
      leading: InkWell(
          onTap: (){
            // Get.back();
            },
          child: Icon(Icons.person_pin)
      ),
      // leadingWidth: 30,
      titleSpacing: 0,
      flexibleSpace: Container(
        height: 100,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [AppColors.bluishColor, AppColors.bluishColor.withOpacity(0.7)]),
            image: DecorationImage(image: AssetImage(AppImages.appbarBackgroundPngImage), fit: BoxFit.fitWidth)),
      ),
      centerTitle: isCenterTitle,
      title: Text(
        title,
        style: TextStyle(
          fontSize: titleTextSize,
          fontWeight: titleFontWeight,
          color: Colors.white,
        ),
      ),
      actions:[
        InkWell(onTap:(){
          Get.to(() => WalletPageView());
        },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AppImages.wallet,color: Colors.white,height: 22,width: 22,),
          ),
        ),


        PopupMenuButton<int>(
          onSelected: (item){
            if(item==0){
              localStorage.erase();
              Get.to(()=>AuthPageView(),binding: AuthPageBinding());}
            // if(item==5){Get.to(()=>PlanAndPricingView());}
          },
          itemBuilder: (context) => [
            PopupMenuItem<int>(value: 0, child: Row(
              children: [
                Image.asset(AppImages.logOut,color: Colors.black,height: 22,width: 22,),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('Log out'),
                ),
              ],
            ),),
            // PopupMenuItem<int>(value: 1, child: Row(
            //   children: [
            //     Image.asset(AppImages.wellness,color:AppColors.bluishColor ,height: 22,width: 22,),
            //     Padding(
            //       padding: const EdgeInsets.only(left: 8.0),
            //       child: Text('Wallness'),
            //     ),
            //   ],
            // ),),
            // PopupMenuItem<int>(value: 2, child: Row(
            //   children: [
            //     Image.asset(AppImages.bookYogaSession,color:AppColors.bluishColor ,height: 22,width: 22,),
            //     Padding(
            //       padding: const EdgeInsets.only(left: 8.0),
            //       child: Text('Book a Yoga Session'),
            //     ),
            //   ],
            // ),),
            // PopupMenuItem<int>(value: 3, child: Row(
            //   children: [
            //     Image.asset(AppImages.dailyJournal,color: AppColors.bluishColor,height: 22,width: 22,),
            //     Padding(
            //       padding: const EdgeInsets.only(left: 8.0),
            //       child: Text('Daily Journal'),
            //     ),
            //   ],
            // ),),
            // PopupMenuItem<int>(value: 4, child: Row(
            //   children: [
            //     Image.asset(AppImages.wallet,color: AppColors.bluishColor,height: 22,width: 22,),
            //     // Image.asset(AppImages.wallet,color: Colors.black,height: 22,width: 22,),
            //     Padding(
            //       padding: const EdgeInsets.only(left: 8.0),
            //       child: Text('Live Meditation'),
            //     ),
            //   ],
            // ),),
            // PopupMenuItem<int>(value: 5, child: Row(
            //   children: [
            //     Image.asset(AppImages.wallet,color: AppColors.bluishColor,height: 22,width: 22,),
            //     Padding(
            //       padding: const EdgeInsets.only(left: 8.0),
            //       child: Text('Mental Health Stuff'),
            //     ),
            //   ],
            // ),),
            // PopupMenuItem<int>(value: 6, child: Row(
            //   children: [
            //     Image.asset(AppImages.wallet,color: AppColors.bluishColor,height: 22,width: 22,),
            //     Padding(
            //       padding: const EdgeInsets.only(left: 8.0),
            //       child: Text('About Us'),
            //     ),
            //   ],
            // ),),
          ],
        ),
      ],
      iconTheme: IconThemeData(color: Colors.white),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
