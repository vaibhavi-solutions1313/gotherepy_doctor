import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gotherepy_doctor/app/modules/doctor_profile_page/controllers/doctor_ratings_controller.dart';
import 'package:gotherepy_doctor/app/modules/doctor_profile_page/views/edit_profile_view.dart';
import 'package:gotherepy_doctor/main.dart';
import 'package:intl/intl.dart';
import '../../../appWidgets/appButtons.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../appWidgets/universalAppBar.dart';
import '../../../app_constants/constants_appColors.dart';
import '../controllers/doctor_profile_page_controller.dart';
import '../controllers/session_slot_controller.dart';

class DoctorProfilePageView extends GetView<DoctorProfilePageController> {
  const DoctorProfilePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DoctorProfilePageController doctorProfilePageController =
        Get.put(DoctorProfilePageController());
    ReviewsController reviewsController = Get.put(ReviewsController());
    SessionSlotsController sessionSlotsController =
        Get.put(SessionSlotsController());
    return Scaffold(
      appBar: CustomUniversalAppBar(
        title: 'Profile',
        appBar: AppBar(),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 120,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: AppColors.appThemeColor.withOpacity(0.2),
                      border: const Border(
                          bottom: BorderSide(color: AppColors.bluishColor)),
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(20.0)),
                      image: doctorInfo.records!.avatar != null
                          ? DecorationImage(
                              image: NetworkImage(doctorInfo.records!.avatar!),
                              fit: BoxFit.fitWidth)
                          : null,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomSolidButton(
                          vPadding: 3.0,
                          buttonText: 'Edit Profile',
                          onClick: () async {
                            Get.to(() => const EditProfileView());
                          }),
                      SizedBox(
                        width: 30.0,
                      )
                    ],
                  )
                ],
              ),
              Positioned(
                bottom: 12,
                left: Get.width / 8,
                child: Stack(
                  fit: StackFit.loose,
                  children: [
                    Container(
                      constraints: const BoxConstraints(
                          minHeight: 80,
                          minWidth: 80,
                          maxHeight: 80,
                          maxWidth: 80),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 1.0, color: AppColors.appThemeColor),
                          image: controller.userImagePath.value == ''
                              ? DecorationImage(
                                  image:
                                      NetworkImage(doctorInfo.records!.avatar!),
                                  fit: BoxFit.fill)
                              : null),
                      child: controller.userImagePath.value == ''
                          ? null
                          : Obx(() => ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.file(
                                File(controller.userImagePath.value!),
                                fit: BoxFit.fill,
                              ))),
                    ),
                    Positioned(
                        bottom: 5,
                        right: 3.0,
                        child: InkWell(
                            onTap: () async {
                              controller.userImagePath.value =
                                  await controller.pickImageFromGallery();
                            },
                            child: Ink(
                                padding: EdgeInsets.all(1.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 1.0,
                                        color: AppColors.appThemeColor)),
                                child: const Icon(
                                  Icons.image,
                                  size: 13,
                                  color: Colors.grey,
                                ))))
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          TabBar(
            tabAlignment: TabAlignment.fill,
              padding: EdgeInsets.all(10.0),
              controller: doctorProfilePageController.tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              indicatorColor: AppColors.appThemeColor,
              labelStyle: TextStyle(
                  color: AppColors.blackishTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(
                  color: AppColors.blackish5E5E5E,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              // isScrollable: true,
              dividerHeight: 2,
              tabs: const [
                Text('Profile'),
                Text('Availability'),
                Text('Feedback'),
              ]),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: TabBarView(
                controller: doctorProfilePageController.tabController,
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              /*ListView.separated(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: doctorProfilePageController.doctorDetail.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Icon(
                                          index == 0
                                              ? Icons.person
                                              : index == 1
                                                  ? Icons.account_box_outlined
                                                  : Icons.info_outline,
                                          size: 32,
                                          color: Colors.black.withOpacity(0.9),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 8,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text16by600(
                                              text: doctorProfilePageController
                                                  .doctorDetail[index]['title']
                                                  .toString(),
                                              color: AppColors.greyColor6A6A6A,
                                            ),
                                            Obx(() => TextField(
                                                  maxLines: 3,
                                                  minLines: 1,
                                                  readOnly:
                                                      doctorProfilePageController
                                                          .enableTexField.value,
                                                  decoration: InputDecoration(
                                                      filled:
                                                          !doctorProfilePageController
                                                              .enableTexField
                                                              .value,
                                                      fillColor:
                                                          Color(0xffFCF5E5),
                                                      contentPadding:
                                                          EdgeInsets.all(3.0),
                                                      hintText:
                                                          doctorProfilePageController
                                                              .doctorDetail[
                                                                  index]
                                                                  ['value']
                                                              .toString(),
                                                      border: InputBorder.none),
                                                )),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: InkWell(
                                          onTap: () {
                                            doctorProfilePageController
                                                    .enableTexField.value =
                                                !doctorProfilePageController
                                                    .enableTexField.value;
                                          },
                                          child: CircleAvatar(
                                              radius: 13,
                                              backgroundColor:
                                                  AppColors.tealColor,
                                              child: Obx(() => Icon(
                                                    doctorProfilePageController
                                                            .enableTexField
                                                            .value
                                                        ? Icons.edit
                                                        : Icons.cancel_outlined,
                                                    size: 13,
                                                    color: Colors.white,
                                                  ))),
                                        ),
                                      )
                                    ],
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(
                                    height: 15,
                                  );
                                },
                              ),*/
                              ListView.builder(
                                padding: EdgeInsets.all(8.0),
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: doctorProfilePageController.doctorDetail.length,
                                  itemBuilder: (context, index){
                                    return Container(
                                      padding: EdgeInsets.symmetric(vertical: 5.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text16by600(
                                                text: doctorProfilePageController.doctorDetail[index]['title'].toString(),
                                                color: AppColors.blackish5E5E5E,
                                                fontSize: 14,
                                              ),
                                            ],
                                          ),
                                          Material(
                                            elevation: 2.0,
                                            color: Colors.white,
                                            shadowColor: AppColors.whiteShadow,
                                            borderRadius: BorderRadius.circular(10.0),
                                            child: TextFormField(
                                              readOnly: doctorProfilePageController.enableTexField.value,
                                              autofocus: false,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.blackishTextColor,
                                              ),
                                              decoration: InputDecoration(
                                                prefixIcon: Icon(
                                                  index == 0 || index == 1 ? Icons.person : Icons.info,
                                                  size: 16, color: Colors.black.withOpacity(0.9),
                                                ),
                                                  border: InputBorder.none,
                                                  contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                                                  hintText: doctorProfilePageController.doctorDetail[index]['value'].toString(),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                suffixIcon: InkWell(
                                                  onTap: () {
                                                    doctorProfilePageController
                                                        .enableTexField.value =
                                                    !doctorProfilePageController
                                                        .enableTexField.value;
                                                  },
                                                    child: Icon(
                                                      Icons.edit,
                                                      size: 16,
                                                      color: AppColors.blackishTextColor,),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }
                              )
                            ],
                          ),
                          CustomSolidButton(
                              buttonText: 'Update', fontSize: 14, vPadding: 12, onClick: () {}),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
                            child: const Text(
                                'Upload educational qualification certificate',
                            style: TextStyle(fontSize: 14, color: AppColors.blackishTextColor),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(() => Container(
                                    constraints: BoxConstraints(
                                        maxHeight: 120,
                                        minHeight: 70,
                                        maxWidth: Get.width * 0.6,
                                        minWidth: Get.width * 0.3),
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        image: controller
                                                    .qualificationCertificateImagePath
                                                    .value !=
                                                ''
                                            ? DecorationImage(
                                                image: FileImage(File(controller
                                                    .qualificationCertificateImagePath
                                                    .value!)))
                                            : null),
                                    child: controller
                                                .qualificationCertificateImagePath
                                                .value ==
                                            ""
                                        ? const Icon(
                                            Icons.image,
                                            color: Colors.grey,
                                          )
                                        : null,
                                  )),
                              CustomSolidButton(
                                buttonText: 'Upload',
                                vPadding: 5,
                                fontSize: 12,
                                onClick: () async {
                                  controller.qualificationCertificateImagePath
                                          .value =
                                      await controller.pickImageFromGallery();
                                },
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
                            child: const Text(
                              'Upload identity proof',
                              style: TextStyle(fontSize: 14, color: AppColors.blackishTextColor),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(() => Container(
                                    constraints: BoxConstraints(
                                        maxHeight: 120,
                                        minHeight: 70,
                                        maxWidth: Get.width * 0.6,
                                        minWidth: Get.width * 0.3),
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        image: controller.identityProofImagePath
                                                    .value !=
                                                ''
                                            ? DecorationImage(
                                                image: FileImage(File(controller
                                                    .identityProofImagePath
                                                    .value!)))
                                            : null),
                                    child: controller
                                                .identityProofImagePath.value ==
                                            ""
                                        ? const Icon(
                                            Icons.image,
                                            color: Colors.grey,
                                          )
                                        : null,
                                  )),
                              CustomSolidButton(
                                buttonText: 'Upload',
                                vPadding: 5,
                                fontSize: 12,
                                onClick: () async {
                                  controller.identityProofImagePath.value =
                                      await controller.pickImageFromGallery();
                                },
                              ),
                            ],
                          ),
                          // Divider(),
                          // const Text('Your availability for this week'),
                          // SizedBox(
                          //   height: 70,
                          //   child: LayoutBuilder(builder: (context, index) {
                          //     return ListView.builder(
                          //         shrinkWrap: true,
                          //         scrollDirection: Axis.horizontal,
                          //         itemCount: 7,
                          //         itemBuilder: (context, index) {
                          //           return Padding(
                          //             padding: const EdgeInsets.all(8.0),
                          //             child: InkWell(
                          //               onTap: (){
                          //                 index=0;
                          //               },
                          //               child: Container(
                          //                 padding: EdgeInsets.all(5.0),
                          //                 constraints: BoxConstraints(maxHeight: 60, minHeight: 50,maxWidth: 100,minWidth: 100),
                          //                 decoration: BoxDecoration(
                          //                     color: index==0?AppColors.bluishColor:Colors.grey,
                          //                     borderRadius: BorderRadius.circular(26.0)
                          //                 ),
                          //                 child: Column(
                          //                   mainAxisSize: MainAxisSize.min,
                          //                   children: [
                          //                     Text((DateTime.now().weekday+index).toString()),
                          //                     Text('26-oct'),
                          //                   ],
                          //                 ),
                          //               ),
                          //             ),
                          //           );
                          //         });
                          //   }),
                          // ),
                          // SizedBox(
                          //   height: 100,
                          //   child: LayoutBuilder(builder: (context, index) {
                          //     return  Wrap(
                          //       // crossAxisAlignment: WrapCrossAlignment.center,
                          //       // runAlignment: WrapAlignment.center,
                          //       alignment: WrapAlignment.center,
                          //       runSpacing: 6.0,
                          //       spacing: 6.0,
                          //       children: List.generate(7, (index) => Container(
                          //         padding: EdgeInsets.all(6.0),
                          //         decoration: BoxDecoration(
                          //             color: Colors.blue,
                          //             borderRadius: BorderRadius.circular(6.0)
                          //         ),
                          //         child: Text('${3+index}:00 pm'),
                          //       )),);
                          //   }),
                          // ),
                          // CustomSolidButton(
                          //     buttonText: 'Edit availability',
                          //     onClick: () {
                          //       controller.selectDateAndTime(context: context);
                          //     })
                        ],
                      ),
                    ),
                  ),

                  /// availability column
                  Obx(() {
                    if (sessionSlotsController.timeSessionSlot.value.results != null &&
                        sessionSlotsController.timeSessionSlot.value.results!.isNotEmpty) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: sessionSlotsController.timeSessionSlot.value.results!.length,
                        itemBuilder: (context, index) {
                          sessionSlotsController.fetchSessionSlots();
                          return Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 10.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 0.8,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${sessionSlotsController.timeSessionSlot.value.results![index].day}",
                                    // 'Session Count: ${entry.count}',
                                    // 'Session count: ${priceController.sessionCount.value}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      getFormattedTimeSlots(sessionSlotsController, index),
                                      // "${sessionSlotsController.timeSessionSlot.value.results![index].times}",
                                      // '\u{2089} ${entry.price}',
                                      // '\u{20B9} ${priceController.sessionPrice.value}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Icon(
                                      Icons.delete_outline_rounded,
                                      color: AppColors.appThemeColor,
                                      size: 20,
                                    ),
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            int id = sessionSlotsController.timeSessionSlot.value.results?[index].id ?? 0;
                                            // int id = priceController.sessionChatPriceModel.value
                                            //     .results!.sessionPrices![index].id ?? 0;
                                            return AlertDialog(
                                              title: Icon(
                                                Icons.warning_amber_rounded,
                                                color:
                                                AppColors.greyColor676464,
                                                size: 50,
                                              ),
                                              content: const Text(
                                                'Are you sure want to delete the session?',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: AppColors
                                                      .blackishTextColor,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              actions: [
                                                Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceEvenly,
                                                  children: [
                                                    TextButton(
                                                      onPressed: () {
                                                        sessionSlotsController
                                                            .deleteSlot(id);
                                                        // chatAvailableController.updateAvailability(false);
                                                        Navigator.pop(context);
                                                      },
                                                      style:
                                                      TextButton.styleFrom(
                                                        backgroundColor:
                                                        AppColors
                                                            .appThemeColor,
                                                        // Set your desired background color
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 32.0,
                                                            vertical:
                                                            8.0), // Adjust padding as needed
                                                      ),
                                                      child: const Text(
                                                        "Yes",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      style:
                                                      TextButton.styleFrom(
                                                        backgroundColor:
                                                        AppColors
                                                            .appThemeColor,
                                                        // Set your desired background color
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 32.0,
                                                            vertical:
                                                            8.0), // Adjust padding as needed
                                                      ),
                                                      child: const Text(
                                                        "No",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            );
                                          });
                                    },
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                      /*return ListView(
                        children: [
                           Text(
                            'Session Slots',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.blackish5E5E5E,
                              fontStyle: FontStyle.italic
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 1.0,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: sessionSlotsController.timeSessionSlot.value.results!.length,
                            itemBuilder: (context, index) {
                              sessionSlotsController.fetchSessionSlots();
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 10.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 0.8,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${sessionSlotsController.timeSessionSlot.value.results![index].day}",
                                        // 'Session Count: ${entry.count}',
                                        // 'Session count: ${priceController.sessionCount.value}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          getFormattedTimeSlots(sessionSlotsController, index),
                                          // "${sessionSlotsController.timeSessionSlot.value.results![index].times}",
                                          // '\u{2089} ${entry.price}',
                                          // '\u{20B9} ${priceController.sessionPrice.value}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        child: Icon(
                                          Icons.delete_outline_rounded,
                                          color: AppColors.appThemeColor,
                                          size: 20,
                                        ),
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                int id = sessionSlotsController.timeSessionSlot.value.results?[index].id ?? 0;
                                                // int id = priceController.sessionChatPriceModel.value
                                                //     .results!.sessionPrices![index].id ?? 0;
                                                return AlertDialog(
                                                  title: Icon(
                                                    Icons.warning_amber_rounded,
                                                    color:
                                                        AppColors.greyColor676464,
                                                    size: 50,
                                                  ),
                                                  content: const Text(
                                                    'Are you sure want to delete the session?',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: AppColors
                                                          .blackishTextColor,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  actions: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        TextButton(
                                                          onPressed: () {
                                                            sessionSlotsController
                                                                .deleteSlot(id);
                                                            // chatAvailableController.updateAvailability(false);
                                                            Navigator.pop(context);
                                                          },
                                                          style:
                                                              TextButton.styleFrom(
                                                            backgroundColor:
                                                                AppColors
                                                                    .appThemeColor,
                                                            // Set your desired background color
                                                            padding: const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 32.0,
                                                                vertical:
                                                                    8.0), // Adjust padding as needed
                                                          ),
                                                          child: const Text(
                                                            "Yes",
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 14),
                                                          ),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(context);
                                                          },
                                                          style:
                                                              TextButton.styleFrom(
                                                            backgroundColor:
                                                                AppColors
                                                                    .appThemeColor,
                                                            // Set your desired background color
                                                            padding: const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 32.0,
                                                                vertical:
                                                                    8.0), // Adjust padding as needed
                                                          ),
                                                          child: const Text(
                                                            "No",
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 14),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                );
                                              });
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );*/
                    }
                    else{
                      return Center(
                        child: Text('No session slots available at the moment...',
                        style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold
                        ),),
                      );
                    }
                  }),
                  /*ListView(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    children: [
                      FutureBuilder<SessionChatPriceModel?>(
                        future: controller.getSessionPrice(),
                        builder: (BuildContext context,
                            AsyncSnapshot<SessionChatPriceModel?> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.data != null &&
                              snapshot.data!.results != null) {
                            return Obx(() => Column(
                              children: [
                                Wrap(
                                  // alignment: WrapAlignment.spaceAround,
                                  spacing: 6.0,
                                  runSpacing: 6.0,
                                  children: [
                                    ...List.generate(
                                        snapshot.data!.results!
                                            .sessionPrices!.length,
                                            (index) => Container(
                                          padding:
                                          const EdgeInsets.all(6.0),
                                          decoration: BoxDecoration(
                                              color:
                                              Colors.teal.shade100,
                                              borderRadius:
                                              BorderRadius.circular(
                                                  12.0)),
                                          child: Row(
                                            mainAxisSize:
                                            MainAxisSize.min,
                                            children: [
                                              Text('Session: ' +
                                                  snapshot
                                                      .data!
                                                      .results!
                                                      .sessionPrices![
                                                  index]
                                                      .sessionCount
                                                      .toString() +
                                                  ' - ' +
                                                  snapshot
                                                      .data!
                                                      .results!
                                                      .sessionPrices![
                                                  index]
                                                      .sessionTime
                                                      .toString() +
                                                  ' min'),
                                              if (controller
                                                  .isUserWantsToEditSlots
                                                  .value)
                                                GestureDetector(
                                                  onTap: () {
                                                    controller
                                                        .timeSlotsSelectedResult
                                                        .value
                                                        .times!
                                                        .remove(controller
                                                        .timeSlotsSelectedResult
                                                        .value
                                                        .times![index]);
                                                    controller
                                                        .timeSlotsSelectedResult
                                                        .refresh();
                                                  },
                                                  child: Container(
                                                    margin:
                                                    EdgeInsets.all(
                                                        2.0),
                                                    decoration:
                                                    BoxDecoration(
                                                      shape: BoxShape
                                                          .circle,
                                                      color: Colors
                                                          .redAccent,
                                                    ),
                                                    child: Icon(
                                                      Icons.close,
                                                      size: 18,
                                                    ),
                                                  ),
                                                )
                                            ],
                                          ),
                                        )),
                                    ...List.generate(
                                        controller.newAddedTimeSlots.length,
                                            (index) => Container(
                                          padding:
                                          const EdgeInsets.all(6.0),
                                          decoration: BoxDecoration(
                                              color:
                                              AppColors.whiteShadow,
                                              border: Border.all(
                                                  width: 0.5,
                                                  color: AppColors
                                                      .bluishColor
                                                      .withOpacity(
                                                      0.5)),
                                              borderRadius:
                                              BorderRadius.circular(
                                                  12.0)),
                                          child: Text(controller
                                              .newAddedTimeSlots[
                                          index]),
                                        )),
                                    if (!controller
                                        .isUserWantsToEditSlots.value)
                                      InkWell(
                                        onTap: () {
                                          String formatTimeRange(
                                              DateTime startTime,
                                              DateTime endTime) {
                                            String formattedStartTime =
                                            DateFormat.jm()
                                                .format(startTime);
                                            String formattedEndTime =
                                            DateFormat.jm()
                                                .format(endTime);

                                            return '$formattedStartTime - $formattedEndTime';
                                          }

                                          // SELECT START DATE.
                                        },
                                        child: Ink(
                                          padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 26.0,
                                              vertical: 6.0),
                                          decoration: BoxDecoration(
                                              color: AppColors.bluishColor,
                                              borderRadius:
                                              BorderRadius.circular(
                                                  12.0)),
                                          child: Text(
                                            'Add Slots',
                                            style: TextStyle(
                                                color:
                                                AppColors.whiteShadow),
                                          ),
                                        ),
                                      )
                                  ],
                                ),
                              ],
                            ));
                          } else {
                            return const Text('not available');
                          }
                        },
                      ),
                      Text(
                        'Today\'s plan',
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color:
                              Colors.tealAccent.shade100.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            child: Row(
                              children: [
                                Text('Session'),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color:
                              Colors.tealAccent.shade100.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            child: Row(
                              children: [
                                Text('Session'),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),*/
                  /*ListView(
                    padding: EdgeInsets.all(6.0),
                    shrinkWrap: true,
                    children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(radius: 25,),
                        Expanded(
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.symmetric(horizontal: 12.0),
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color: Colors.greenAccent.shade100.withOpacity(0.1),
                              border: Border.all(width: 1.0,color: AppColors.appThemeColor.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                        )
                      ],
                    )
                  ],)*/

                  /// feedback column
                  /*Obx(() => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: reviewsController.reviews.map((review) {
                          print('Reviews successfully printed...');
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                  NetworkImage(review.avatar ?? ''),
                                ),
                                title: Text(review.username ?? ''),
                                subtitle: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(review.review ?? ''),
                                    Row(
                                      children: List.generate(
                                          5, (index) => Icon(
                                            Icons.star_rate_rounded,
                                            size: 16,
                                            color: index < (review.ratings ?? 0)
                                                ? Colors.amber
                                                : Colors.grey,
                                          )),
                                    )
                                  ],
                                ),
                              );
                            }).toList(),
                      ))*/
                  Center(
                    child: Text(
                      'Feedback display',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ]),
          ),
        ],
      ),
    );
  }
}
String getFormattedTimeSlots(
    SessionSlotsController sessionSlotsController, int index) {
  String result = "";
  if (sessionSlotsController.timeSessionSlot.value.results![index].times !=
      null) {
    for (int i = 0;
    i <
        sessionSlotsController
            .timeSessionSlot.value.results![index].times!.length;
    i++) {
      result += sessionSlotsController
          .timeSessionSlot.value.results![index].times![i];
      if (i !=
          sessionSlotsController
              .timeSessionSlot.value.results![index].times!.length -
              1) {
        result = "$result\n";
      }
    }
  }
  return result;
}
