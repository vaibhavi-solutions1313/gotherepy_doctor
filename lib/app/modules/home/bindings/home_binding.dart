import 'package:get/get.dart';
import 'package:gotherepy_doctor/app/modules/chat_page/controllers/chat_page_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<ChatPageController>(
          () => ChatPageController(),
    );
  }
}
