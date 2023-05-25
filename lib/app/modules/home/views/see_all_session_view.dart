import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../appWidgets/appButtons.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../appWidgets/universalAppBar.dart';
import '../../../app_constants/constants_appColors.dart';
import '../../session_page/views/session_page_view.dart';

class SeeAllSessionView extends GetView {
  const SeeAllSessionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomUniversalAppBar(title: 'Upcoming Session',appBar: AppBar(),),
      body:  ListView.builder(
        padding: EdgeInsets.all(16.0),
        shrinkWrap: true,
        itemCount: 6,
          itemBuilder: (context,index){
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 3.0,vertical: 8.0),
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
                  Expanded(child: BorderButton(buttonText: 'Cancel',
                    onClick: (){
                    Get.defaultDialog(
                      radius: 16.0,
                      titlePadding: EdgeInsets.zero,
                      contentPadding: EdgeInsets.zero,
                      title: '',
                      middleText: '',
                      content: Container(
                        width: Get.width,
                        padding: EdgeInsets.symmetric(horizontal: 18.0),
                        child: Column(
                          children: [
                            Icon(Icons.cancel_outlined,size: 56,color: AppColors.greyColor676464,),
                            SizedBox(height: 10,),
                            Text16by600(text: 'Cancel',fontSize: 20,color: AppColors.greyColor676464,),
                            SizedBox(height: 15,),
                            FooterTextWithCenterAligned(text: 'Please give specific reason.', fontSize: 16,color: AppColors.greyColor676464,),
                            SizedBox(height: 10,),
                            TextFormField(
                              maxLines: 4,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(16.0)
                                  ),
                                  filled: true,
                                  fillColor: AppColors.containerColor,
                                  hintText: 'Type here...'
                              ),
                            ),
                            SizedBox(height: 10,),
                            CustomSolidButton(buttonText: 'Cancel', onClick: (){},fontSize: 16,)
                          ],
                        ),
                      )
                  );},fontSize: 12,)),
                  SizedBox(width: 10,),
                  Expanded(child: CustomSolidButton(buttonText: 'Reschedule', onClick: (){Get.to(()=>SessionPageView());},fontSize: 12,)),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
