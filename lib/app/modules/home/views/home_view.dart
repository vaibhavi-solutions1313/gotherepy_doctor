import 'package:banner_carousel/banner_carousel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotherepy_doctor/app/appWidgets/text_styles.dart';
import 'package:gotherepy_doctor/app/modules/home/views/custom_bottom_navigation_bar_view.dart';
import 'package:gotherepy_doctor/app/modules/home/views/see_all_session_view.dart';
import 'package:gotherepy_doctor/app/modules/live_video_call_page/views/live_video_call_page_view.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../main.dart';
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
      appBar: CustomAppBar(title: 'Hello ${doctorInfo.records?.doctorProfile?.first??'Guest'}',appBar: AppBar()),
      bottomNavigationBar: CustomBottomNavigationBarView(),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(AppImages.backgroundPngImage),
                repeat: ImageRepeat.repeat)
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
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
                image: const DecorationImage(
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
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const IntrinsicHeight(
                      child: Row(
                        children: [
                          VerticalDivider(
                            color: AppColors.tealColor,
                            thickness: 6,
                          ),
                          Text('Available Therapist',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700,),),
                        ],
                      ),
                    ),
                    CarouselSlider(
                        items: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
                            // padding: EdgeInsets.only(left: 18.0,top: 18.0,right: 18.0),
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 18.0, top: 18.0, right: 18.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(right: 8.0),
                                                child: CircularPercentIndicator(
                                                  radius: 35.0,
                                                  animation: true,
                                                  animationDuration: 1200,
                                                  linearGradient: const LinearGradient(
                                                    begin: Alignment.topRight,
                                                    end: Alignment.bottomLeft,
                                                    colors: [
                                                      Color(0xFF44C3D4),
                                                      Color(0xFF44C3D4),
                                                    ],
                                                  ),
                                                  lineWidth: 2.0,
                                                  percent: 0.6,
                                                  center: InkWell(
                                                    onTap: () {
                                                      // Get.to(() => ChatPageView());
                                                    },
                                                    child: CircleAvatar(
                                                        radius: 30,
                                                        backgroundColor: Colors.red,
                                                        child: ClipRRect(
                                                            borderRadius: BorderRadius.circular(140.0),
                                                            child: Image.asset(AppImages.marriage))),
                                                  ),
                                                  circularStrokeCap: CircularStrokeCap.round,
                                                  startAngle: 150,
                                                  backgroundColor: Colors.transparent,
                                                  footer: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 6.0),
                                                        child: Icon(Icons.thumb_up, color: AppColors.greenColor, size: 14,),
                                                      ),
                                                      Text('88%', style: TextStyle(color: AppColors.greyTextColor, fontSize: 12, fontWeight: FontWeight.w500),)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text14by400(text: 'Therapy',fontSize: 16),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                                                    child: IntrinsicHeight(
                                                      child:
                                                      Row(
                                                        children: [
                                                          Text16by400(text: 'Dentist', fontSize: 12, color: AppColors.lightGreyTextColor,),
                                                          VerticalDivider(color: Colors.black, indent: 2.0, endIndent: 2.0),
                                                          Text16by400(text: 'Dentist', fontSize: 12, color: AppColors.lightGreyTextColor,)

                                                        ],
                                                      ),

                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                                                    child: Text16by400(text: '₹ 30 /mins', fontSize: 12, color: AppColors.lightGreyTextColor,),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.symmetric(vertical: 6.0),
                                                        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                                                        decoration: ShapeDecoration(shape: StadiumBorder(),
                                                            color: AppColors.containerColor
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Text14by400(text: 'Min 30 min / ', color: AppColors.lightGreyTextColor),
                                                            Text14by400(text: 'Max 45 min', color: AppColors.lightGreyTextColor),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      // Here, default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor

                                    ],
                                  ),
                                ),
                                InkWell(
                                  // onTap: () {
                                  //   context.loaderOverlay.show();
                                  //   WalletProvider().fetchWalletBalance().then((value) async {
                                  //     context.loaderOverlay.hide();
                                  //     var decodedData = jsonDecode(await value.stream.bytesToString());
                                  //     if (decodedData['wallet_details'] != null) {
                                  //       var walletBalance = num.parse(decodedData['wallet_details'][0]['amount'].toString());
                                  //       if (walletBalance < (30 * 300)) {
                                  //         Get.defaultDialog(
                                  //             titlePadding: EdgeInsets.zero,
                                  //             contentPadding: EdgeInsets.zero,
                                  //             title: '',
                                  //             middleText: '',
                                  //             content: Container(
                                  //               padding: EdgeInsets.symmetric(horizontal: 18.0),
                                  //               child: Column(
                                  //                 children: [
                                  //                   Icon(
                                  //                     Icons.warning_amber_rounded, size: 56, color: AppColors.greyTextColor,),
                                  //                   SizedBox(height: 10,),
                                  //                   Text16by600(text: 'Alert', fontSize: 20,),
                                  //                   SizedBox(height: 15,),
                                  //                   FooterTextWithCenterAligned(
                                  //                     text: 'You don’t have sufficient balance Minimum balance should for 15 min chat.', fontSize: 16,),
                                  //                   SizedBox(height: 10,),
                                  //                   CustomSolidButton(buttonText: 'Top Up Wallet', onClick: () {
                                  //                     Get.off(() => const WalletPageView());
                                  //                   }, fontSize: 16,)
                                  //                 ],
                                  //               ),
                                  //             )
                                  //         );
                                  //       } else {
                                  //         Get.to(() => const LiveCounselorView());
                                  //       }
                                  //
                                  //     } else {
                                  //       Get.defaultDialog(
                                  //           titlePadding: EdgeInsets.zero,
                                  //           contentPadding: EdgeInsets.zero,
                                  //           title: '',
                                  //           middleText: '',
                                  //           content: Container(
                                  //             padding: EdgeInsets.symmetric(horizontal: 18.0),
                                  //             child: Column(
                                  //               children: [
                                  //                 Icon(
                                  //                   Icons.warning_amber_rounded, size: 56, color: AppColors.greyTextColor,),
                                  //                 SizedBox(height: 10,),
                                  //                 Text16by600(text: 'Alert', fontSize: 20,),
                                  //                 SizedBox(height: 15,),
                                  //                 const FooterTextWithCenterAligned(
                                  //                   text: 'You don’t have sufficient balance Minimum balance of Rs${30 * 300} should for 15 min chat.', fontSize: 16,),
                                  //                 SizedBox(height: 10,),
                                  //                 CustomSolidButton(buttonText: 'Top Up Wallet', onClick: () {
                                  //                   Get.off(() => const WalletPageView());
                                  //                 }, fontSize: 16,)
                                  //               ],
                                  //             ),
                                  //           )
                                  //       );
                                  //     }
                                  //   });
                                  // },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                                    decoration: const BoxDecoration(
                                        color: AppColors.tealColor,
                                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0))
                                    ),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 6.0),
                                          child: Icon(Icons.message_rounded, size: 13,),
                                        ),
                                        Text('Chat', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),)
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
                            // padding: EdgeInsets.only(left: 18.0,top: 18.0,right: 18.0),
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 18.0, top: 18.0, right: 18.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(right: 8.0),
                                                child: CircularPercentIndicator(
                                                  radius: 35.0,
                                                  animation: true,
                                                  animationDuration: 1200,
                                                  linearGradient: const LinearGradient(
                                                    begin: Alignment.topRight,
                                                    end: Alignment.bottomLeft,
                                                    colors: [
                                                      Color(0xFF44C3D4),
                                                      Color(0xFF44C3D4),
                                                    ],
                                                  ),
                                                  lineWidth: 2.0,
                                                  percent: 0.6,
                                                  center: InkWell(
                                                    onTap: () {
                                                      // Get.to(() => ChatPageView());
                                                    },
                                                    child: CircleAvatar(
                                                        radius: 30,
                                                        backgroundColor: Colors.red,
                                                        child: ClipRRect(
                                                            borderRadius: BorderRadius.circular(140.0),
                                                            child: Image.asset(AppImages.marriage))),
                                                  ),
                                                  circularStrokeCap: CircularStrokeCap.round,
                                                  startAngle: 150,
                                                  backgroundColor: Colors.transparent,
                                                  footer: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 6.0),
                                                        child: Icon(Icons.thumb_up, color: AppColors.greenColor, size: 14,),
                                                      ),
                                                      Text('88%', style: TextStyle(color: AppColors.greyTextColor, fontSize: 12, fontWeight: FontWeight.w500),)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text14by400(text: 'Yoga',fontSize: 16),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                                                    child: IntrinsicHeight(
                                                      child:
                                                      Row(
                                                        children: [
                                                          Text16by400(text: 'Dentist', fontSize: 12, color: AppColors.lightGreyTextColor,),
                                                          VerticalDivider(color: Colors.black, indent: 2.0, endIndent: 2.0),
                                                          Text16by400(text: 'Dentist', fontSize: 12, color: AppColors.lightGreyTextColor,)

                                                        ],
                                                      ),

                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                                                    child: Text16by400(text: '₹ 30 /mins', fontSize: 12, color: AppColors.lightGreyTextColor,),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.symmetric(vertical: 6.0),
                                                        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                                                        decoration: ShapeDecoration(shape: StadiumBorder(),
                                                            color: AppColors.containerColor
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Text14by400(text: 'Min 30 min / ', color: AppColors.lightGreyTextColor),
                                                            Text14by400(text: 'Max 45 min', color: AppColors.lightGreyTextColor),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      // Here, default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor

                                    ],
                                  ),
                                ),
                                InkWell(
                                  // onTap: () {
                                  //   context.loaderOverlay.show();
                                  //   WalletProvider().fetchWalletBalance().then((value) async {
                                  //     context.loaderOverlay.hide();
                                  //     var decodedData = jsonDecode(await value.stream.bytesToString());
                                  //     if (decodedData['wallet_details'] != null) {
                                  //       var walletBalance = num.parse(decodedData['wallet_details'][0]['amount'].toString());
                                  //       if (walletBalance < (30 * 300)) {
                                  //         Get.defaultDialog(
                                  //             titlePadding: EdgeInsets.zero,
                                  //             contentPadding: EdgeInsets.zero,
                                  //             title: '',
                                  //             middleText: '',
                                  //             content: Container(
                                  //               padding: EdgeInsets.symmetric(horizontal: 18.0),
                                  //               child: Column(
                                  //                 children: [
                                  //                   Icon(
                                  //                     Icons.warning_amber_rounded, size: 56, color: AppColors.greyTextColor,),
                                  //                   SizedBox(height: 10,),
                                  //                   Text16by600(text: 'Alert', fontSize: 20,),
                                  //                   SizedBox(height: 15,),
                                  //                   FooterTextWithCenterAligned(
                                  //                     text: 'You don’t have sufficient balance Minimum balance should for 15 min chat.', fontSize: 16,),
                                  //                   SizedBox(height: 10,),
                                  //                   CustomSolidButton(buttonText: 'Top Up Wallet', onClick: () {
                                  //                     Get.off(() => const WalletPageView());
                                  //                   }, fontSize: 16,)
                                  //                 ],
                                  //               ),
                                  //             )
                                  //         );
                                  //       } else {
                                  //         Get.to(() => const LiveCounselorView());
                                  //       }
                                  //
                                  //     } else {
                                  //       Get.defaultDialog(
                                  //           titlePadding: EdgeInsets.zero,
                                  //           contentPadding: EdgeInsets.zero,
                                  //           title: '',
                                  //           middleText: '',
                                  //           content: Container(
                                  //             padding: EdgeInsets.symmetric(horizontal: 18.0),
                                  //             child: Column(
                                  //               children: [
                                  //                 Icon(
                                  //                   Icons.warning_amber_rounded, size: 56, color: AppColors.greyTextColor,),
                                  //                 SizedBox(height: 10,),
                                  //                 Text16by600(text: 'Alert', fontSize: 20,),
                                  //                 SizedBox(height: 15,),
                                  //                 const FooterTextWithCenterAligned(
                                  //                   text: 'You don’t have sufficient balance Minimum balance of Rs${30 * 300} should for 15 min chat.', fontSize: 16,),
                                  //                 SizedBox(height: 10,),
                                  //                 CustomSolidButton(buttonText: 'Top Up Wallet', onClick: () {
                                  //                   Get.off(() => const WalletPageView());
                                  //                 }, fontSize: 16,)
                                  //               ],
                                  //             ),
                                  //           )
                                  //       );
                                  //     }
                                  //   });
                                  // },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                                    decoration: const BoxDecoration(
                                        color: AppColors.tealColor,
                                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0))
                                    ),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 6.0),
                                          child: Icon(Icons.message_rounded, size: 13,),
                                        ),
                                        Text('Chat', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),)
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
                            // padding: EdgeInsets.only(left: 18.0,top: 18.0,right: 18.0),
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 18.0, top: 18.0, right: 18.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(right: 8.0),
                                                child: CircularPercentIndicator(
                                                  radius: 35.0,
                                                  animation: true,
                                                  animationDuration: 1200,
                                                  linearGradient: const LinearGradient(
                                                    begin: Alignment.topRight,
                                                    end: Alignment.bottomLeft,
                                                    colors: [
                                                      Color(0xFF44C3D4),
                                                      Color(0xFF44C3D4),
                                                    ],
                                                  ),
                                                  lineWidth: 2.0,
                                                  percent: 0.6,
                                                  center: InkWell(
                                                    onTap: () {
                                                      // Get.to(() => ChatPageView());
                                                    },
                                                    child: CircleAvatar(
                                                        radius: 30,
                                                        backgroundColor: Colors.red,
                                                        child: ClipRRect(
                                                            borderRadius: BorderRadius.circular(140.0),
                                                            child: Image.asset(AppImages.marriage))),
                                                  ),
                                                  circularStrokeCap: CircularStrokeCap.round,
                                                  startAngle: 150,
                                                  backgroundColor: Colors.transparent,
                                                  footer: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 6.0),
                                                        child: Icon(Icons.thumb_up, color: AppColors.greenColor, size: 14,),
                                                      ),
                                                      Text('88%', style: TextStyle(color: AppColors.greyTextColor, fontSize: 12, fontWeight: FontWeight.w500),)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text14by400(text: 'Meditation',fontSize: 16,),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                                                    child: IntrinsicHeight(
                                                      child:
                                                      Row(
                                                        children: [
                                                          Text16by400(text: 'Dentist', fontSize: 12, color: AppColors.lightGreyTextColor,),
                                                          VerticalDivider(color: Colors.black, indent: 2.0, endIndent: 2.0),
                                                          Text16by400(text: 'Dentist', fontSize: 12, color: AppColors.lightGreyTextColor,)

                                                        ],
                                                      ),

                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                                                    child: Text16by400(text: '₹ 30 /mins', fontSize: 12, color: AppColors.lightGreyTextColor,),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.symmetric(vertical: 6.0),
                                                        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                                                        decoration: ShapeDecoration(shape: StadiumBorder(),
                                                            color: AppColors.containerColor
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Text14by400(text: 'Min 30 min / ', color: AppColors.lightGreyTextColor),
                                                            Text14by400(text: 'Max 45 min', color: AppColors.lightGreyTextColor),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      // Here, default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor

                                    ],
                                  ),
                                ),
                                InkWell(
                                  // onTap: () {
                                  //   context.loaderOverlay.show();
                                  //   WalletProvider().fetchWalletBalance().then((value) async {
                                  //     context.loaderOverlay.hide();
                                  //     var decodedData = jsonDecode(await value.stream.bytesToString());
                                  //     if (decodedData['wallet_details'] != null) {
                                  //       var walletBalance = num.parse(decodedData['wallet_details'][0]['amount'].toString());
                                  //       if (walletBalance < (30 * 300)) {
                                  //         Get.defaultDialog(
                                  //             titlePadding: EdgeInsets.zero,
                                  //             contentPadding: EdgeInsets.zero,
                                  //             title: '',
                                  //             middleText: '',
                                  //             content: Container(
                                  //               padding: EdgeInsets.symmetric(horizontal: 18.0),
                                  //               child: Column(
                                  //                 children: [
                                  //                   Icon(
                                  //                     Icons.warning_amber_rounded, size: 56, color: AppColors.greyTextColor,),
                                  //                   SizedBox(height: 10,),
                                  //                   Text16by600(text: 'Alert', fontSize: 20,),
                                  //                   SizedBox(height: 15,),
                                  //                   FooterTextWithCenterAligned(
                                  //                     text: 'You don’t have sufficient balance Minimum balance should for 15 min chat.', fontSize: 16,),
                                  //                   SizedBox(height: 10,),
                                  //                   CustomSolidButton(buttonText: 'Top Up Wallet', onClick: () {
                                  //                     Get.off(() => const WalletPageView());
                                  //                   }, fontSize: 16,)
                                  //                 ],
                                  //               ),
                                  //             )
                                  //         );
                                  //       } else {
                                  //         Get.to(() => const LiveCounselorView());
                                  //       }
                                  //
                                  //     } else {
                                  //       Get.defaultDialog(
                                  //           titlePadding: EdgeInsets.zero,
                                  //           contentPadding: EdgeInsets.zero,
                                  //           title: '',
                                  //           middleText: '',
                                  //           content: Container(
                                  //             padding: EdgeInsets.symmetric(horizontal: 18.0),
                                  //             child: Column(
                                  //               children: [
                                  //                 Icon(
                                  //                   Icons.warning_amber_rounded, size: 56, color: AppColors.greyTextColor,),
                                  //                 SizedBox(height: 10,),
                                  //                 Text16by600(text: 'Alert', fontSize: 20,),
                                  //                 SizedBox(height: 15,),
                                  //                 const FooterTextWithCenterAligned(
                                  //                   text: 'You don’t have sufficient balance Minimum balance of Rs${30 * 300} should for 15 min chat.', fontSize: 16,),
                                  //                 SizedBox(height: 10,),
                                  //                 CustomSolidButton(buttonText: 'Top Up Wallet', onClick: () {
                                  //                   Get.off(() => const WalletPageView());
                                  //                 }, fontSize: 16,)
                                  //               ],
                                  //             ),
                                  //           )
                                  //       );
                                  //     }
                                  //   });
                                  // },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                                    decoration: const BoxDecoration(
                                        color: AppColors.tealColor,
                                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0))
                                    ),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 6.0),
                                          child: Icon(Icons.message_rounded, size: 13,),
                                        ),
                                        Text('Chat', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),)
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                        options: CarouselOptions(
                          // height: 200,
                          // aspectRatio: Get.pixelRatio,
                          viewportFraction:1.0,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          // enlargeCenterPage: true,
                          // enlargeFactor: 0.3,
                          onPageChanged: (index, reason) {},
                          scrollDirection: Axis.horizontal,
                        )),
                  ],
                ),



                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text16by700(text: 'Upcoming Session',),
                    InkWell(
                        onTap: (){Get.to(()=>const SeeAllSessionView());},
                        child: const Text14by500(text: 'See All',color: AppColors.tealColor,))
                  ],
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context,index){
                      return Container(
                        margin: const EdgeInsets.only(top: 18.0,),
                        padding: const EdgeInsets.all(16.0),
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
                                    const Text14by500(text: 'Patient For: Food Infection',color: AppColors.bluishColor,),
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
                                          const SizedBox(height: 10,),
                                          const Text16by600(text: 'Alert',fontSize: 20,),
                                          const SizedBox(height: 15,),
                                          const FooterTextWithCenterAligned(text: 'You don’t have sufficient balance Minimum balance should for 15 min chat.', fontSize: 16,),
                                          const SizedBox(height: 10,),
                                          CustomSolidButton(buttonText: 'Trial Video Call', onClick: (){
                                            Get.offAll(()=>const LiveVideoCallPageView());
                                          },fontSize: 16,)

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
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.only(right: 6.0),
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
