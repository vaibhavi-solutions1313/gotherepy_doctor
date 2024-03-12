import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gotherepy_doctor/app/modules/doctor_profile_page/model/fetch_price.dart';
import 'package:gotherepy_doctor/main.dart';
import 'package:image_picker/image_picker.dart';
import '../model/time_slots.dart'as time_slots;
import '../providers/_provider.dart';

class DoctorProfilePageController extends GetxController with GetSingleTickerProviderStateMixin {
  //TODO: Implement DoctorProfilePageController
  late TabController tabController;
  var selectedValue = 'online'.obs;
  var options = <String>['Online','Offline'].obs;

  var selectedWeekday = "".obs;
  Rx<time_slots.Results> timeSlotsSelectedResult = time_slots.Results().obs;
  RxList newAddedTimeSlots = <String?>[].obs;
  RxBool isUserWantsToEditSlots = false.obs;
  var selectedSlots = [].obs;
  var startTime = const TimeOfDay(hour: 0,minute: 0).obs;
  var endTime = const TimeOfDay(hour: 0,minute: 0).obs;

  var doctorDetail=[
    {
      'title':'Name',
      'value':doctorInfo.records!.name!??'Doctor name here',
      'icon':Icons.edit,
    },
    {
      'title':'Gender',
      'value':doctorInfo.records!.gender??'.....',
      'icon':Icons.person,
    },
    {
      'title':'About',
      'value':doctorInfo.records!.about??'.....',
      'icon':Icons.edit,
    },
    {
      'title':'Specialization',
      'value':doctorInfo.records!.degree,
      'icon':Icons.folder_special,
    },
    {
      'title':'Experience',
      'value':doctorInfo.records!.exp,
      'icon':Icons.timelapse_rounded,
    },

  ].obs;
  RxBool enableTexField = true.obs;
  Rx<String?> userImagePath=''.obs;
  Rx<String?> qualificationCertificateImagePath=''.obs;
  Rx<String?> identityProofImagePath=''.obs;
  @override
  void onInit() {
    tabController=TabController(length: 3, vsync: this);
    ever(selectedWeekday, (callback) => ProfileProvider().fetchAvailableSlots());
    super.onInit();

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


  List<DateTime> selectedDates = [];
 Future<SessionChatPriceModel?> getSessionPrice()async{
   return await ProfileProvider().fetchSessionChatPrice();
 }
  Future<void> selectDateAndTime({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        DateTime selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

          selectedDates.add(selectedDateTime);

      }
    }
  }
  Future<String?> pickImageFromGallery()async{
    XFile? file=await ImagePicker().pickImage(source: ImageSource.gallery);
    if(file!.path.isNotEmpty){
      if (kDebugMode) {
        print(file.path.toString());
      }
      return file.path;
    }else{
      return '';
    }
  }

  Future addSlots()async{
    await ProfileProvider().apiAddSessionSlot(newTimeSlots: [], day: '');
  }

 Future editSlots({required time_slots.Results updateSlots})async{
    print(updateSlots.runtimeType);
    print(updateSlots);
    print('edit------------------------------------');
    await ProfileProvider().updateTimeSlots(updateSlots: updateSlots).then((value) async{
        if(value.statusCode==200){
          print('success');
          var decodedData=jsonDecode(await value.stream.bytesToString());
          print(decodedData);
          Fluttertoast.showToast(msg: decodedData['msg']);
        }
    });
  }
}
