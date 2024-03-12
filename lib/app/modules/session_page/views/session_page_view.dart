import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotherepy_doctor/app/modules/chat_page/views/chat_page_view.dart';
import 'package:gotherepy_doctor/app/modules/home/controllers/home_controller.dart';
import 'package:gotherepy_doctor/app/modules/session_page/views/create_report_view.dart';
import 'package:intl/intl.dart';
import '../../../appWidgets/appButtons.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../appWidgets/universalAppBar.dart';
import '../../../app_constants/constants_appColors.dart';
import '../controllers/session_page_controller.dart';

class SessionPageView extends GetView<SessionPageController> {
  const SessionPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SessionPageController sessionPageController =
        Get.put(SessionPageController());
    return Scaffold(
      appBar: CustomUniversalAppBar(
        title: 'Session',
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                // handle the press
                Get.back();
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                border:
                    Border.all(width: 1, color: AppColors.lightGreyTextColor),
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.transparent,
              ),
              child: TabBar(
                padding: EdgeInsets.zero,
                // indicatorPadding: EdgeInsets.all(15.0),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: AppColors.bluishColor,
                ),
                labelColor: Colors.white,
                labelStyle:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                unselectedLabelStyle:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
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
                    Obx(() {
                      // Get.find<HomeController>().usersAppointmentsModel.value.results!.isNotEmpty
                      if (sessionPageController.sessionPendingAppointment.value.results != null &&
                          sessionPageController.sessionPendingAppointment.value.results!.isNotEmpty) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: sessionPageController
                                .sessionPendingAppointment
                                .value
                                .results!
                                .length,
                            // itemCount: Get.find<HomeController>().usersAppointmentsModel.value.results!.length,
                            itemBuilder: (context, index) {
                              sessionPageController.getPendingAppointmentById();
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 3.0, vertical: 18.0),
                                padding: EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16.0),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(1, 1),
                                          blurRadius: 2,
                                          spreadRadius: 3,
                                          color: AppColors.lightGreyTextColor
                                              .withOpacity(0.5))
                                    ]),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text14by500(
                                      text:
                                          'Patient For: ${sessionPageController.sessionPendingAppointment.value.results![index].patientName}',
                                      // text: 'Patient For: ${Get.find<HomeController>().usersAppointmentsModel.value.results![index].patientName??''}',color: AppColors.bluishColor,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6.0),
                                      child: Row(
                                        children: [
                                          Text14by400(
                                            text:
                                                'Patient Name: ${sessionPageController.sessionPendingAppointment.value.results![index].patientName}',
                                            // text: 'Patient Name: ${Get.find<HomeController>().usersAppointmentsModel.value.results![index].patientName??''}',fontSize: 12,color: AppColors.lightGreyTextColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12.0),
                                      child: Row(
                                        children: [
                                          Text14by400(
                                            text: 'Session:',
                                            fontSize: 12,
                                            color: AppColors.lightGreyTextColor,
                                          ),
                                          Text14by500(
                                            text: sessionPageController
                                                .sessionPendingAppointment
                                                .value
                                                .results![index]
                                                .id
                                                .toString(),
                                            // text: '1st',
                                            fontSize: 12,
                                            color: AppColors.greyTextColor,
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      // mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 6.0),
                                              child: Icon(
                                                Icons.calendar_month_rounded,
                                                color: AppColors.greyTextColor,
                                                size: 16,
                                              ),
                                            ),
                                            Text(
                                              DateFormat('d MMM y').format(
                                                  (DateTime.parse(
                                                      sessionPageController
                                                          .sessionPendingAppointment
                                                          .value
                                                          .results![index]
                                                          .bookingDate!
                                                          .toString()))),
                                              style: TextStyle(
                                                  color:
                                                      AppColors.greyTextColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                            )
                                            // Text(DateFormat('d MMM y').format((DateTime.parse(Get.find<HomeController>().usersAppointmentsModel.value.results![index].bookingDate!))),style: TextStyle(color: AppColors.greyTextColor,fontSize: 12,fontWeight: FontWeight.w500),
                                            // )
                                          ],
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 6.0),
                                              child: Icon(
                                                Icons.access_time,
                                                color: AppColors.greyTextColor,
                                                size: 16,
                                              ),
                                            ),
                                            Text(
                                              '${sessionPageController.sessionPendingAppointment.value.results![index].bookingStartTime!}-'
                                              '${sessionPageController.sessionPendingAppointment.value.results![index].bookingEndTime!}',
                                              style: TextStyle(
                                                  color:
                                                      AppColors.greyTextColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                              // Text('${Get.find<HomeController>().usersAppointmentsModel.value.results![index].bookingStartTime!}-${Get.find<HomeController>().usersAppointmentsModel.value.results![index].bookingEndTime!}',style: TextStyle(color: AppColors.greyTextColor,fontSize: 12,fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: BorderButton(
                                                buttonText: 'Reject',
                                                onClick: () async {
                                                  Get.defaultDialog(
                                                      titlePadding:
                                                          EdgeInsets.zero,
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      title: '',
                                                      middleText: '',
                                                      content: Flexible(
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        18.0),
                                                            child: Column(
                                                              children: [
                                                                Icon(
                                                                  Icons.cancel_outlined,
                                                                  size: 56,
                                                                  color: AppColors
                                                                      .greyTextColor,
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                const Text16by600(
                                                                  text: 'Cancel',
                                                                  fontSize: 20,
                                                                ),
                                                                const SizedBox(
                                                                  height: 15,
                                                                ),
                                                                const FooterTextWithCenterAligned(
                                                                  text:
                                                                      'Please give specific reason.',
                                                                  fontSize: 16,
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                TextField(
                                                                  controller:
                                                                      sessionPageController
                                                                          .reasonController,
                                                                  maxLines: 4,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .multiline,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    filled:
                                                                        true,
                                                                    fillColor:
                                                                        Colors.grey[
                                                                            300],
                                                                    hintText:
                                                                        'Type here...',
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                      borderSide:
                                                                          BorderSide
                                                                              .none,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                CustomSolidButton(
                                                                  buttonText:
                                                                      'Cancel',
                                                                  onClick:
                                                                      () async {
                                                                    sessionPageController.rejectAppointment(
                                                                        appointmentId: sessionPageController.sessionPendingAppointment.value.results![index].id.toString(),
                                                                        cancelledBy: sessionPageController.sessionPendingAppointment.value.results![index].doctorId.toString(),
                                                                        reason: sessionPageController.reasonController.text);
                                                                    print('Deleted entry');

                                                                    Navigator.pop(context);
                                                                    // Get.to(() => SessionPageView());
                                                                    // Get.back();
                                                                  },
                                                                  fontSize: 16,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ));
                                                })),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: CustomSolidButton(
                                                buttonText: 'Acccept',
                                                onClick: () async {
                                                  sessionPageController
                                                      .approveAppointment(
                                                          appointmentId:
                                                              sessionPageController
                                                                  .sessionPendingAppointment
                                                                  .value
                                                                  .results![
                                                                      index]
                                                                  .id
                                                                  .toString());
                                                  print(sessionPageController
                                                      .sessionPendingAppointment
                                                      .value
                                                      .results![index]
                                                      .id
                                                      .toString());
                                                  print(
                                                      'Successfully approved appointment~~~~~~~~~~~~~~~~~~~~');
                                                })),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            });
                      } else {
                        return Center(
                            child: Text(
                          'No appointment booked for today!',
                          style: TextStyle(color: AppColors.lightGreyTextColor),
                        ));
                      }
                    }),
                    Obx(() => Get.find<HomeController>()
                                .usersAppointmentsModel
                                .value
                                .results !=
                            null
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: Get.find<HomeController>()
                                .usersAppointmentsModel
                                .value
                                .results!
                                .length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 3.0, vertical: 18.0),
                                padding: EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16.0),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(1, 1),
                                          blurRadius: 2,
                                          spreadRadius: 3,
                                          color: AppColors.lightGreyTextColor
                                              .withOpacity(0.5))
                                    ]),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text14by500(
                                      text:
                                          'Patient For: ${Get.find<HomeController>().usersAppointmentsModel.value.results![index].patientName ?? ''}',
                                      color: AppColors.bluishColor,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6.0),
                                      child: Row(
                                        children: [
                                          Text14by500(
                                            text:
                                                'Patient Name: ${Get.find<HomeController>().usersAppointmentsModel.value.results![index].patientName ?? ''}',
                                            fontSize: 12,
                                            color: AppColors.greyTextColor,
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12.0),
                                      child: Row(
                                        children: [
                                          Text14by400(
                                            text: 'Session:',
                                            fontSize: 12,
                                            color: AppColors.lightGreyTextColor,
                                          ),
                                          Text14by500(
                                            text: '1st',
                                            fontSize: 12,
                                            color: AppColors.greyTextColor,
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      // mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 6.0),
                                              child: Icon(
                                                Icons.calendar_month_rounded,
                                                color: AppColors.greyTextColor,
                                                size: 16,
                                              ),
                                            ),
                                            Text(
                                              DateFormat('d MMM y').format(
                                                  (DateTime.parse(Get.find<
                                                          HomeController>()
                                                      .usersAppointmentsModel
                                                      .value
                                                      .results![index]
                                                      .bookingDate!))),
                                              style: TextStyle(
                                                  color:
                                                      AppColors.greyTextColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 6.0),
                                              child: Icon(
                                                Icons.access_time,
                                                color: AppColors.greyTextColor,
                                                size: 16,
                                              ),
                                            ),
                                            Text(
                                              '${Get.find<HomeController>().usersAppointmentsModel.value.results![index].bookingStartTime!}-${Get.find<HomeController>().usersAppointmentsModel.value.results![index].bookingEndTime!}',
                                              style: TextStyle(
                                                  color:
                                                      AppColors.greyTextColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: BorderButton(
                                          buttonText: 'Chat with Paitent',
                                          onClick: () {
                                            Get.to(() => ChatPageView(
                                                  userId:
                                                      '${Get.find<HomeController>().usersAppointmentsModel.value.results![index].userId ?? ''}',
                                                  patientName: Get.find<
                                                              HomeController>()
                                                          .usersAppointmentsModel
                                                          .value
                                                          .results![index]
                                                          .patientName ??
                                                      '',
                                                ));
                                          },
                                          fontSize: 12,
                                        )),
                                        // Expanded(child: BorderButton(buttonText: 'Chat with Paitent', onClick: (){Get.to(()=>PatientPageView());},fontSize: 12,)),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: CustomSolidButton(
                                          buttonText: 'Make Report',
                                          onClick: () {
                                            Get.to(() => CreateReportView(
                                                  userAppointmentId: Get.find<
                                                          HomeController>()
                                                      .usersAppointmentsModel
                                                      .value
                                                      .results![index]
                                                      .appointmentNumber!,
                                                ));
                                          },
                                          fontSize: 12,
                                        )),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            })
                        : SizedBox.shrink()),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
