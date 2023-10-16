import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotherepy_doctor/app/modules/auth_page/bindings/auth_page_binding.dart';
import 'package:gotherepy_doctor/app/modules/auth_page/views/auth_page_view.dart';
import 'package:gotherepy_doctor/app/modules/auth_page/views/sign_in_view.dart';
import 'package:http/http.dart'as http;

import '../../../appWidgets/appButtons.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../app_constants/constants_appColors.dart';
import '../../../app_constants/constants_end_points.dart';
import '../../home/views/home_view.dart';
class AuthProviderProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
  Future<String> fetchDoctorTypes() async {
    var request = http.Request('GET', Uri.parse('http://gotherapy.care/backend/public/api/doctor/doctor-type'));
    http.StreamedResponse response = await request.send();
    return await response.stream.bytesToString();
  }
  Future<http.StreamedResponse> loginUser({required String email, required String password, required String deviceToken}) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(EndPoints.baseUrl+EndPoints().login));
    request.body = json.encode({
      "email": email,
      "password": password
    });
    print(email.toString());
    print(password.toString());
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
 return response;

  }
  Future<http.StreamedResponse> registerUser(Map data) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(EndPoints.baseUrl+EndPoints().register));
    request.body = json.encode({
      "email": data['email'],
      "phone": data['phone'],
      "password": data['password'],
      "confirm_password": data['confirm_password'],
      "doctor_type": data['doctor_type']
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    return response;
  }
  Future<http.StreamedResponse> sendOtpToUserNumber(String mob)async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(EndPoints().sendOtp));
    request.body = json.encode({
      "mobile": mob
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    return response;
  }


  Future<http.StreamedResponse> verifyOtp({required String mobile, required String otp})async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('http://gotherapy.care/backend/public/api/doctor/verify-otp'));
    request.body = json.encode({
      "mobile": mobile,
      "otp": otp
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    return response;

  }
  saveNewUserInfo({required String newUserToken,required String name,required String title,required String gender,
    required List<String> counselling,required String specialization,required String about,
  required String avatar,
  required String education_proof,
  required String id_proof,
  })async{
    var headers = {
      'Authorization': 'Bearer $newUserToken'
    };
    var request = http.MultipartRequest('POST', Uri.parse('http://gotherapy.care/backend/public/api/doctor/update-profile'));
    request.fields.addAll({
      'name': name,
      'title': title,
      'gender': gender,
      'counselling[]': counselling.join(','),
      'specialization': specialization,
      'about': about
    });
    request.files.add(await http.MultipartFile.fromPath('avatar',avatar));
    request.files.add(await http.MultipartFile.fromPath('education_proof', education_proof));
    request.files.add(await http.MultipartFile.fromPath('id_proof', id_proof));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      print(await response.stream.bytesToString());


      Get.defaultDialog(
          titlePadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          title:'',
          middleText: '',
          content: Container(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                Icon(Icons.warning_amber_rounded,size: 56,color: AppColors.greyTextColor,),
                SizedBox(height: 10,),
                Text16by600(text: 'Thank you for sign up',fontSize: 20,color: AppColors.greyColor676464,),
                SizedBox(height: 15,),
                FooterTextWithCenterAligned(text: 'Thank for submitting your details with Gotherapy, once your request approval with admin we will get back to you', fontSize: 16,),
                SizedBox(height: 10,),
                CustomSolidButton(buttonText: 'Join Session', onClick: (){
                  Get.offAll(()=>const AuthPageView(),binding: AuthPageBinding());
                },fontSize: 16,),
                TextButton(onPressed: (){Get.to(()=>SignInView());}, child: Text('Skip',style: TextStyle(
                  color: AppColors.tealColor,

                ),))
              ],
            ),
          )
      );
    }
    else {
      print(response.reasonPhrase);
    }

  }

  Future<http.StreamedResponse> getDoctorProfileInfo()async{
    var headers = {
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    var request = http.Request('GET', Uri.parse('${EndPoints.baseUrl}get-doctor-profile'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    return response;
  }
}
