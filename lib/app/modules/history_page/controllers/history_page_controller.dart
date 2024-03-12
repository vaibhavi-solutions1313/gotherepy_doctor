import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../chat_page/model/conversation.dart';

class HistoryPageController extends GetxController with GetSingleTickerProviderStateMixin {
  //TODO: Implement ChatPageController
  // HistoryListProvider chatListProvider = HistoryListProvider();
  var isMessagingFetching=false.obs;
  late TabController historyTabController;
  Rx<Conversation> userConversation=Conversation().obs;
  TextEditingController messageEditingController = TextEditingController();

  @override
  void onInit() {
    historyTabController=TabController(length: 2, vsync: this);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Future<AppointmentRequests> getAppointmentRequests({required String doctorId, required String type, required String status})async{
  //   type = "chat";
  //   status = "pending";
  //   return await historyListProvider.fetchAppointMentRequest(doctorId: doctorInfo.records!.doctorId.toString(),
  //       bookingType: type, status: status);
  // }
  // Future acceptAppointment({required String bookingId,required String bookingType })async{
  //   await historyListProvider.requestAppointment(bookingId: bookingId, bookingType: bookingType).whenComplete(() {
  //     //TODO refresh appointment page
  //   });
  // }
  // Future<HistoryListModel> getAllChatList({required String userId})async{
  //   return await historyListProvider.fetchChatList(userId: userId);
  // }
  //
  // Future<Rx<Conversation>> getConversation({required String userId, required String doctorId})async{
  //   return await historyListProvider.fetchConversation(userId: userId, doctorId: doctorId).then((value) {
  //     print(value.toJson().toString());
  //     isMessagingFetching.value=false;
  //     userConversation.refresh();
  //     return userConversation=value;
  //   });
  // }
  //
  // Future sendMessages({required String userId, required String doctorId, required String message, int isDoctorUser=1}) async{
  //   if (message.trim().isNotEmpty) {
  //     isMessagingFetching.value=true;
  //     await historyListProvider.sendMessage(userId: userId, doctorId: doctorId, message: message,isDoctorUser: isDoctorUser);
  //   }
  // }
}
