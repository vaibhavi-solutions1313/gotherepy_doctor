import 'package:get/get.dart';
import 'package:gotherepy_doctor/app/modules/doctor_profile_page/controllers/doctor_ratings_controller.dart';
import 'package:gotherepy_doctor/app/modules/doctor_profile_page/controllers/price_controller.dart';
import 'package:gotherepy_doctor/app/modules/doctor_profile_page/controllers/session_slot_controller.dart';
import 'package:gotherepy_doctor/app/modules/doctor_profile_page/controllers/set_availability_controller.dart';

import '../providers/_provider.dart';

class EditProfilePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileProvider());
    Get.lazyPut<AvailabilityController>(() => AvailabilityController());
    Get.lazyPut<SessionSlotsController>(() => SessionSlotsController());
    Get.lazyPut<PriceController>(() => PriceController());
    Get.lazyPut<ReviewsController>(() => ReviewsController());
  }
}