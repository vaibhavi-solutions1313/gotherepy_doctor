import 'package:get/get.dart';

import '../controllers/patient_page_controller.dart';

class PatientPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PatientPageController>(
      () => PatientPageController(),
    );
  }
}
