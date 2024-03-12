import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../chat_page/model/conversation.dart';

class ProfileChatPageController extends GetxController with GetSingleTickerProviderStateMixin{
  // ChatListProvider chatListProvider = ChatListProvider();
  var isMessagingFetching=false.obs;
  late TabController chatTabController;
  Rx<Conversation> userConversation=Conversation().obs;
  TextEditingController messageEditingController = TextEditingController();
  TextEditingController reasonController = TextEditingController();

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
}