import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotherepy_doctor/app/modules/chat_page/model/appointment_requests.dart';

import '../../../../main.dart';
import '../model/chat_list_model.dart';
import '../model/conversation.dart';
import '../providers/chat_list_provider.dart';

class ChatPageController extends GetxController with GetSingleTickerProviderStateMixin {
  //TODO: Implement ChatPageController
  ChatListProvider chatListProvider = ChatListProvider();
  var isMessagingFetching=false.obs;
  late TabController chatTabController;
  Rx<Conversation> userConversation=Conversation().obs;
  TextEditingController messageEditingController = TextEditingController();

  @override
  void onInit() {
    chatTabController=TabController(length: 2, vsync: this);
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

  Future<AppointmentRequests> getAppointmentRequests({required String doctorId, required String type, required String status})async{
    type = "chat";
    status = "pending";
    return await chatListProvider.fetchAppointMentRequest(doctorId: doctorInfo.records!.doctorId.toString(),
        bookingType: type, status: status);
  }
  Future acceptAppointment({required String bookingId,required String bookingType })async{
    await chatListProvider.requestAppointment(bookingId: bookingId, bookingType: bookingType).whenComplete(() {
      //TODO refresh appointment page
    });
  }
  Future<ChatListModel> getAllChatList({required String userId})async{
    return await chatListProvider.fetchChatList(userId: userId);
  }

  Future<Rx<Conversation>> getConversation({required String userId, required String doctorId})async{
    return await chatListProvider.fetchConversation(userId: userId, doctorId: doctorId).then((value) {
      print(value.toJson().toString());
      isMessagingFetching.value=false;
      userConversation.refresh();
      return userConversation=value;
    });
  }

  Future sendMessages({required String userId, required String doctorId, required String message, int isDoctorUser=1}) async{
    if (message.trim().isNotEmpty) {
      isMessagingFetching.value=true;
      await chatListProvider.sendMessage(userId: userId, doctorId: doctorId, message: message,isDoctorUser: isDoctorUser);
    }
  }
}
