import 'package:get/get.dart';
import '../controllers/doctor_profile_page_controller.dart';

class DoctorProfilePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoctorProfilePageController>(
      () => DoctorProfilePageController(),
    );
  }
}
