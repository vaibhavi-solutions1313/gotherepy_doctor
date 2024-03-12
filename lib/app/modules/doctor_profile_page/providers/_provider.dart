import 'dart:convert';
import 'package:get/get.dart';
import 'package:gotherepy_doctor/app/app_constants/constants_end_points.dart';
import 'package:gotherepy_doctor/app/modules/doctor_profile_page/model/doctor_ratings.dart';
import 'package:gotherepy_doctor/app/modules/doctor_profile_page/model/edit_chat_price.dart';
import 'package:gotherepy_doctor/app/modules/doctor_profile_page/model/edit_session_price.dart';
import 'package:gotherepy_doctor/app/modules/doctor_profile_page/model/fetch_price.dart';
import 'package:gotherepy_doctor/app/modules/doctor_profile_page/model/time_slots.dart';
import 'package:http/http.dart'as http;

import '../model/add_session_price.dart';
import '../model/set_availability.dart';

class ProfileProvider extends GetConnect {
  static String doctorUrl = "http://gotherapy.care/public/api/doctor";
  static String userUrl = "http://gotherapy.care/public/api/user";

  /// availability
  Future<SetAvailability> setAvailability(bool isOnlineChat, bool isOnlineSession) async {
    final request = http.Request('POST', Uri.parse(doctorUrl + '/set-availability'));
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    request.headers.addAll(headers);
    // var availability = SetAvailability();
    request.body = json.encode({
      'is_online_chat': isOnlineChat,
      'is_online_session': isOnlineSession,
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // Parse successful response into SetAvailability object
      Map<String, dynamic> responseJson = jsonDecode(request.body);
      return SetAvailability.fromJson(responseJson);
    } else {
      // Handle error response
      throw Exception('Failed to post availability: ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  /// session price
  Future<AddSessionPriceModel> addSessionPrice(
      String sessionPrice,
      String sessionCount,
      String discountPercentage,
      String sessionTime) async {
    print(
        "Request Data: $sessionPrice, $sessionCount, $sessionTime, $discountPercentage");
    print("Entered try block");
    final request = http.MultipartRequest(
        'POST', Uri.parse(doctorUrl + '/add-session-prices'));
    var headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    request.headers.addAll(headers);

    request.fields.addAll({
      'session_price': sessionPrice,
      'session_count': sessionCount,
      'session_time': sessionTime,
      'discount_percentage': discountPercentage,
    });
    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      print('Json decode successful');
      return addSessionPriceModelFromJson(responseBody);
    } else {
      throw Exception('Failed to add session price: ${response.reasonPhrase}');
    }

  }

  /// chat price
  /*Future<AddChatPriceModel> addChatPrice(String sessionPrice,
      String sessionCount,
      String discountPercentage,
      String sessionTime) async {
    print("Request Data: $sessionPrice, $sessionCount, $sessionTime, $discountPercentage");
    print("Entered try block");
    final request = http.MultipartRequest('POST', Uri.parse(doctorUrl + '/add-chat-prices'));
    var headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    request.headers.addAll(headers);

    request.fields.addAll({
      'session_price': sessionPrice,
      'session_count': sessionCount,
      'session_time': sessionTime,
      'discount_percentage': discountPercentage,
    });
    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      print('Json decode successful');
      return addChatPriceModelFromJson(responseBody);
    } else {
      throw Exception('Failed to add chat price: ${response.reasonPhrase}');
    }
  }*/
  Future<AddSessionPriceModel> addChatPrice(
      String sessionPrice,
      String sessionCount,
      String discountPercentage,
      String sessionTime) async {
    print("Request Data: $sessionPrice, $sessionCount, $sessionTime, $discountPercentage");
    final request = http.MultipartRequest(
        'POST', Uri.parse(doctorUrl + '/add-chat-prices'));
    var headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    request.headers.addAll(headers);

    request.fields.addAll({
      'session_price': sessionPrice,
      'session_count': sessionCount,
      'session_time': sessionTime,
      'discount_percentage': discountPercentage,
    });
    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    print(responseBody);
    return addSessionPriceModelFromJson(responseBody);
    if (response.statusCode == 200) {
      print('Json decode successful');
      return addSessionPriceModelFromJson(responseBody);
    } else {
      throw Exception('Failed to add chat price: ${response.reasonPhrase}');
    }

  }

  /// ratings
  Future<RatingsModel> fetchReviews(int doctorId) async{
    final request = http.MultipartRequest('POST', Uri.parse(userUrl + '/get-ratings-by-id'));
    var headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    request.headers.addAll(headers);

    request.fields.addAll({
      'doctor_id': '$doctorId',
    });
    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    print(responseBody);
    if (response.statusCode == 200) {
      print('Ratings received successfully');
      return ratingsModelFromJson(responseBody);
    } else {
      throw Exception('Failed to add session price: ${response.reasonPhrase}');
    }
  }

  /// fetch session chat price
  Future<SessionChatPriceModel?> fetchSessionChatPrice()async{
    var headers = {
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    var request = http.MultipartRequest('GET', Uri.parse(doctorUrl + '/fetch-session-chat-price'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    print(responseBody);
    if (response.statusCode == 200) {
      SessionChatPriceModel? _model = sessionChatPriceModelFromJson(responseBody);
      return _model;
    }
    else {
      print(response.reasonPhrase);
    }

  }

  /// delete chat using id
  Future<void> deleteChat(int id) async{
    final request = await http.MultipartRequest('POST', Uri.parse(doctorUrl + '/chat-price-delete'));
    // headers: {
    //   'Content-Type': 'multipart/form-data',
    //   'Authorization': 'Bearer ${EndPoints.accessToken}'
    // },
    // body: jsonEncode({'id': id}),
    // );
    var headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    request.headers.addAll(headers);

    request.fields.addAll({
      'id': '$id',
    });
    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    print(responseBody);
    print("Delete Response: ${responseBody}");

    if(response.statusCode == 200){
      print('Session Data deleted successfully');
    } else{
      print('Failed to delete session: ${response.reasonPhrase}');
    }
  }

  /// delete session using id
  Future<void> deleteSession(int id) async{
      final request = await http.MultipartRequest('POST', Uri.parse(doctorUrl + '/session-price-delete'));
      // headers: {
      //   'Content-Type': 'multipart/form-data',
      //   'Authorization': 'Bearer ${EndPoints.accessToken}'
      // },
      // body: jsonEncode({'id': id}),
      // );
          var headers = {
          'Content-Type': 'multipart/form-data',
          'Authorization': 'Bearer ${EndPoints.accessToken}'
          };
      request.headers.addAll(headers);

      request.fields.addAll({
        'id': '$id',
      });
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
      print(responseBody);
      print("Delete Response: ${responseBody}");


      if(response.statusCode == 200){
        print('Session Data deleted successfully');
      } else{
        print('Failed to delete session: ${response.reasonPhrase}');
      }
    }

  /// delete slots using id
  Future<void> deleteSessionSlot(int id) async{
    final request = await http.MultipartRequest('POST', Uri.parse(doctorUrl + '/session-slot-delete'));
    // headers: {
    //   'Content-Type': 'multipart/form-data',
    //   'Authorization': 'Bearer ${EndPoints.accessToken}'
    // },
    // body: jsonEncode({'id': id}),
    // );
    var headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    request.headers.addAll(headers);

    request.fields.addAll({
      'id': '$id',
    });
    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    print(responseBody);
    print("Delete Response: ${responseBody}");

    if(response.statusCode == 200){
      print('Session Data deleted successfully');
    } else{
      print('Failed to delete session: ${response.reasonPhrase}');
    }
  }

  Future<TimeSlots?> fetchSessionSlots() async{
    var headers = {
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    var request = http.Request('GET', Uri.parse(doctorUrl + '/fetch-time-slots'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    print(responseBody);
    if (response.statusCode == 200) {
      TimeSlots? _model = timeSlotsFromJson(responseBody);
      return _model;
    }
    else {
      print(response.reasonPhrase);
    }
  }

  Future<TimeSlots?> fetchAvailableSlots()async{
    var headers = {
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    var request = http.Request('GET', Uri.parse(doctorUrl + '/fetch-time-slots'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    TimeSlots timeSlots=TimeSlots();
    if (response.statusCode == 200) {
      var decodedData=jsonDecode(await response.stream.bytesToString());
      return timeSlots=TimeSlots.fromJson(decodedData);
    }
    else {
    print(response.reasonPhrase);
    return timeSlots;
    }

  }

  Future apiAddSessionSlot({required List<String> newTimeSlots,required String day})async{
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };

    var request = http.Request('POST', Uri.parse(doctorUrl + '/add-time-slot'));
    request.body = json.encode({
      "times": newTimeSlots,
      // "times": [
      //   "2:00 AM - 4:00 PM"
      // ],
      "day": day,
      "time_type": "0"
    });
    print('apiAddSessionSlot :: ${ request.body.toString()}');

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('apiAddSessionSlot :: ${await response.stream.bytesToString()}');
    }
    else {
      print('apiAddSessionSlot :: ${response.reasonPhrase}');
    }

  }

  Future<http.StreamedResponse> updateTimeSlots({required Results updateSlots})async{
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    var request = http.Request('POST', Uri.parse(doctorUrl + '/edit-time-slot'));
    request.body = json.encode({
      "id": updateSlots.id,
      "times": updateSlots.times,
      "day":updateSlots.day
    });
    // request.body = json.encode(updateSlots);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    return response;

  }

  Future<http.StreamedResponse> editTime({required Results updateSlots})async{
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    var request = http.Request('POST', Uri.parse(doctorUrl + '/edit-time-slot'));
    request.body = json.encode({
      "id": updateSlots.id,
      "times": updateSlots.times,
      "day":updateSlots.day
    });
    // request.body = json.encode(updateSlots);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    return response;

  }


  Future<EditSessionPrice> editSessionPrice(String sessionPrice,
      String sessionCount,
      String discountPercentage,
      String sessionTime, String doctorId) async {
    final request = http.MultipartRequest('POST', Uri.parse(doctorUrl + '/edit-session-prices'));
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    request.headers.addAll(headers);

    request.fields.addAll({
      "id": '${doctorId}',
      'session_price': sessionPrice,
    'session_count': sessionCount,
    'session_time': sessionTime,
    'discount_percentage': discountPercentage,
    });
    print(json);
    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    print(responseBody);
    return editSessionPriceFromJson(responseBody);
    // if (response.statusCode == 200) {
    //   // Parse successful response into AddSessionPrice object
    //   print("Session Price updated Successfully");
    //   return editSesssionPriceFromJson(responseBody);
    // } else {
    //   // Handle error response
    //   print(response.reasonPhrase);
    //   throw Exception('Failed to post session price: ${response.statusCode} ${response.reasonPhrase}');
    // }
  }

  Future<EditChatPrice> editChatPrice(String chatPrice,
      String chatCount,
      String chatDisPercentage,
      String chatTime, String doctorId) async {
    final request = http.MultipartRequest('POST', Uri.parse(doctorUrl + '/edit-chat-prices'));
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    request.headers.addAll(headers);

    request.fields.addAll({
      "id": '${doctorId}',
      'session_price': chatPrice,
      'session_count': chatCount,
      'session_time': chatTime,
      'discount_percentage': chatDisPercentage,
    });
    print(json);
    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    print(responseBody);
    return editChatPriceFromJson(responseBody);
  }

  Future<http.StreamedResponse> fetchPricebyId(int priceId) async {
    final request = http.Request('POST', Uri.parse(doctorUrl + '/fetch-session-chat-price-detail'));
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    request.headers.addAll(headers);
    String jsonBody = jsonEncode({'priceId': priceId});

    // Send the request (previously missing)
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("Session-Chat Price fetched Successfully");
      print(jsonBody); // Print the request body
      return response;
    } else {
      throw Exception('Failed to post session price: ${response.statusCode} ${response.reasonPhrase}');
    }
  }
}
