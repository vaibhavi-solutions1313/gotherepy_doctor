import 'package:get/get.dart';

import '../../auth_page/views/auth_page_view.dart';

class SplashScreenController extends GetxController {
  //TODO: Implement SplashScreenController
  var opacity=false.obs;

void tryAutoLogin(){
  if(1==1){
    Future.delayed(Duration(seconds: 4),(){
      Get.off(()=>const AuthPageView());
    });
  }
}
  @override
  void onInit() {
    super.onInit();
    tryAutoLogin();
    opacity.value=true;
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
