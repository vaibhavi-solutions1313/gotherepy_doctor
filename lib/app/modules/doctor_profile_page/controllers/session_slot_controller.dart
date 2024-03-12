import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotherepy_doctor/app/modules/doctor_profile_page/model/time_slots.dart';

import '../../../app_constants/constants_appColors.dart';
import '../providers/_provider.dart';

class SessionSlotsController extends GetxController{
  Rx<String> selectedDay = "".obs;
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();

  late TextEditingController _dayController;
  late TextEditingController _startTimeController;
  late TextEditingController _endTimeController;

  final ProfileProvider _profileProvider = ProfileProvider();
  var  timeSessionSlot = TimeSlots().obs;

  TextEditingController get dayController => _dayController;
  TextEditingController get startTimeController => _startTimeController;
  TextEditingController get endTimeController => _endTimeController;

  @override
  void onInit() {
    super.onInit();
    _dayController = TextEditingController();
    _startTimeController = TextEditingController();
    _endTimeController = TextEditingController();
  }

  Future<void> fetchSessionSlots() async{
    TimeSlots? getSlots = await _profileProvider.fetchSessionSlots();
    timeSessionSlot.value = getSlots!;
  }

  // session slot delete
  Future<void> deleteSlot(int id) async{
    // TODO
    await _profileProvider.deleteSessionSlot(id);
    await fetchSessionSlots();

    print('Session slot deleted successfully');
    Get.snackbar("Success", "Session deleted successfully", backgroundColor: AppColors.greenColor);
  }
  Future<void> addSlots(BuildContext context) async {
    // String startTimeStr = "${startTime.hour}:${startTime.minute.toString().padLeft(2, '0')}";
    // String endTimeStr = "${endTime.hour}:${endTime.minute.toString().padLeft(2, '0')}";

    // array of time
    List<String> newTimeSlots = ["${startTime.format(context)} - ${endTime.format(context)}"];
    print('addSlots :: ${newTimeSlots}');
    print('addSlots :: ${dayController.text}');
    await _profileProvider.apiAddSessionSlot(
        newTimeSlots: newTimeSlots, day: dayController.text);
    Get.snackbar(
      "Success",
      "Successfully added chat price.",
      snackPosition: SnackPosition.BOTTOM,
    );

    await fetchSessionSlots();
  }

}