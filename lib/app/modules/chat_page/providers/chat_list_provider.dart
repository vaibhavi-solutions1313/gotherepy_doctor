import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import '../../../app_constants/constants_end_points.dart';
import '../model/chat_list_model.dart';
import '../model/conversation.dart';

class ChatListProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
  Future<ChatListModel> fetchChatList({required String userId})async{

 var headers = {
   'Content-Type': 'application/json',
   'Authorization': 'Bearer ${EndPoints.accessToken}'
 };
 var request = http.Request('GET', Uri.parse('http://gotherapy.care/backend/public/api/doctor/get-chat-appointment-list'));
 request.body = json.encode({
   "doctor_id": userId
 });
 request.headers.addAll(headers);

 http.StreamedResponse response = await request.send();
 ChatListModel chatListModel=ChatListModel();
 if (response.statusCode == 200) {
   print(userId);
   print('${EndPoints.accessToken}');
   var data =jsonDecode(await response.stream.bytesToString());
   print('99999999999999999999999999999999666666666666666666666666666666666');
   print(data.toString());
 chatListModel=ChatListModel.fromJson(data);

   return chatListModel;
 }
 else {
   print(response.reasonPhrase);
   return chatListModel;
 }
  }

  Future<Rx<Conversation>> fetchConversation({required String userId, required String doctorId})async{
    var headers = {
      'Authorization': 'Bearer ${EndPoints.accessToken}',
    };
    var request = http.MultipartRequest('POST', Uri.parse('http://gotherapy.care/backend/public/api/user/get-messages'));
    request.fields.addAll({
      'user_id': userId,
      'doctor_id': doctorId
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    Rx<Conversation> conversation=Conversation().obs;
    if (response.statusCode == 200) {
      print('======================fetchConversation=success========================');
      print(doctorId);
      print(userId);
      var data=jsonDecode(await response.stream.bytesToString());
      conversation.value=Conversation.fromJson(data);
      return conversation;
    }
    else {
      print(response.reasonPhrase);
      return conversation;
    }

  }
  Future sendMessage({required String userId, required String doctorId, required String message, int isDoctorUser=1})async{
    var headers = {
      'Authorization': 'Bearer ${EndPoints.accessToken}',
    };
    var request = http.MultipartRequest('POST', Uri.parse('http://gotherapy.care/backend/public/api/user/send-message'));
    request.fields.addAll({
      'user_id': userId,
      'doctor_id': doctorId,
      'message': message,
      'is_doctor_user': isDoctorUser.toString()
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }

  }

}
