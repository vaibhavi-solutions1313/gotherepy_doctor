import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotherepy_doctor/app/modules/patient_page/views/patient_page_view.dart';
import 'package:gotherepy_doctor/app/modules/session_page/views/create_report_view.dart';

import '../../../appWidgets/appButtons.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../appWidgets/universalAppBar.dart';
import '../../../app_constants/constants_appColors.dart';
import '../controllers/session_page_controller.dart';

class SessionPageView extends GetView<SessionPageController> {
  const SessionPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SessionPageController sessionPageController=Get.put(SessionPageController());
    return Scaffold(
      appBar: CustomUniversalAppBar(title: 'Session', appBar: AppBar(),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                border: Border.all(width: 1,color: AppColors.lightGreyTextColor),
                borderRadius: BorderRadius.circular(15.0) ,
                color: Colors.transparent,
              ),
              child:TabBar(
                padding: EdgeInsets.zero,
                // indicatorPadding: EdgeInsets.all(15.0),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: AppColors.bluishColor,
                ),
                labelColor: Colors.white,
                labelStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                unselectedLabelStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                // isScrollable: true,
                indicatorSize: TabBarIndicatorSize.tab,
                unselectedLabelColor: AppColors.lightGreyTextColor,
                controller: sessionPageController.tabController,
                tabs: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      // color: Color(0xFFF5C316),
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                        child: Text(
                          'New Session Request'.tr,
                        )),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                        child: Text(
                          'Completed Session'.tr,
                        )),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                  controller: sessionPageController.tabController,
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context,index){
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 3.0,vertical: 18.0),
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
                            child: Column(
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
                                        Text('10 am - 12 pm',style: TextStyle(color: AppColors.greyTextColor,fontSize: 12,fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(child: BorderButton(buttonText: 'Reject', onClick: (){})),
                                    SizedBox(width: 10,),
                                    Expanded(child: CustomSolidButton(buttonText: 'Acccept', onClick: (){})),
                                  ],
                                ),

                              ],
                            ),
                          );
                        }),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context,index){
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 3.0,vertical: 18.0),
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
                            child: Column(
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
                                        Text('10 am - 12 pm',style: TextStyle(color: AppColors.greyTextColor,fontSize: 12,fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(child: BorderButton(buttonText: 'Chat with Paitent', onClick: (){Get.to(()=>PatientPageView());},fontSize: 12,)),
                                    SizedBox(width: 10,),
                                    Expanded(child: CustomSolidButton(buttonText: 'Make Report', onClick: (){Get.to(()=>CreateReportView());},fontSize: 12,)),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),

                  ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}
