import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gotherepy_doctor/app/modules/auth_page/views/sign_in_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../home/views/home_view.dart';
import '../providers/auth_provider_provider.dart';
import '../views/verification_page_view.dart';


class AuthPageController extends GetxController {
  //TODO: Implement AuthPageController
  final ImagePicker picker=ImagePicker();
  AuthProviderProvider authProvider=AuthProviderProvider();
  XFile? image;
  XFile? userImage;
  var selectedIdentityProof=''.obs;
  var selectedUserImage=''.obs;

  ///Auth Page
  var doctorTypes=['Councillor','Yoga trainer','Meditator'];

  ///Sign In
  final signInFormKey=GlobalKey<FormState>();
  final signUpFormKey=GlobalKey<FormState>();
  final newUserRegisterFormKey=GlobalKey<FormState>();
  TextEditingController emailController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  signInUser(BuildContext context, {required String email, required String password,}){
    context.loaderOverlay.show();
    authProvider.loginUser(email: email.trim(), password: password.trim(), deviceToken: '',).then((loginResponse)async{
      context.loaderOverlay.hide();
      var decodedLoginResponseData=jsonDecode(await loginResponse.stream.bytesToString());
      if(decodedLoginResponseData['status']==true) {
        authProvider.getDoctorProfileInfo().then((value) {
          // localStorage.write(LocalStorage.getDoctorProfileInfo,)
          Get.offAll(() => const HomeView());
        });

      }else{
        Fluttertoast.showToast(msg: decodedLoginResponseData['message'],
          gravity: ToastGravity.CENTER,
        );
      }
    });
  }

  ///Sign Up
  TextEditingController usernameController=TextEditingController();
  TextEditingController signUpEmailController=TextEditingController();
  TextEditingController signUpPhoneController=TextEditingController();
  TextEditingController signUpPasswordController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();
  signUpNewUser(BuildContext context,{required String email,required String phone,required String password,required String cnfPassword,required String doctorType}){
   Map data={
     "email": email.trim(),
     "phone": phone.trim(),
     "password": password.trim(),
     "confirm_password": cnfPassword.trim(),
     "doctor_type": doctorTypes[0]
   };
   context.loaderOverlay.show();
  authProvider.registerUser(data).then((signUpResponseValue)async {
    context.loaderOverlay.hide();
    var decodedResponseData=jsonDecode(await signUpResponseValue.stream.bytesToString());
    print(decodedResponseData.toString());
    if(decodedResponseData['status']==true) {
      authProvider.verifyNumber(signUpPhoneController.text.trim()).then((otpResponse)async {
        var decodedData=jsonDecode(await otpResponse.stream.bytesToString());
        if(decodedData['status']==true) {
          countDown();
          Get.to(() => const VerificationPageView(newUser: true));
          }
        });
      }else{
      Fluttertoast.showToast(msg: decodedResponseData['message'],
        gravity: ToastGravity.CENTER,
      );
    }
    });
}
  sendOtp(BuildContext context, String phone) async {
    context.loaderOverlay.show();
    authProvider.verifyNumber(phone).then((response) async {
      context.loaderOverlay.hide();
      isClicked.value=true;
      if (kDebugMode) {
        print(jsonDecode(await response.stream.bytesToString()));
      }
      if (response.statusCode == 200) {
        countDown();
        Fluttertoast.showToast(msg: 'Otp Sent SucessFully',
          gravity: ToastGravity.CENTER,
        );
      }
    });
  }
  Future <int> countDown()async{
    canResendOtp.value=false;
    for(timer.value=0;timer.value<=30;timer.value++){
      print(timer.value);
      await Future.delayed(Duration(seconds: 1),(){
      });
    }
    if(timer.value>=29){
      canResendOtp.value=true;
    }
    return timer.value;
  }


  ///User Info Detail
  TextEditingController userTitleController=TextEditingController();
  TextEditingController userFullNameController=TextEditingController();
  TextEditingController userSpecializationController=TextEditingController();
  var userGenderValue=0.obs;
  TextEditingController userQualificationDetailsController=TextEditingController();
  TextEditingController userPoofId=TextEditingController();
  void selectProfileImage() async{
    userImage=await picker.pickImage(source: ImageSource.gallery);
    print(selectedUserImage.value);
    if(userImage != null) {
      selectedUserImage.value = userImage!.path;
    }
  }
  selectImageFromGallery() async{
    image = await picker.pickImage(source: ImageSource.gallery);
    if(image != null) {
      selectedIdentityProof.value = image!.path;
    }

  }

  ///verification page
  //Forget
  var isClicked=false.obs;
  var canResendOtp = false.obs;
  var timer = 0.obs;
  var showResetPasswordField=false.obs;
  TextEditingController otpNumber=TextEditingController();
  TextEditingController setNewPassword=TextEditingController();
  TextEditingController confirmNewPassword=TextEditingController();
  // sendOtp(BuildContext context,String phone)async {
  //   context.loaderOverlay.show();
  //   if(phone.isNotEmpty){
  //     await Future.delayed(Duration(seconds: 3),(){
  //       Get.to(()=>HomeView());
  //     });
  //   }
  // }
  setPassword(String password)async {
    if(password.isNotEmpty){
      await Future.delayed(Duration(seconds: 3),(){
      });
    }
    Get.to(()=>SignInView());
  }


  @override
  void onInit() {
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
