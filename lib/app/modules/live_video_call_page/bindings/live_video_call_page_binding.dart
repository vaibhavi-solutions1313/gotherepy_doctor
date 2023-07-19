import 'package:get/get.dart';

import '../controllers/live_video_call_page_controller.dart';

class LiveVideoCallPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LiveVideoCallPageController>(
      () => LiveVideoCallPageController(),
    );
  }
}
