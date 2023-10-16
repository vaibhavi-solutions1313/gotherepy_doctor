import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotherepy_doctor/main.dart';

class DoctorProfilePageController extends GetxController {
  //TODO: Implement DoctorProfilePageController

  var doctorDetail=[
    {
      'title':'Name',
      'value':doctorInfo.records!.name!??'Doctor name here',
      'icon':Icons.edit,
    },
    {
      'title':'About',
      'value':doctorInfo.records!.about??'.....',
      'icon':Icons.edit,
    },
    {
      'title':'Specialization',
      'value':doctorInfo.records!.degree,
      'icon':Icons.edit,
    },


  ].obs;
  RxBool enableTexField = true.obs;
  @override
  void onInit() {
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

}
