import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../main.dart';
import '../../../appWidgets/appButtons.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../appWidgets/universalAppBar.dart';
import '../../../app_constants/constants_appColors.dart';
import '../../live_video_call_page/views/live_video_call_page_view.dart';
import '../controllers/home_controller.dart';

class SeeAllSessionView extends GetView<HomeController> {
  SeeAllSessionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getAppointmentById(doctorId: doctorInfo.records!.doctorId.toString());

    return Scaffold(
      appBar: CustomUniversalAppBar(title: 'See All Sessions',appBar: AppBar(),),
      // appBar: CustomUniversalAppBar(title: 'Upcoming Session',appBar: AppBar(),),
      body:  Obx(() => controller.usersAppointmentsModel.value.results!=null &&
          controller.usersAppointmentsModel.value.results!.isNotEmpty
          ? ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.usersAppointmentsModel.value.results!.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(
                top: 18.0,
              ),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [BoxShadow(offset: Offset(1, 1), blurRadius: 2, spreadRadius: 3, color: AppColors.lightGreyTextColor.withOpacity(0.5))]),
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
                          Text14by500(
                            text: 'Patient For: ${controller.usersAppointmentsModel.value.results![index].patientName??''}',
                            color: AppColors.bluishColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Row(
                              children: [
                                Text14by400(
                                  text: 'Patient Name:',
                                  fontSize: 12,
                                  color: AppColors.lightGreyTextColor,
                                ),
                                Text14by500(
                                  text: controller.usersAppointmentsModel.value.results![index].patientName??'',
                                  fontSize: 12,
                                  color: AppColors.greyTextColor,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Row(
                              children: [
                                Text14by400(
                                  text: 'Session:',
                                  fontSize: 12,
                                  color: AppColors.lightGreyTextColor,
                                ),
                                Text14by500(
                                  text: controller.usersAppointmentsModel.value.results![index].id.toString(),
                                  fontSize: 12,
                                  color: AppColors.greyTextColor,
                                )
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
                                    child: Icon(
                                      Icons.calendar_month_rounded,
                                      color: AppColors.greyTextColor,
                                      size: 16,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('d MMM y').format((DateTime.parse(controller.usersAppointmentsModel.value.results![index].bookingDate!))),
                                    // DateTime.parse(controller.usersAppointmentsModel.value.results![index].bookingDate!).toString(),
                                    style: TextStyle(color: AppColors.greyTextColor, fontSize: 12, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 6.0),
                                    child: Icon(
                                      Icons.access_time,
                                      color: AppColors.greyTextColor,
                                      size: 16,
                                    ),
                                  ),
                                  Text(
                                    '${controller.usersAppointmentsModel.value.results![index].bookingStartTime!}-${controller.usersAppointmentsModel.value.results![index].bookingEndTime!}',
                                    style: TextStyle(color: AppColors.greyTextColor, fontSize: 12, fontWeight: FontWeight.w500),
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
                    onTap: () {
                      Get.defaultDialog(
                          titlePadding: EdgeInsets.zero,
                          contentPadding: EdgeInsets.zero,
                          title: '',
                          middleText: '',
                          content: Container(
                            padding: EdgeInsets.symmetric(horizontal: 18.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.warning_amber_rounded,
                                  size: 56,
                                  color: AppColors.greyTextColor,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text16by600(
                                  text: 'Alert',
                                  fontSize: 20,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const FooterTextWithCenterAligned(
                                  text: 'You don’t have sufficient balance Minimum balance should for 15 min chat.',
                                  fontSize: 16,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomSolidButton(
                                  buttonText: 'Trial Video Call',
                                  onClick: () {
                                    Get.to(() => const LiveVideoCallPageView());
                                  },
                                  fontSize: 16,
                                )
                              ],
                            ),
                          ));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                      decoration: BoxDecoration(color: AppColors.tealColor, borderRadius: BorderRadius.circular(6.0)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(right: 6.0),
                            child: Icon(
                              Icons.wifi_calling_3_outlined,
                              size: 24,
                            ),
                          ),
                          Text(
                            'Call',
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          })
          :Center(child: Column(
        children: [
          SizedBox(height: 150,),
          Text('No appointment booked for today!',style: TextStyle(color: AppColors.lightGreyTextColor),),
        ],
      )))
          /*decoration: BoxDecoration(
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
          ),*/
    );
  }
}

class Debouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
