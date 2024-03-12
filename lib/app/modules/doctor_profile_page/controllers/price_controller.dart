import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotherepy_doctor/app/modules/doctor_profile_page/model/edit_chat_price.dart';
import 'package:gotherepy_doctor/app/modules/doctor_profile_page/model/edit_session_price.dart';
import 'package:gotherepy_doctor/app/modules/doctor_profile_page/model/fetch_price.dart';
import '../../../app_constants/constants_appColors.dart';
import '../providers/_provider.dart';

class PriceController extends GetxController {
  String selectedDay = ""; //TODO
  TimeOfDay _startTime = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay _endTime = TimeOfDay(hour: 0, minute: 0);

  final ProfileProvider _profileProvider = ProfileProvider();
  var sessionChatPriceModel = SessionChatPriceModel().obs;
  var editSessionPriceModel = EditSessionPrice().obs;
  var editChatPriceModel = EditChatPrice().obs;

  // for session
  late TextEditingController _sessionPriceController;
  late TextEditingController _sessionCountController;
  late TextEditingController _sessionTimeController;
  late TextEditingController _discountPerController;

  // for chat
  late TextEditingController _chatPriceController;
  late TextEditingController _chatDiscountController;
  late TextEditingController _chatTimeController;

  // for session
  Rx<String> sessionPrice = "".obs;
  Rx<String> sessionCount = "".obs;
  Rx<String> sessionTime = "".obs;
  Rx<String> discountPercentage = "".obs;

  // for updated session
  Rx<String> updatedSessionPrice = "".obs;
  Rx<String> updatedSessionCount = "".obs;
  Rx<String> updatedSessionTime = "".obs;
  Rx<String> updatedDiscountPercentage = "".obs;

  // for chat
  Rx<String> chatPrice = "".obs;
  Rx<String> chatDiscount = "".obs;
  Rx<String> chatTime = "".obs;

  // for updated chat
  Rx<String> updatedChatPrice = "".obs;
  Rx<String> updatedChatCount = "".obs;
  Rx<String> updatedChatTime = "".obs;
  Rx<String> updatedChatDiscountPer = "".obs;

  /// getters
  TextEditingController get sessionPriceController => _sessionPriceController;

  TextEditingController get sessionCountController => _sessionCountController;

  TextEditingController get sessionTimeController => _sessionTimeController;

  TextEditingController get discountPerController => _discountPerController;

  TextEditingController get chatPriceController => _chatPriceController;

  TextEditingController get chatTimeController => _chatTimeController;

  TextEditingController get chatDiscountController => _chatDiscountController;

  /// update controllers
  TextEditingController updatedSessionPriceController = TextEditingController();
  TextEditingController updatedSessionCountController = TextEditingController();
  TextEditingController updatedSessionDiscountController = TextEditingController();
  TextEditingController updatedSessionTimeController = TextEditingController();

  TextEditingController updatedChatPriceController = TextEditingController();
  TextEditingController updatedChatCountController = TextEditingController();
  TextEditingController updatedChatDiscountController = TextEditingController();
  TextEditingController updatedChatTimeController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _sessionPriceController = TextEditingController();
    _sessionCountController = TextEditingController();
    _sessionTimeController = TextEditingController();
    _discountPerController = TextEditingController();

    _chatDiscountController = TextEditingController();
    _chatPriceController = TextEditingController();
    _chatTimeController = TextEditingController();
  }

  @override
  void onClose() {
    // Dispose controllers
    _sessionPriceController.dispose();
    _sessionCountController.dispose();
    _sessionTimeController.dispose();
    _discountPerController.dispose();

    _chatPriceController.dispose();
    _chatTimeController.dispose();
    _chatDiscountController.dispose();

    updatedSessionCountController.dispose();
    updatedSessionDiscountController.dispose();
    updatedSessionPriceController.dispose();
    updatedSessionTimeController.dispose();

    updatedChatCountController.dispose();
    updatedChatDiscountController.dispose();
    updatedChatPriceController.dispose();
    updatedChatTimeController.dispose();


    super.onClose();
  }

  void addSlots() async {
    String startTimeStr = _startTime as String;
    String endTimeStr = _endTime as String;

    // array of time
    List<String> newTimeSlots = ["$startTimeStr - $endTimeStr"];

    await ProfileProvider()
        .apiAddSessionSlot(newTimeSlots: newTimeSlots, day: selectedDay);
  }

  Future<void> getSessionPrice() async {
    SessionChatPriceModel? priceData =
        await _profileProvider.fetchSessionChatPrice();
    sessionChatPriceModel.value = priceData!;
  }

  Future<void> deleteSession(int id) async {
    // TODO
    await _profileProvider.deleteSession(id);
    await getSessionPrice();

    print('Session deleted successfully');
    Get.snackbar("Success", "Session deleted successfully",
        backgroundColor: AppColors.greenColor);
  }

  Future<void> addSessionPriceMethod() async {
    final response = await _profileProvider.addSessionPrice(
        sessionPriceController.text,
        sessionCountController.text,
        discountPerController.text,
        sessionTimeController.text);

    if (response.status == true && response.results != null) {
      sessionPrice.value = response.results!.sessionPrice ?? "";
      sessionCount.value = response.results!.sessionCount ?? "";
      discountPercentage.value = response.results!.discountPercentage ?? "";
      sessionTime.value = response.results!.sessionTime ?? "";
      getSessionPrice();
      Get.snackbar(
        "Success",
        "Successfully added session price.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        "Error",
        "Failed to add session price. Status: ${response.msg}",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /*Future<void> updateSessionPriceMethod(int doctorId) async{
    final updatedSessionPrice = sessionPriceController.text;
    final updatedSessionCount = sessionCountController.text;
    final updatedDiscountPercentage = discountPerController.text;
    final updatedSessionTime = sessionTimeController.text;

    final sessionId = doctorId;

    final response = await _profileProvider.editSessionPrice(
        updatedSessionPrice,
        updatedSessionCount,
        updatedDiscountPercentage,
        updatedSessionTime,
        sessionId);

    if(response.status == true){
      sessionPrice.value = updatedSessionPrice;
      sessionCount.value = updatedSessionCount;
      sessionTime.value = updatedSessionTime;
      discountPercentage.value = updatedDiscountPercentage;

      await getSessionPrice();

      Get.snackbar("Success", "Session price updated successfully", backgroundColor: AppColors.greenColor);
    } else{
      print('Failed updating session details');
      Get.snackbar(
        "Error",
        "Failed to update session price. Status: ${response.msg}",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }*/

  Future<void> updateSessionPriceMethod(String doctorId) async {
    final sessionId = doctorId;

    final response = await _profileProvider.editSessionPrice(
        updatedSessionPriceController.text,
        updatedSessionCountController.text,
        updatedSessionDiscountController.text,
        updatedSessionTimeController.text,
        sessionId);

    if (response.status == true && response.results != null) {
      updatedSessionPrice.value = response.results!.sessionPrice ?? "";
      updatedSessionCount.value = response.results!.sessionCount ?? "";
      updatedSessionTime.value = response.results!.sessionTime ?? "";
      updatedDiscountPercentage.value =
          response.results!.discountPercentage ?? "";

      await getSessionPrice().then((value) {
        print('After get session price');
        return Get.snackbar(
          "Success", "Session price updated successfully",
          backgroundColor: AppColors.greenColor);
      });
    } else {
      print('Failed updating session details');
      Get.snackbar(
        "Error",
        "Failed to update session price. Status: ${response.msg}",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> getChatPrice() async {
    SessionChatPriceModel? priceData =
        await _profileProvider.fetchSessionChatPrice();
    sessionChatPriceModel.value = priceData!;
  }

  // chat delete
  Future<void> deleteChat(int id) async {
    // TODO
    await _profileProvider.deleteChat(id);
    await getChatPrice();

    print('Chat deleted successfully');
    Get.snackbar("Success", "Chat deleted successfully",
        backgroundColor: AppColors.greenColor);
  }

  Future<void> addChatPriceMethod() async {
    final response = await _profileProvider.addChatPrice(
        chatPriceController.text,
        sessionCountController.text,
        chatDiscountController.text,
        chatTimeController.text);

    if (response.status == true && response.results != null) {
      chatPrice.value = response.results!.sessionPrice ?? "";
      sessionCount.value = response.results!.sessionCount ?? "";
      chatDiscount.value = response.results!.discountPercentage ?? "";
      chatTime.value = response.results!.sessionTime ?? "";

      getChatPrice();

      Get.snackbar(
        "Success",
        "Successfully added chat price.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        "Error",
        "Failed to add chat price. Status: ${response.msg}",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> updateChatPriceMethod(String doctorId) async {
    final sessionId = doctorId;

    final response = await _profileProvider.editChatPrice(
        updatedChatPriceController.text,
        updatedChatCountController.text,
        updatedChatDiscountController.text,
        updatedChatTimeController.text,
        sessionId);

    if (response.status == true && response.results != null) {
      updatedChatPrice.value = response.results!.sessionPrice ?? "";
      updatedChatCount.value = response.results!.sessionCount ?? "";
      updatedChatTime.value = response.results!.sessionTime ?? "";
      updatedChatDiscountPer.value =
          response.results!.discountPercentage ?? "";

      await getSessionPrice().then((value) {
        print('After get chat price');
        return Get.snackbar(
            "Success", "Chat price updated successfully",
            backgroundColor: AppColors.greenColor);
      });
    } else {
      print('Failed updating chat details');
      Get.snackbar(
        "Error",
        "Failed to update chat price. Status: ${response.msg}",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
