import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotherepy_doctor/app/modules/home/providers/home_provider.dart';
import '../model/user_appointment_model.dart';


class WalletPageController extends GetxController with GetSingleTickerProviderStateMixin {
  //TODO: Implement WalletController
  HomeProvider homeProvider=HomeProvider();
  PageController pageController=PageController();
  Rx<UsersAppointmentsModel> usersAppointmentsModel=UsersAppointmentsModel().obs;

  late TabController tabController;

  @override
  void onInit() {
    super.onInit();

    tabController = TabController(length: 2, vsync: this);
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
