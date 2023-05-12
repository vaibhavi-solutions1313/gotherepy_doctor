import 'package:get/get.dart';

import '../controllers/session_page_controller.dart';

class SessionPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SessionPageController>(
      () => SessionPageController(),
    );
  }
}
