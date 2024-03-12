import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gotherepy_doctor/app/appWidgets/text_styles.dart';
import 'package:gotherepy_doctor/app/appWidgets/universalAppBar.dart';
import 'package:gotherepy_doctor/app/modules/chat_page/views/chat_page_view.dart';
import 'package:gotherepy_doctor/app/modules/doctor_profile_page/controllers/doctor_profile_page_controller.dart';
import 'package:gotherepy_doctor/app/modules/doctor_profile_page/controllers/doctor_ratings_controller.dart';
import 'package:gotherepy_doctor/app/modules/doctor_profile_page/controllers/price_controller.dart';
import 'package:gotherepy_doctor/app/modules/doctor_profile_page/controllers/session_slot_controller.dart';
import 'package:gotherepy_doctor/app/modules/doctor_profile_page/controllers/set_availability_controller.dart';
import 'package:gotherepy_doctor/app/modules/doctor_profile_page/model/doctor_ratings.dart';
import 'package:gotherepy_doctor/app/modules/doctor_profile_page/views/profile_chat_page_view.dart';
import 'package:gotherepy_doctor/app/modules/doctor_profile_page/views/profile_preview.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../main.dart';
import '../../../appWidgets/appButtons.dart';
import '../../../app_constants/app_images.dart';
import '../../../app_constants/constants_appColors.dart';
import '../providers/_provider.dart';

class EditProfileView extends GetView<DoctorProfilePageController> {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileProvider _profileProvider = Get.put(ProfileProvider());
    PriceController priceController = Get.put(PriceController());
    AvailabilityController availabilityController =
        Get.put(AvailabilityController());
    ReviewsController reviewsController = Get.put(ReviewsController());
    SessionSlotsController sessionSlotsController =
        Get.put(SessionSlotsController());

    RatingsModel modelController = Get.put(RatingsModel());

    double rating = 3.5;
    int _selectedIndex = 0;

    Future<void> _selectStartTime(BuildContext context) async {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        String formattedTime = pickedTime.format(context);
        sessionSlotsController.startTime = pickedTime;
        sessionSlotsController.startTimeController.text = formattedTime;
        sessionSlotsController.update();
      }
    }

    Future<void> _selectEndTime(BuildContext context) async {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        String formattedTime = pickedTime.format(context);
        sessionSlotsController.endTime = pickedTime;
        sessionSlotsController.endTimeController.text = formattedTime;
        sessionSlotsController.update();
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              size: 18,
            )),
        // leadingWidth: 30,
        titleSpacing: 0,
        flexibleSpace: Container(
          height: 100,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                AppColors.bluishColor,
                AppColors.bluishColor.withOpacity(0.7)
              ]),
              image: DecorationImage(
                  image: AssetImage(AppImages.appbarBackgroundPngImage),
                  fit: BoxFit.fitWidth)),
        ),
        centerTitle: false,
        title: Text(
          '@ ${doctorInfo.records!.username ?? doctorInfo.records!.name!.toLowerCase()}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        children: [
          /// Profile banner
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          // margin: EdgeInsets.all(16.0),
                          constraints: const BoxConstraints(
                              minHeight: 80,
                              minWidth: 80,
                              maxHeight: 80,
                              maxWidth: 80),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                  width: 2.0, color: AppColors.appThemeColor),
                              image: controller.userImagePath.value == ''
                                  ? DecorationImage(
                                      image: NetworkImage(
                                          doctorInfo.records!.avatar!),
                                      fit: BoxFit.fill)
                                  : null),
                          child: controller.userImagePath.value == ''
                              ? null
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(100.0),
                                  child: Image.file(
                                    File(controller.userImagePath.value!),
                                    fit: BoxFit.fill,
                                  )),
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
                                    padding: const EdgeInsets.all(1.0),
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
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dr Devam Joshi',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '@ ${doctorInfo.records!.username ?? doctorInfo.records!.name!.toLowerCase()}',
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),

          /// Abandoned requests
          InkWell(
            child: Container(
              margin: const EdgeInsets.all(6.0),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(2, 3),
                      color: Colors.black26,
                      spreadRadius: 0.3,
                      blurRadius: 5.0,
                    )
                  ]),
              child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Abandoned Requests worth \$0',
                      style: TextStyle(
                          color: AppColors.blackish2D2D2D,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      'You have abandoned chates from \n0 users this month worth \$0',
                      style: TextStyle(
                          color: AppColors.blackish5E5E5E, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            // Implement on tap function
            /*onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(

                      /// TODO: Abandoned request activity call...
                      );
                },
              );
            },*/
          ),

          /// Important policies
          InkWell(
            child: Container(
              margin: const EdgeInsets.all(6.0),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(2, 3),
                      color: Colors.black26,
                      spreadRadius: 0.3,
                      blurRadius: 5.0,
                    )
                  ]),
              child: const ListTile(
                leading: Text(
                  'Important policies',
                  style:
                      TextStyle(color: AppColors.blackish2D2D2D, fontSize: 16),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.blackish2D2D2D,
                  size: 18,
                ),
              ),
            ),
            onTap: () {
              showModalBottomSheet(
                elevation: 5.0,
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Important Policies',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.redishCC0909),
                        ),
                        const SizedBox(height: 10.0),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: const BoxDecoration(
                              color: AppColors.lightTealColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0))),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                '1.Be Kind And Empathetic with the users.',
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                '2.Maintain a safe, confidential atmosphere.',
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                '3.Engage in gentle guidance and problem-solving',
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                '4.Refrain from sharing or requesting personal information',
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                '5.Respect the Gotherapy community guidelines',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        // Add more policy items as needed
                        /// Close button
                        /*SizedBox(height: 10.0),
                        BorderButton(
                          buttonText: "Close",
                          onClick: () {
                            Get.back();
                          },
                        ),*/
                      ],
                    ),
                  );
                },
              );
            },
          ),

          /// Session Availability, Chat and Session slots
          Container(
            margin: const EdgeInsets.all(6.0),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(2, 3),
                    color: Colors.black26,
                    spreadRadius: 0.3,
                    blurRadius: 5.0,
                  )
                ]),
            child: Column(
              children: [
                /// Session Availibility
                ListTile(
                    leading: const Text(
                      "Session Availability",
                      style: TextStyle(
                          color: AppColors.blackish2D2D2D, fontSize: 16),
                    ),

                    /// Alert box for session availability
                    /*onTap: () {
                      bool isCurrentlyOnline =
                          availabilityController.isOnlineSession.value;
                      String confirmationText =
                          'Are You Sure Want To Set Your Self ${isCurrentlyOnline ? 'Offline' : 'Online'} For Sessions ?';
                      Get.dialog(AlertDialog(
                        content: Text(
                          confirmationText,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.blackishTextColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () {
                                  availabilityController
                                      .updateSessionAvailability(
                                      !isCurrentlyOnline);
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: AppColors.appThemeColor,
                                  // Set your desired background color
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32.0,
                                      vertical:
                                      8.0), // Adjust padding as needed
                                ),
                                child: const Text(
                                  "Yes",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.back(); // close dialog
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: AppColors.appThemeColor,
                                  // Set your desired background color
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32.0,
                                      vertical:
                                      8.0), // Adjust padding as needed
                                ),
                                child: const Text(
                                  "No",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),
                            ],
                          )
                        ],
                      ));
                    },*/
                    trailing: Obx(
                      () => Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            availabilityController.isOnlineSession.value
                                ? 'Online'
                                : 'Offline',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.blackishTextColor),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Transform.scale(
                            scale: 0.8,
                            child: Switch(
                              value: availabilityController.isOnlineSession.value,
                              onChanged: (value) {
                                availabilityController
                                    .updateSessionAvailability(value);
                                GetStorage().write('isOnlineSession', value);
                              },
                              activeColor: AppColors
                                  .appThemeColor, // Assuming color is defined
                            ),
                          )
                          // const Icon(
                          //   Icons.arrow_forward_ios,
                          //   color: AppColors.blackish2D2D2D,
                          //   size: 18,
                          // ),
                        ],
                      ),
                    )),
                Divider(
                  height: 0,
                  color: AppColors.blackishTextColor.withOpacity(0.5),
                ),

                /// Chat availability
                ListTile(
                    leading: const Text(
                      "Chat Availability",
                      style: TextStyle(
                          color: AppColors.blackish2D2D2D, fontSize: 16),
                    ),

                    /// Alert box for chat availability
                    /*onTap: () {
                      bool isCurrentlyOnline = availabilityController.isOnlineChat.value;
                      String confirmationText =
                          'Are You Sure Want To Set Your Self ${isCurrentlyOnline ? 'Offline' : 'Online'} For Chat ?';
                      Get.dialog(AlertDialog(
                        content: Text(
                          confirmationText,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.blackishTextColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () {
                                  availabilityController.updateChatAvailability(
                                      !isCurrentlyOnline);
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: AppColors.appThemeColor,
                                  // Set your desired background color
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32.0,
                                      vertical:
                                      8.0), // Adjust padding as needed
                                ),
                                child: const Text(
                                  "Yes",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.back(); // close dialog
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: AppColors.appThemeColor,
                                  // Set your desired background color
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32.0,
                                      vertical:
                                      8.0), // Adjust padding as needed
                                ),
                                child: const Text(
                                  "No",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),
                            ],
                          )
                        ],
                      ));
                    },*/
                    trailing: Obx(
                      () => Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            availabilityController.isOnlineChat.value
                                ? 'Online'
                                : 'Offline',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.blackishTextColor),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Transform.scale(
                            scale: 0.8,
                            child: Switch(
                              value: availabilityController.isOnlineChat.value,
                              onChanged: (value) {
                                availabilityController
                                    .updateChatAvailability(value);
                                GetStorage().write('isOnlineChat', value);
                              },

                              activeColor: AppColors.appThemeColor,
                            ),
                          ),
                          // const Icon(
                          //   Icons.arrow_forward_ios,
                          //   color: AppColors.blackish2D2D2D,
                          //   size: 18,
                          // ),
                        ],
                      ),
                    )),
                Divider(
                  height: 0,
                  color: AppColors.blackishTextColor.withOpacity(0.5),
                ),

                /// Session slots
                ListTile(
                  onTap: () async {
                    print('Session slots :: Onclick()');
                    await sessionSlotsController.fetchSessionSlots();
                    Get.bottomSheet(DraggableScrollableSheet(
                      initialChildSize: 0.8,
                      minChildSize: 0.5,
                      maxChildSize: 1.0,
                      shouldCloseOnMinExtent: true,
                      builder: (BuildContext context,
                          ScrollController scrollController) {
                        return Container(
                          decoration: BoxDecoration(
                            color: AppColors.whiteShadow,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                          ),
                          padding: const EdgeInsets.all(16.0),
                          child: ListView(
                            controller: scrollController,
                            children: [
                              const Text(
                                'Set Session Slots',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              const Text("Day"),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller:
                                    sessionSlotsController.dayController,
                                decoration: InputDecoration(
                                  label: const Text('Enter day here'),
                                  hintText: 'Enter day',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              const Text("Time Range"),
                              const SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      onTap: () => _selectStartTime(context),
                                      controller: sessionSlotsController
                                          .startTimeController,
                                      // controller: sessionController.startTimeController,
                                      decoration: InputDecoration(
                                        label: const Text('Start time'),
                                        hintText: 'Start time',
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.black,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      onTap: () => _selectEndTime(context),
                                      controller: sessionSlotsController
                                          .endTimeController,
                                      decoration: InputDecoration(
                                        label: const Text('End time'),
                                        hintText: 'End time',
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.black,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              CustomSolidButton(
                                onClick: () {
                                  // adding entry to the list
                                  sessionSlotsController
                                      .addSlots(context)
                                      .whenComplete(() {
                                    context.loaderOverlay.hide();
                                    print(
                                        'Add Session slots :: Received Slot...');
                                    // Get.back();
                                  });
                                },
                                buttonText: 'Add Session Slot',
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              const Text(
                                'Added Slots',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Obx(
                                () => ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: sessionSlotsController
                                      .timeSessionSlot.value.results!.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 8.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 0.8,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
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
                                                getFormattedTimeSlots(
                                                    sessionSlotsController,
                                                    index),
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
                                                      int id =
                                                          sessionSlotsController
                                                                  .timeSessionSlot
                                                                  .value
                                                                  .results?[
                                                                      index]
                                                                  .id ??
                                                              0;
                                                      // int id = priceController.sessionChatPriceModel.value
                                                      //     .results!.sessionPrices![index].id ?? 0;
                                                      return AlertDialog(
                                                        title: Icon(
                                                          Icons
                                                              .warning_amber_rounded,
                                                          color: AppColors
                                                              .greyColor676464,
                                                          size: 50,
                                                        ),
                                                        content: const Text(
                                                          'Are you sure want to delete the session?',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: AppColors
                                                                .blackishTextColor,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        actions: [
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  sessionSlotsController
                                                                      .deleteSlot(
                                                                          id);
                                                                  // chatAvailableController.updateAvailability(false);
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                style: TextButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                      AppColors
                                                                          .appThemeColor,
                                                                  // Set your desired background color
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          32.0,
                                                                      vertical:
                                                                          8.0), // Adjust padding as needed
                                                                ),
                                                                child:
                                                                    const Text(
                                                                  "Yes",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          14),
                                                                ),
                                                              ),
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                style: TextButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                      AppColors
                                                                          .appThemeColor,
                                                                  // Set your desired background color
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          32.0,
                                                                      vertical:
                                                                          8.0), // Adjust padding as needed
                                                                ),
                                                                child:
                                                                    const Text(
                                                                  "No",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          14),
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
                              ),
                              /*Container(
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

                                    // Expanded(child: Text(selectedDay)),
                                    // Expanded(
                                    //     child: Text('$startTime - $endTime')),
                                    GestureDetector(
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            child: Icon(
                                              Icons.edit_rounded,
                                              color: AppColors.appThemeColor,
                                              size: 20,
                                            ),

                                            /// TODO: set edit dialog code here
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      content: const Text(
                                                        'Edit your session slot here...',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color: AppColors
                                                              .blackishTextColor,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            // chatAvailableController.updateAvailability(false);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          style: TextButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                AppColors
                                                                    .appThemeColor,
                                                            // Set your desired background color
                                                            padding: const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    32.0,
                                                                vertical:
                                                                    8.0), // Adjust padding as needed
                                                          ),
                                                          child: const Text(
                                                            "Yes",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 14),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  });
                                            },
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
                                                    return AlertDialog(
                                                      title: Icon(
                                                        Icons
                                                            .warning_amber_rounded,
                                                        color: AppColors
                                                            .greyColor676464,
                                                        size: 50,
                                                      ),
                                                      content: const Text(
                                                        'Are you sure want to delete the session?',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color: AppColors
                                                              .blackishTextColor,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      actions: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize
                                                                  .max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            TextButton(
                                                              onPressed: () {
                                                                // chatAvailableController.updateAvailability(false);
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              style: TextButton
                                                                  .styleFrom(
                                                                backgroundColor:
                                                                    AppColors
                                                                        .appThemeColor,
                                                                // Set your desired background color
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        32.0,
                                                                    vertical:
                                                                        8.0), // Adjust padding as needed
                                                              ),
                                                              child:
                                                                  const Text(
                                                                "Yes",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              style: TextButton
                                                                  .styleFrom(
                                                                backgroundColor:
                                                                    AppColors
                                                                        .appThemeColor,
                                                                // Set your desired background color
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        32.0,
                                                                    vertical:
                                                                        8.0), // Adjust padding as needed
                                                              ),
                                                              child:
                                                                  const Text(
                                                                "No",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    );
                                                  });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),*/
                            ],
                          ),
                        );
                      },
                    )).whenComplete(() {
                      // clearing fields
                      sessionSlotsController.dayController.text = "";
                      sessionSlotsController.startTimeController.text = "";
                      sessionSlotsController.endTimeController.text = "";

                      // clearing variables
                      sessionSlotsController.selectedDay.value = "";
                      // sessionSlotsController._startTime.value = "";
                      // sessionSlotsController._endTime.value = "";
                    });

                    /*.whenComplete(() {
                      sessionController.selectedDay.value = "";
                      sessionController.startTime.value =
                          const TimeOfDay(hour: 0, minute: 0);
                      sessionController.endTime.value =
                          const TimeOfDay(hour: 0, minute: 0);
                    });*/
                  },
                  leading: const Text(
                    'Session Slots',
                    style: TextStyle(
                        color: AppColors.blackish2D2D2D, fontSize: 16),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.blackish2D2D2D,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),

          /// Session & Chat prices
          Container(
            margin: const EdgeInsets.all(6.0),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(2, 3),
                    color: Colors.black26,
                    spreadRadius: 0.3,
                    blurRadius: 5.0,
                  )
                ]),
            child: Column(
              children: [
                /// session price
                ListTile(
                  onTap: () {
                    priceController.getSessionPrice();
                    Get.bottomSheet(DraggableScrollableSheet(
                      initialChildSize: 0.8,
                      minChildSize: 0.5,
                      shouldCloseOnMinExtent: true,
                      builder: (BuildContext context,
                          ScrollController scrollController) {
                        return Container(
                          decoration: BoxDecoration(
                            color: AppColors.whiteShadow,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                          ),
                          padding: const EdgeInsets.all(16.0),
                          child: ListView(
                            controller: scrollController,
                            children: [
                              const Text(
                                'Set Session Prices',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Row(
                                children: [
                                  Text("Session Count"),
                                  SizedBox(
                                    width: 100,
                                  ),
                                  Text("Session Price"),
                                ],
                              ),
                              const SizedBox(height: 5.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: priceController
                                          .sessionCountController,
                                      decoration: InputDecoration(
                                        label: const Text(
                                          'Enter Count Here',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        hintText: 'Count',
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.black,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      controller: priceController
                                          .sessionPriceController,
                                      decoration: InputDecoration(
                                        label: const Text(
                                          'Enter Price Here',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        hintText: 'Price',
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.black,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20.0),
                              const Row(
                                children: [
                                  Text("Discount"),
                                  SizedBox(
                                    width: 150,
                                  ),
                                  Text("Session Time"),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller:
                                          priceController.discountPerController,
                                      decoration: InputDecoration(
                                        label: const Text(
                                          'Enter Discount Here',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        hintText: 'Discount',
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.black,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      controller:
                                          priceController.sessionTimeController,
                                      decoration: InputDecoration(
                                        label: const Text(
                                          'Enter Session Time',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        hintText: 'Session Time',
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.black,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              CustomSolidButton(
                                onClick: () {
                                  // adding entry to the list
                                  // sessionEntries.add(SessionEntry
                                  //   (count: priceController.sessionCount.value,
                                  //     price: priceController.sessionPrice.value));

                                  priceController
                                      .addSessionPriceMethod()
                                      .whenComplete(() {
                                    context.loaderOverlay.hide();
                                    print("Received Data...");
                                    // Get.back();
                                  });
                                },
                                buttonText: 'Add Session Price',
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),

                              /// Display saved slots
                              const Text(
                                'Added Slots',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Obx(
                                () => ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: priceController
                                      .sessionChatPriceModel
                                      .value
                                      .results!
                                      .sessionPrices!
                                      .length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 8.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 0.8,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(15.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Session Count: ${priceController.sessionChatPriceModel.value.results!.sessionPrices![index].sessionCount!}",
                                              // 'Session Count: ${entry.count}',
                                              // 'Session count: ${priceController.sessionCount.value}',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "₹ ${priceController.sessionChatPriceModel.value.results!.sessionPrices![index].sessionPrice!}",
                                              // '\u{2089} ${entry.price}',
                                              // '\u{20B9} ${priceController.sessionPrice.value}',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  child: Icon(
                                                    Icons.edit,
                                                    color:
                                                        AppColors.appThemeColor,
                                                    size: 20,
                                                  ),
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            elevation: 4.0,
                                                            title: Icon(
                                                              Icons
                                                                  .info_outline_rounded,
                                                              color: AppColors
                                                                  .greyColor676464,
                                                              size: 50,
                                                            ),
                                                            content:
                                                                SingleChildScrollView(
                                                              child: Container(
                                                                width: double
                                                                    .maxFinite,
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height /
                                                                    2.5,
                                                                child: Column(
                                                                  children: [
                                                                    Text16by600(
                                                                        text:
                                                                            'Edit Session Details'),
                                                                    TextFormField(
                                                                      controller:
                                                                          priceController
                                                                              .updatedSessionCountController,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        labelText:
                                                                            'Update Count',
                                                                        hintText: priceController
                                                                            .editSessionPriceModel
                                                                            .value
                                                                            .results
                                                                            ?.sessionCount,
                                                                        hintStyle:
                                                                            TextStyle(fontWeight: FontWeight.w500),
                                                                      ),
                                                                      // initialValue: priceController.sessionChatPriceModel.value.results!.sessionPrices![index].sessionCount.toString(),
                                                                    ),
                                                                    TextFormField(
                                                                      controller:
                                                                          priceController
                                                                              .updatedSessionPriceController,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        labelText:
                                                                            'Update Price',
                                                                        hintText: priceController
                                                                            .editSessionPriceModel
                                                                            .value
                                                                            .results
                                                                            ?.sessionPrice,
                                                                        hintStyle:
                                                                            TextStyle(fontWeight: FontWeight.w500),
                                                                      ),
                                                                      // initialValue: priceController.sessionChatPriceModel.value.results!.sessionPrices![index].sessionPrice.toString(),
                                                                    ),
                                                                    TextFormField(
                                                                      controller:
                                                                          priceController
                                                                              .updatedSessionTimeController,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        labelText:
                                                                            'Update Duration',
                                                                        hintText: priceController
                                                                            .editSessionPriceModel
                                                                            .value
                                                                            .results
                                                                            ?.sessionTime,
                                                                        hintStyle:
                                                                            TextStyle(fontWeight: FontWeight.w500),
                                                                      ),
                                                                      // initialValue: priceController.sessionChatPriceModel.value.results!.sessionPrices![index].sessionTime.toString(),
                                                                    ),
                                                                    TextFormField(
                                                                      controller:
                                                                          priceController
                                                                              .updatedSessionDiscountController,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        labelText:
                                                                            'Update Discount Percentage',
                                                                        hintText: priceController
                                                                            .editSessionPriceModel
                                                                            .value
                                                                            .results
                                                                            ?.discountPercentage,
                                                                        hintStyle:
                                                                            TextStyle(fontWeight: FontWeight.w500),
                                                                      ),
                                                                      // initialValue: priceController.sessionChatPriceModel.value.results!.sessionPrices![index].sessionTime.toString(),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            actions: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  CustomSolidButton(
                                                                      buttonText:
                                                                          'Update Session',
                                                                      onClick:
                                                                          () async {
                                                                        // implement onclick event
                                                                        String id = doctorInfo
                                                                            .records!
                                                                            .doctorId!
                                                                            .toString();
                                                                        await priceController
                                                                            .updateSessionPriceMethod(id)
                                                                            .then((_) {
                                                                          print(
                                                                              'Update session view called...');
                                                                          Navigator.pop(
                                                                              context);
                                                                          // Get.back();
                                                                        });
                                                                        // priceController
                                                                        //     .updateSessionPriceMethod(doctorInfo.records!.doctorId ?? 0)
                                                                        //     .whenComplete(() {
                                                                        //   context.loaderOverlay.hide();
                                                                        //   print("Received Updated session Data...");
                                                                        // });
                                                                        //   Get.back();
                                                                      }),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  CustomSolidButton(
                                                                      buttonText:
                                                                          'Cancel',
                                                                      onClick:
                                                                          () {
                                                                        Get.back();
                                                                      })
                                                                ],
                                                              )
                                                            ],
                                                          );
                                                        });
                                                  },
                                                ),
                                                GestureDetector(
                                                  child: Icon(
                                                    Icons
                                                        .delete_outline_rounded,
                                                    color:
                                                        AppColors.appThemeColor,
                                                    size: 20,
                                                  ),
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          int id = priceController
                                                                  .sessionChatPriceModel
                                                                  .value
                                                                  .results!
                                                                  .sessionPrices![
                                                                      index]
                                                                  .id ??
                                                              0;
                                                          return AlertDialog(
                                                            title: Icon(
                                                              Icons
                                                                  .warning_amber_rounded,
                                                              color: AppColors
                                                                  .greyColor676464,
                                                              size: 50,
                                                            ),
                                                            content: const Text(
                                                              'Are you sure want to delete the session?',
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                color: AppColors
                                                                    .blackishTextColor,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                            actions: [
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  TextButton(
                                                                    onPressed:
                                                                        () async {
                                                                      // chatAvailableController.updateAvailability(false);
                                                                      priceController
                                                                          .deleteSession(
                                                                              id);
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    style: TextButton
                                                                        .styleFrom(
                                                                      backgroundColor:
                                                                          AppColors
                                                                              .appThemeColor,
                                                                      // Set your desired background color
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              32.0,
                                                                          vertical:
                                                                              8.0), // Adjust padding as needed
                                                                    ),
                                                                    child:
                                                                        const Text(
                                                                      "Yes",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    style: TextButton
                                                                        .styleFrom(
                                                                      backgroundColor:
                                                                          AppColors
                                                                              .appThemeColor,
                                                                      // Set your desired background color
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              32.0,
                                                                          vertical:
                                                                              8.0), // Adjust padding as needed
                                                                    ),
                                                                    child:
                                                                        const Text(
                                                                      "No",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          );
                                                        });
                                                  },
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              // for(var entry in sessionEntries)
                            ],
                          ),
                        );
                      },
                    )).whenComplete(() {
                      // clearing fields
                      priceController.sessionCountController.text = "";
                      priceController.sessionTimeController.text = "";
                      priceController.sessionPriceController.text = "";
                      priceController.discountPerController.text = "";

                      priceController.updatedSessionCountController.text = "";
                      priceController.updatedSessionTimeController.text = "";
                      priceController.updatedSessionPriceController.text = "";
                      priceController.updatedSessionDiscountController.text =
                          "";

                      // clearing variables
                      priceController.sessionPrice.value = "";
                      priceController.sessionTime.value = "";
                      priceController.sessionCount.value = "";
                      priceController.discountPercentage.value = "";

                      priceController.updatedSessionCount.value = "";
                      priceController.updatedSessionPrice.value = "";
                      priceController.updatedSessionTime.value = "";
                      priceController.updatedDiscountPercentage.value = "";
                    });
                  },
                  leading: const Text(
                    'Session Prices',
                    style: TextStyle(
                        color: AppColors.blackish2D2D2D, fontSize: 16),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.blackish2D2D2D,
                    size: 18,
                  ),
                ),
                Divider(
                  height: 0,
                  color: AppColors.blackishTextColor.withOpacity(0.5),
                ),

                /// chat price
                ListTile(
                  onTap: () {
                    priceController.getChatPrice();
                    Get.bottomSheet(DraggableScrollableSheet(
                        initialChildSize: 0.8,
                        minChildSize: 0.5,
                        shouldCloseOnMinExtent: true,
                        builder: (BuildContext context,
                            ScrollController scrollController) {
                          return Container(
                            decoration: BoxDecoration(
                              color: AppColors.whiteShadow,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                            ),
                            padding: const EdgeInsets.all(16.0),
                            child: ListView(
                              controller: scrollController,
                              children: [
                                const Text(
                                  'Set Chat Price',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text("Chat Price"),
                                const SizedBox(height: 10.0),
                                TextFormField(
                                  controller:
                                      priceController.chatPriceController,
                                  decoration: InputDecoration(
                                    label: const Text(
                                      'Enter Price Here',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    hintText: 'Price',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                const Row(
                                  children: [
                                    Text("Discount"),
                                    SizedBox(
                                      width: 150,
                                    ),
                                    Text("Chat Time"),
                                  ],
                                ),
                                const SizedBox(height: 10.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: priceController
                                            .chatDiscountController,
                                        decoration: InputDecoration(
                                          label: const Text(
                                            'Enter Discount Here',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          hintText: 'Discount',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.black,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.red,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        controller:
                                            priceController.chatTimeController,
                                        decoration: InputDecoration(
                                          label: const Text(
                                            'Enter Chat Time',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          hintText: 'Chat Time',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.black,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.red,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10.0),
                                CustomSolidButton(
                                  onClick: () {
                                    // chatEntries.add(ChatEntry(
                                    //   time: priceController.chatTime.value,
                                    //   price: priceController.chatPrice.value,
                                    // ));

                                    priceController
                                        .addChatPriceMethod()
                                        .whenComplete(() {
                                      context.loaderOverlay.hide();
                                      print("Received Data...");
                                      // Get.back();
                                    });
                                  },
                                  buttonText: 'Add Chat Price',
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),

                                /// Display added chats
                                const Text(
                                  'Added Slots',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Obx(() => ListView.builder(
                                      controller: scrollController,
                                      shrinkWrap: true,
                                      itemCount: priceController
                                          .sessionChatPriceModel
                                          .value
                                          .results!
                                          .chatPrices!
                                          .length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 0.8,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    // Center align
                                                    children: [
                                                      // Text('Time: ${entry.time} min'
                                                      Text(
                                                        'Time: ${priceController.sessionChatPriceModel.value.results!.chatPrices![index].sessionTime} min',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      // Text('\u{2089} ${entry.price}'),
                                                      Text(
                                                        '₹ ${priceController.sessionChatPriceModel.value.results!.chatPrices![index].chatSessionPrice}',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 20)),
                                                      GestureDetector(
                                                        child: Icon(
                                                          Icons.edit,
                                                          color: AppColors
                                                              .appThemeColor,
                                                          size: 20,
                                                        ),
                                                        onTap: () {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return AlertDialog(
                                                                  elevation:
                                                                      4.0,
                                                                  title: Icon(
                                                                    Icons
                                                                        .info_outline_rounded,
                                                                    color: AppColors
                                                                        .greyColor676464,
                                                                    size: 50,
                                                                  ),
                                                                  content:
                                                                      SingleChildScrollView(
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .maxFinite,
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .height /
                                                                          2.5,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Text16by600(
                                                                              text: 'Edit Chat Details'),
                                                                          /*TextFormField(
                                                                            controller: priceController.sessionCountController,
                                                                            decoration: InputDecoration(
                                                                              labelText: 'Update Count',
                                                                              hintText: priceController.sessionChatPriceModel.value.results!.chatPrices![index].toString(),
                                                                              hintStyle: TextStyle(fontWeight: FontWeight.w500),
                                                                            ),
                                                                            // initialValue: priceController.sessionChatPriceModel.value.results!.sessionPrices![index].sessionCount.toString(),
                                                                          ),*/
                                                                          TextFormField(
                                                                            controller:
                                                                                priceController.updatedChatPriceController,
                                                                            decoration:
                                                                                InputDecoration(
                                                                              labelText: 'Update Price',
                                                                              hintStyle: TextStyle(fontWeight: FontWeight.w500),
                                                                            ),
                                                                            // initialValue: priceController.sessionChatPriceModel.value.results!.sessionPrices![index].sessionPrice.toString(),
                                                                          ),
                                                                          TextFormField(
                                                                            controller:
                                                                                priceController.updatedChatCountController,
                                                                            decoration:
                                                                                InputDecoration(
                                                                              labelText: 'Update Count',
                                                                              hintText: priceController.sessionChatPriceModel.value.results!.chatPrices![index].id.toString(),
                                                                              hintStyle: TextStyle(fontWeight: FontWeight.w500),
                                                                            ),
                                                                            // initialValue: priceController.sessionChatPriceModel.value.results!.sessionPrices![index].sessionPrice.toString(),
                                                                          ),
                                                                          TextFormField(
                                                                            controller:
                                                                                priceController.updatedChatTimeController,
                                                                            decoration:
                                                                                InputDecoration(
                                                                              labelText: 'Update Duration',
                                                                              hintText: priceController.sessionChatPriceModel.value.results!.chatPrices![index].sessionTime.toString(),
                                                                              hintStyle: TextStyle(fontWeight: FontWeight.w500),
                                                                            ),
                                                                            // initialValue: priceController.sessionChatPriceModel.value.results!.sessionPrices![index].sessionTime.toString(),
                                                                          ),
                                                                          TextFormField(
                                                                            controller:
                                                                                priceController.updatedChatDiscountController,
                                                                            decoration:
                                                                                InputDecoration(
                                                                              labelText: 'Update Discount',
                                                                              hintStyle: TextStyle(fontWeight: FontWeight.w500),
                                                                            ),
                                                                            // initialValue: priceController.sessionChatPriceModel.value.results!.sessionPrices![index].sessionPrice.toString(),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  actions: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        CustomSolidButton(
                                                                            buttonText:
                                                                                'Update Chat',
                                                                            onClick:
                                                                                () async {
                                                                              // implement onclick event
                                                                              String id = doctorInfo.records!.doctorId.toString();
                                                                              print(id);
                                                                              await priceController.updateChatPriceMethod(id).then((_) {
                                                                                print('Update chat view called...');
                                                                                Navigator.pop(context);
                                                                                // Get.back();
                                                                              });
                                                                              // priceController
                                                                              //     .updateSessionPriceMethod(doctorInfo.records!.doctorId ?? 0)
                                                                              //     .whenComplete(() {
                                                                              //   context.loaderOverlay.hide();
                                                                              //   print("Received Updated session Data...");
                                                                              // });
                                                                              //   Get.back();
                                                                            }),
                                                                        SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        CustomSolidButton(
                                                                            buttonText:
                                                                                'Cancel',
                                                                            onClick:
                                                                                () {
                                                                              Get.back();
                                                                            })
                                                                      ],
                                                                    )
                                                                  ],
                                                                );
                                                              });
                                                        },
                                                      ),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 2)),
                                                      GestureDetector(
                                                        child: Icon(
                                                          Icons
                                                              .delete_outline_rounded,
                                                          color: AppColors
                                                              .appThemeColor,
                                                          size: 20,
                                                        ),
                                                        onTap: () {
                                                          int id = priceController
                                                                  .sessionChatPriceModel
                                                                  .value
                                                                  .results!
                                                                  .chatPrices![
                                                                      index]
                                                                  .id ??
                                                              0;
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return AlertDialog(
                                                                  title: Icon(
                                                                    Icons
                                                                        .warning_amber_rounded,
                                                                    color: AppColors
                                                                        .greyColor676464,
                                                                    size: 50,
                                                                  ),
                                                                  content:
                                                                      const Text(
                                                                    'Are you sure want to delete the session?',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      color: AppColors
                                                                          .blackishTextColor,
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                  actions: [
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            priceController.deleteChat(id);
                                                                            // chatAvailableController.updateAvailability(false);
                                                                            Navigator.pop(context);
                                                                          },
                                                                          style:
                                                                              TextButton.styleFrom(
                                                                            backgroundColor:
                                                                                AppColors.appThemeColor,
                                                                            // Set your desired background color
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0), // Adjust padding as needed
                                                                          ),
                                                                          child:
                                                                              const Text(
                                                                            "Yes",
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontSize: 14),
                                                                          ),
                                                                        ),
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          style:
                                                                              TextButton.styleFrom(
                                                                            backgroundColor:
                                                                                AppColors.appThemeColor,
                                                                            // Set your desired background color
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0), // Adjust padding as needed
                                                                          ),
                                                                          child:
                                                                              const Text(
                                                                            "No",
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontSize: 14),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                );
                                                              });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    )),
                              ],
                            ),
                          );
                        })).whenComplete(() {
                      // Clear the form fields
                      priceController.chatDiscountController.text = "";
                      priceController.chatTimeController.text = "";
                      priceController.chatPriceController.text = "";

                      // Clear the observable values
                      priceController.chatPrice.value = "";
                      priceController.chatDiscount.value = "";
                      priceController.chatTime.value = "";
                    });
                  },
                  leading: const Text(
                    'Chat Prices',
                    style: TextStyle(
                        color: AppColors.blackish2D2D2D, fontSize: 16),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.blackish2D2D2D,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),

          /// Earning, Reviews, Profile preview
          Container(
            margin: const EdgeInsets.all(6.0),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(2, 3),
                    color: Colors.black26,
                    spreadRadius: 0.3,
                    blurRadius: 5.0,
                  )
                ]),
            child: Column(
              children: [
                /// earnings
                ListTile(
                  /*onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Set Availability',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            controller.isUserWantsToEditSlots
                                                .toggle();
                                          },
                                          style: TextButton.styleFrom(
                                              backgroundColor: AppColors
                                                  .appThemeColor
                                                  .withOpacity(0.3)),
                                          child: Obx(() => Text(
                                                'Edit',
                                                style: TextStyle(
                                                    color: controller
                                                            .isUserWantsToEditSlots
                                                            .value
                                                        ? AppColors.greenColor
                                                        : AppColors
                                                            .lightGreyTextColor,
                                                    fontSize: 14,
                                                    fontWeight: controller
                                                            .isUserWantsToEditSlots
                                                            .value
                                                        ? FontWeight.w900
                                                        : FontWeight.w400),
                                              ))),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              const Text("Select Day:"),
                              FutureBuilder<TimeSlots>(
                                  future:
                                      ProfileProvider().fetchAvailableSlots(),
                                  builder: (context, snapData) {
                                    if (snapData.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else if (snapData.data!.results != null &&
                                        snapData.data!.results!.isNotEmpty) {
                                      controller.timeSlotsSelectedResult.value =
                                          snapData.data!.results![0];
                                      return Obx(() => Column(
                                            children: [
                                              SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  children: <Widget>[
                                                    for (var weekday in snapData
                                                        .data!.results!)
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(6.0),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            controller
                                                                .newAddedTimeSlots
                                                                .clear();
                                                            controller
                                                                .timeSlotsSelectedResult
                                                                .value = weekday;
                                                            controller.update();
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        15.0,
                                                                    vertical:
                                                                        8),
                                                            // Add padding for better visualization
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: controller.timeSlotsSelectedResult.value ==
                                                                            weekday
                                                                        ? Colors
                                                                            .grey
                                                                        : Colors
                                                                            .grey
                                                                            .shade200),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12)),
                                                            child: Text(weekday
                                                                .day
                                                                .toString()),
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ));
                                    } else {
                                      return const Text('Not available');
                                    }
                                  }),
                              const SizedBox(height: 10.0),
                              Obx(() => CustomSolidButton(
                                    onClick: () {
                                      if (controller
                                          .isUserWantsToEditSlots.value) {
                                        context.loaderOverlay.show();
                                        controller
                                            .editSlots(
                                                updateSlots: controller
                                                    .timeSlotsSelectedResult
                                                    .value)
                                            .whenComplete(() {
                                          context.loaderOverlay.hide();
                                          Get.back();
                                        });
                                      } else {
                                        controller.addSlots().whenComplete(() {
                                          context.loaderOverlay.hide();
                                          Get.back();
                                        });
                                      }
                                    },
                                    buttonText:
                                        controller.isUserWantsToEditSlots.value
                                            ? 'Update'
                                            : 'Add Slots',
                                  )),
                            ],
                          ),
                        );
                      },
                    ).whenComplete(() {
                      controller.selectedWeekday.value = "";
                      controller.startTime.value =
                          const TimeOfDay(hour: 0, minute: 0);
                      controller.endTime.value =
                          const TimeOfDay(hour: 0, minute: 0);
                    });
                  },*/
                  leading: const Text(
                    'Earning from Paid Chats',
                    style: TextStyle(
                        color: AppColors.blackish2D2D2D, fontSize: 16),
                  ),
                  trailing: const Text(
                    '\$1650.0',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blackishTextColor),
                  ),
                ),
                Divider(
                  height: 0,
                  color: AppColors.blackishTextColor.withOpacity(0.5),
                ),

                /// reviews & ratings
                ListTile(
                  onTap: () {
                    showBottomSheet(
                        context: context,
                        builder: (context) {
                          return DraggableScrollableSheet(
                              builder: (context, scrollController) {
                            return Container(
                              // height: Get.height / 2,
                              padding: const EdgeInsets.all(16.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    const Text(
                                      'Reviews',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    /*Obx(() => ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: reviewsController
                                                  .ratingsModel
                                                  .value
                                                  .results
                                                  ?.length ??
                                              0,
                                          itemBuilder: (context, index) {
                                            int doctorId = reviewsController
                                                    .ratingsModel
                                                    .value
                                                    .results![index]
                                                    .id ??
                                                0;
                                            reviewsController
                                                .fetchReviews(doctorId);
                                            var result = reviewsController
                                                .ratingsModel
                                                .value
                                                .results?[index];
                                            if (result != null) {
                                              return Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Stack(
                                                            children: [
                                                              Container(
                                                                // margin: EdgeInsets.all(16.0),
                                                                constraints:
                                                                    const BoxConstraints(
                                                                        minHeight:
                                                                            40,
                                                                        minWidth:
                                                                            40,
                                                                        maxHeight:
                                                                            40,
                                                                        maxWidth:
                                                                            40),
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Colors
                                                                        .white,
                                                                    border: Border.all(
                                                                        width:
                                                                            2.0,
                                                                        color: AppColors
                                                                            .appThemeColor),
                                                                    image: reviewsController.avatar.value ==
                                                                            ''
                                                                        ? DecorationImage(
                                                                            image:
                                                                                NetworkImage(reviewsController.avatar.value),
                                                                            fit: BoxFit.fill)
                                                                        : null),
                                                                child: reviewsController
                                                                            .avatar
                                                                            .value ==
                                                                        ''
                                                                    ? null
                                                                    : ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                100.0),
                                                                        child: Image
                                                                            .file(
                                                                          File(reviewsController
                                                                              .avatar
                                                                              .value),
                                                                          fit: BoxFit
                                                                              .fill,
                                                                        )),
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        20,
                                                                    vertical:
                                                                        10),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  reviewsController
                                                                      .username
                                                                      .value,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                                Text(
                                                                  reviewsController
                                                                      .date
                                                                      .value,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),

                                                      /// star ratings
                                                      Obx(
                                                        () => Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          // Ensure compact layout
                                                          children: [
                                                            for (int i = 0;
                                                                i < 5;
                                                                i++)
                                                              Icon(
                                                                Icons.star,
                                                                size: 16,
                                                                color: i <
                                                                        reviewsController
                                                                            .rating
                                                                            .value
                                                                    ? Colors
                                                                        .amber
                                                                    : Colors
                                                                        .grey,
                                                              ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        reviewsController
                                                            .review.value,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: AppColors
                                                                .blackishTextColor),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              );
                                            } else {
                                              return Center(
                                                child: Container(
                                                  child: Text(
                                                      "No reviews to display"),
                                                ),
                                              );
                                            }
                                          },
                                        )),*/
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Divider(
                                      height: 0,
                                      color: AppColors.blackishTextColor
                                          .withOpacity(0.8),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                        });
                    Get.bottomSheet(Material(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      child: Container(
                        height: Get.height / 2,
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                'Reviews',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Obx(() => ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: reviewsController.ratingsModel
                                            .value.results?.length ??
                                        0,
                                    itemBuilder: (context, index) {
                                      int doctorId = reviewsController
                                              .ratingsModel
                                              .value
                                              .results![index]
                                              .id ??
                                          0;
                                      reviewsController.fetchReviews(doctorId);
                                      var result = reviewsController
                                          .ratingsModel.value.results?[index];
                                      if (result != null) {
                                        return Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        Container(
                                                          // margin: EdgeInsets.all(16.0),
                                                          constraints:
                                                              const BoxConstraints(
                                                                  minHeight: 40,
                                                                  minWidth: 40,
                                                                  maxHeight: 40,
                                                                  maxWidth: 40),
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color:
                                                                  Colors.white,
                                                              border: Border.all(
                                                                  width: 2.0,
                                                                  color: AppColors
                                                                      .appThemeColor),
                                                              image: reviewsController
                                                                          .avatar
                                                                          .value ==
                                                                      ''
                                                                  ? DecorationImage(
                                                                      image: NetworkImage(reviewsController
                                                                          .avatar
                                                                          .value),
                                                                      fit: BoxFit
                                                                          .fill)
                                                                  : null),
                                                          child: reviewsController
                                                                      .avatar
                                                                      .value ==
                                                                  ''
                                                              ? null
                                                              : ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              100.0),
                                                                  child: Image
                                                                      .file(
                                                                    File(reviewsController
                                                                        .avatar
                                                                        .value),
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  )),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 20,
                                                              vertical: 10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            reviewsController
                                                                .username.value,
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                          Text(
                                                            reviewsController
                                                                .date.value,
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),

                                                /// star ratings
                                                Obx(
                                                  () => Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    // Ensure compact layout
                                                    children: [
                                                      for (int i = 0;
                                                          i < 5;
                                                          i++)
                                                        Icon(
                                                          Icons.star,
                                                          size: 16,
                                                          color: i <
                                                                  reviewsController
                                                                      .rating
                                                                      .value
                                                              ? Colors.amber
                                                              : Colors.grey,
                                                        ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  reviewsController
                                                      .review.value,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: AppColors
                                                          .blackishTextColor),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      } else {
                                        return Center(
                                          child: Container(
                                            child:
                                                Text("No reviews to display"),
                                          ),
                                        );
                                      }
                                    },
                                  )),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Divider(
                                height: 0,
                                color: AppColors.blackishTextColor
                                    .withOpacity(0.8),
                              )
                            ],
                          ),
                        ),
                      ),
                    ));
                  },
                  leading: const Text(
                    'Reviews',
                    style: TextStyle(
                        color: AppColors.blackish2D2D2D, fontSize: 16),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.blackish2D2D2D,
                    size: 18,
                  ),
                ),
                Divider(
                  height: 0,
                  color: AppColors.blackishTextColor.withOpacity(0.5),
                ),
                ListTile(
                  onTap: () {
                    Get.to(const ProfilePreviewView());
                  },
                  leading: const Text(
                    'Profile Preview',
                    style: TextStyle(
                        color: AppColors.blackish2D2D2D, fontSize: 16),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.blackish2D2D2D,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(6.0),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(2, 3),
                    color: Colors.black26,
                    spreadRadius: 0.3,
                    blurRadius: 5.0,
                  )
                ]),
            child: const Column(
              children: [
                ListTile(
                  leading: Text(
                    'Number of Paid Chats',
                    style: TextStyle(
                        color: AppColors.blackish2D2D2D, fontSize: 16),
                  ),
                  trailing: Text(
                    '13',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blackishTextColor),
                  ),
                )
              ],
            ),
          ),
        ],
      ),

      /// Remove this and import custom edit profile nav bar created
      // bottomNavigationBar: EditProfileBottomNavBar(),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_2_rounded,
                size: 16,
              ),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.chat_rounded,
                size: 16,
              ),
              label: 'Chat',
            ),
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: AppColors.greyTextColor,
          selectedItemColor: AppColors.bluishColor,
          type: BottomNavigationBarType.fixed,

          /// implement onTap
          onTap: (int index) {
            if (index == 1) {
              // Navigate to the chat page
              Get.to(() =>
                  ProfileChatPageView()); // Replace ChatPage() with your actual chat page view
            } else {
              // Handle other navigation items if needed
              Get.to(() => EditProfileView());
            }
          }),
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

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      initialDateRange: DateTimeRange(
        start: _startDate,
        end: _endDate,
      ),
    );

    if (picked != null &&
        picked != DateTimeRange(start: _startDate, end: _endDate)) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        // Handle selected time
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Date and Time Range Picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Selected Date Range:',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Start: $_startDate\nEnd: $_endDate',
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectDateRange(context),
              child: const Text('Select Date Range'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              child: const Text('Select Time'),
            ),
          ],
        ),
      ),
    );
  }
}
