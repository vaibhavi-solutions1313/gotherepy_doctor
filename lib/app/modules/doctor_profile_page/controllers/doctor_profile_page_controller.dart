import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorProfilePageController extends GetxController {
  //TODO: Implement DoctorProfilePageController

  var doctorDetail=[
    {
      'title':'Name',
      'value':'Username',
      'icon':Icons.edit,
    },
    {
      'title':'About',
      'value':'Hey, my name is Geeta Bhalla, I am a certified Weight Loss Dietitian. I’ve been practicing from my clinic in South Delhi (M Block Market, Greater Kailash Part 1) from 2003 till present. I have generated a huge clientele over time mainly through my positive word of mouth.',
      'icon':Icons.edit,
    },
    {
      'title':'Specialization',
      'value':'Anxiety, Depression, Stress, Relationship Issue, Suicidal Ideation, Grief & Loss, OCD.',
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
