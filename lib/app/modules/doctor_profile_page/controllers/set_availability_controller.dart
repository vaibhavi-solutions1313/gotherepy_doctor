import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gotherepy_doctor/app/modules/doctor_profile_page/providers/_provider.dart';

class AvailabilityController extends GetxController {
  final ProfileProvider availabilityProvider = Get.find<ProfileProvider>();
  TextEditingController _sessionavailabilityController = TextEditingController();
  TextEditingController _chatavailabilityController = TextEditingController();

  RxBool isOnlineChat = true.obs;
  RxBool isOnlineSession = true.obs;

  @override
  void onInit() {
    super.onInit();
    bool savedChatAvailability = GetStorage().read('isOnlineChat') ?? true;
    isOnlineChat.value = savedChatAvailability;
    _updateChatAvailabilityText(savedChatAvailability);

    bool savedSessionAvailability = GetStorage().read('isOnlineSession') ?? true;
    isOnlineSession.value = savedSessionAvailability;
    _updateSessionAvailabilityText(savedSessionAvailability);

    _updateSessionAvailabilityText(isOnlineSession.value);
    _updateChatAvailabilityText(isOnlineChat.value);
  }

  // for session availability
  void _updateSessionAvailabilityText(bool isSessionAvailableText) async {
    String sessionAvailabilityText = isSessionAvailableText ? 'Online' : 'Offline';
    _sessionavailabilityController.text = sessionAvailabilityText;
  }

  void updateSessionAvailability(bool isSessionAvailable) async{
    try{
      await availabilityProvider.setAvailability(isOnlineChat.value, isSessionAvailable);
      isOnlineSession.value = isSessionAvailable;
      _updateSessionAvailabilityText(isSessionAvailable);
      // Get.back();
    } catch(error){
      print('Failed to update session availability: $error');
    }
  }

  // for chat availability
  void _updateChatAvailabilityText(bool isChatAvailableText) async {
    String chatAvailabilityText = isChatAvailableText ? 'Online' : 'Offline';
    _chatavailabilityController.text = chatAvailabilityText;
    print('Chat text changed...');
  }

  void updateChatAvailability(bool isChatAvailable) async{
    try{
      await availabilityProvider.setAvailability(isChatAvailable, isOnlineSession.value);
      isOnlineChat.value = isChatAvailable;
      _updateChatAvailabilityText(isChatAvailable);
      print('Chat value parsed successfully: $isChatAvailable');
      // Get.back();
    } catch(error){
      print('Failed to update chat availability: $error');
    }
  }
}