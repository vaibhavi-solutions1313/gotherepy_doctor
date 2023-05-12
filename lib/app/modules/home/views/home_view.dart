import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotherepy_doctor/app/appWidgets/text_styles.dart';
import 'package:gotherepy_doctor/app/modules/home/views/custom_bottom_navigation_bar_view.dart';
import 'package:gotherepy_doctor/app/modules/home/views/see_all_session_view.dart';
import '../../../appWidgets/appButtons.dart';
import '../../../appWidgets/customAppBar.dart';
import '../../../app_constants/app_images.dart';
import '../../../app_constants/constants_appColors.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    return Scaffold(
      appBar: CustomAppBar(title: 'Hello Raghav',appBar: AppBar()),
      bottomNavigationBar: CustomBottomNavigationBarView(),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(AppImages.backgroundPngImage),
                repeat: ImageRepeat.repeat)
        ),
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            Column(
              children: [
        BannerCarousel(
        animation: false,
          viewportFraction: 1.0,
          showIndicator: false,
          spaceBetween: 8.0,
          customizedBanners: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0,vertical: 8.0),

              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0.5, 0.5),
                      blurRadius: 2,
                      spreadRadius: 3,
                      color: AppColors.lightGreyTextColor.withOpacity(0.8)
                  )
                ],
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(
                      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.green,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                  image: NetworkImage(
                      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text16by700(text: 'Upcoming Session',),
                    InkWell(
                        onTap: (){Get.to(()=>SeeAllSessionView());},
                        child: Text14by500(text: 'See All',color: AppColors.tealColor,))
                  ],
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context,index){
                      return Container(
                        margin: EdgeInsets.only(top: 18.0,),
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.0),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(1, 1),
                                  blurRadius: 2,
                                  spreadRadius: 3,
                                  color: AppColors.lightGreyTextColor.withOpacity(0.5)
                              )
                            ]
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text14by500(text: 'Patient For: Food Infection',color: AppColors.bluishColor,),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                                      child: Row(
                                        children: [
                                          Text14by400(text: 'Patient Name:',fontSize: 12,color: AppColors.lightGreyTextColor,),
                                          Text14by500(text: 'Ritik Sarwal',fontSize: 12,color: AppColors.greyTextColor,)

                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 12.0),
                                      child: Row(
                                        children: [
                                          Text14by400(text: 'Session:',fontSize: 12,color: AppColors.lightGreyTextColor,),
                                          Text14by500(text: '1st',fontSize: 12,color: AppColors.greyTextColor,)

                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      // mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 6.0),
                                              child: Icon(Icons.calendar_month_rounded,color: AppColors.greyTextColor,size: 16,),
                                            ),
                                            Text('12 Aug 2021',style: TextStyle(color: AppColors.greyTextColor,fontSize: 12,fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 15,),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 6.0),
                                              child: Icon(Icons.access_time,color: AppColors.greyTextColor,size: 16,),
                                            ),
                                            Text('12 Aug 2021',style: TextStyle(color: AppColors.greyTextColor,fontSize: 12,fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: (){
                                Get.defaultDialog(
                                    titlePadding: EdgeInsets.zero,
                                    contentPadding: EdgeInsets.zero,
                                    title: '',
                                    middleText: '',
                                    content: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                                      child: Column(
                                        children: [
                                          Icon(Icons.warning_amber_rounded,size: 56,color: AppColors.greyTextColor,),
                                          SizedBox(height: 10,),
                                          Text16by600(text: 'Alert',fontSize: 20,),
                                          SizedBox(height: 15,),
                                          FooterTextWithCenterAligned(text: 'You don’t have sufficient balance Minimum balance should for 15 min chat.', fontSize: 16,),
                                          SizedBox(height: 10,),
                                          CustomSolidButton(buttonText: 'Top Up', onClick: (){},fontSize: 16,)

                                        ],
                                      ),
                                    )
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 6.0),
                                decoration: BoxDecoration(
                                    color: AppColors.tealColor,
                                    borderRadius: BorderRadius.circular(6.0)
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 6.0),
                                      child: Icon(Icons.wifi_calling_3_outlined,size: 24,),
                                    ),
                                    Text('Call',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500),)
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
