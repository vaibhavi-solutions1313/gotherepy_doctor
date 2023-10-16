import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gotherepy_doctor/app/modules/auth_page/views/sign_in_view.dart';
import 'package:gotherepy_doctor/app/modules/home/bindings/home_binding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../../main.dart';
import '../../../app_constants/constants_end_points.dart';
import '../../../app_services/local_storage.dart';
import '../../../data/doctor_user_info.dart';
import '../../home/views/home_view.dart';
import '../providers/auth_provider_provider.dart';
import '../views/verification_page_view.dart';

class AuthPageController extends GetxController {
  //TODO: Implement AuthPageController
  final ImagePicker picker = ImagePicker();
  AuthProviderProvider authProvider = AuthProviderProvider();
  XFile? image;
  XFile? userImage;
  var selectedIdentityProof = ''.obs;
  var selectedUserImage = ''.obs;
  var selectedEducationImage = ''.obs;

  ///Auth Page
  var doctorTypes = [].obs;
  var doctorTypeId = ''.obs;
  Future getTherapistType() async {
    await authProvider.fetchDoctorTypes().then((value) async {
      var jsonDecodedData = jsonDecode(value.toString());
      // print(jsonDecodedData.toString());
      doctorTypes.value = jsonDecodedData['results'];
      print('-------------------doctorTypes---------------------------------');
      print(doctorTypes.toJson().toString());
    });
  }

  ///Sign In
  final signInFormKey = GlobalKey<FormState>();
  final newUserRegisterFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  signInUser(BuildContext context, {required String email, required String password, required String deviceToken}) {
    context.loaderOverlay.show();
    authProvider
        .loginUser(
      email: email.trim(),
      password: password.trim(),
      deviceToken: deviceToken,
    )
        .then((loginResponse) async {
      context.loaderOverlay.hide();
      var decodedLoginResponseData = jsonDecode(await loginResponse.stream.bytesToString());

      if (decodedLoginResponseData['status'] == true){

        await localStorage.write(LocalStorage.getAccessTokenKey, decodedLoginResponseData['token']);
        EndPoints.accessToken = localStorage.read(LocalStorage.getAccessTokenKey) ?? '';
        await authProvider.getDoctorProfileInfo().then((value) async {

          var doctorInfoResponseData = jsonDecode(await value.stream.bytesToString());
          print('888888888888888888888888888888888888888');
          print(doctorInfoResponseData.toString());
          await localStorage.write(LocalStorage.getDoctorProfileInfo, doctorInfoResponseData);

          doctorInfo = DoctorProfileInfo.fromJson(localStorage.read(LocalStorage.getDoctorProfileInfo));

          Get.offAll(() => const HomeView(), binding: HomeBinding());
        });
      } else {
        Fluttertoast.showToast(
          msg: decodedLoginResponseData['message'],
          gravity: ToastGravity.CENTER,
        );
      }
    });
  }

  ///Sign Up
  final signUpFormKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController signUpEmailController = TextEditingController();
  TextEditingController signUpPhoneController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  signUpNewUser(BuildContext context,
      {required String email, required String phone, required String password, required String cnfPassword, required String doctorTypeId}) {
    Map data = {"email": email.trim(), "phone": phone.trim(), "password": password.trim(), "confirm_password": cnfPassword.trim(), "doctor_type": doctorTypeId};
    context.loaderOverlay.show();
    authProvider.registerUser(data).then((signUpResponseValue) async {
      context.loaderOverlay.hide();
      var decodedResponseData = jsonDecode(await signUpResponseValue.stream.bytesToString());
      print(decodedResponseData);
      if (decodedResponseData['status'] == true) {
        phoneController.text = phone.trim();
        authProvider.sendOtpToUserNumber(phone).then((otpResponse) async {
          var decodedData = jsonDecode(await otpResponse.stream.bytesToString());
          if (decodedData['status'] == true) {
            Fluttertoast.showToast(
              msg: decodedData['message'],
              gravity: ToastGravity.CENTER,
            );
            countDown();
            Get.to(() => VerificationPageView(
                  newUser: true,
                  newUserToken: decodedResponseData['token'],
                ));
          } else {
            Fluttertoast.showToast(
              msg: decodedData['message'],
              gravity: ToastGravity.CENTER,
            );
          }
        });
      } else {
        Fluttertoast.showToast(
          msg: decodedResponseData['message'],
          gravity: ToastGravity.CENTER,
        );
      }
    });
  }

  sendOtp(BuildContext context, String phone) async {
    context.loaderOverlay.show();
    authProvider.sendOtpToUserNumber(phone).then((response) async {
      context.loaderOverlay.hide();
      isClicked.value = true;
      if (kDebugMode) {
        print(jsonDecode(await response.stream.bytesToString()));
      }
      if (response.statusCode == 200) {
        countDown();
        Fluttertoast.showToast(
          msg: 'Otp Sent SucessFully',
          gravity: ToastGravity.CENTER,
        );
      }
    });
  }

  Future<int> countDown() async {
    canResendOtp.value = false;
    for (timer.value = 30; timer.value >= 0; timer.value--) {
      await Future.delayed(Duration(seconds: 1), () {});
    }
    if (timer.value <= 1) {
      canResendOtp.value = true;
    }
    return timer.value;
  }

  ///User Info Detail
  TextEditingController userTitleController = TextEditingController();
  TextEditingController userFullNameController = TextEditingController();
  TextEditingController userSpecializationController = TextEditingController();
  var userGenderValue = 0.obs;
  TextEditingController userQualificationDetailsController = TextEditingController();
  TextEditingController idProofImagePathController = TextEditingController();
  TextEditingController aboutTextController = TextEditingController();
  void selectProfileImage() async {
    userImage = await picker.pickImage(source: ImageSource.gallery);
    print(selectedUserImage.value);
    if (userImage != null) {
      selectedUserImage.value = userImage!.path;
    }
  }

  selectImageFromGallery() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      idProofImagePathController.text = image!.path;
      selectedIdentityProof.value = image!.path;
    }
  }

  selectImageForEducationFromGallery() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      userQualificationDetailsController.text = image!.path;
      selectedEducationImage.value = image!.path;
    }
  }

  ///verification page
  //Forget
  var isClicked = false.obs;
  var canResendOtp = false.obs;
  var timer = 0.obs;
  var showResetPasswordField = false.obs;
  TextEditingController otpNumber = TextEditingController();
  TextEditingController setNewPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();
  // sendOtp(BuildContext context,String phone)async {
  //   context.loaderOverlay.show();
  //   if(phone.isNotEmpty){
  //     await Future.delayed(Duration(seconds: 3),(){
  //       Get.to(()=>HomeView());
  //     });
  //   }
  // }
  setPassword(String password) async {
    if (password.isNotEmpty) {
      await Future.delayed(Duration(seconds: 3), () {});
    }
    Get.to(() => SignInView());
  }

  saveNewUserInfo({
    required String newUserToken,
    required String name,
    required String title,
    required String gender,
    required List<String> counselling,
    required String specialization,
    required String about,
    required String avatar,
    required String education_proof,
    required String id_proof,
  }) async {
    await authProvider.saveNewUserInfo(
        newUserToken: newUserToken,
        name: name,
        title: title,
        about: about,
        gender: gender,
        counselling: counselling,
        specialization: specialization,
        avatar: avatar,
        education_proof: education_proof,
        id_proof: id_proof);
  }

  @override
  void onInit() {
    getTherapistType();
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
