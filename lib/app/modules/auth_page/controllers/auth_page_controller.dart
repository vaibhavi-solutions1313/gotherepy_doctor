import 'package:flutter/cupertino.dart';
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

  ///Sign In
  final signInFormKey=GlobalKey<FormState>();
  final signUpFormKey=GlobalKey<FormState>();
  final newUserRegisterFormKey=GlobalKey<FormState>();
  TextEditingController emailController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  signInUser(BuildContext context,String email,String password){
    context.loaderOverlay.show();
    authProvider.loginUser().then((value){
      Future.delayed(Duration(seconds: 3),(){
        context.loaderOverlay.hide();
        Get.offAll(() => HomeView());
      });
     });
  }
  ///Sign Up
  TextEditingController usernameController=TextEditingController();
  TextEditingController signUpEmailController=TextEditingController();
  TextEditingController signUpPhoneController=TextEditingController();
  TextEditingController signUpPasswordController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();
signUpNewUser(BuildContext context,){
   Map data={};
  authProvider.registerUser(data).then((value) {
    Future.delayed(Duration(seconds: 3),(){
      Get.to(()=>const VerificationPageView(newUser: true,));
    });

  });
}
  ///User Info Detail Up
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
  var showResetPasswordField=false.obs;
  TextEditingController otpNumber=TextEditingController();
  TextEditingController setNewPassword=TextEditingController();
  TextEditingController confirmNewPassword=TextEditingController();
  sendOtp(BuildContext context,String phone)async {
    context.loaderOverlay.show();
    if(phone.isNotEmpty){
      await Future.delayed(Duration(seconds: 3),(){
        Get.to(()=>HomeView());
      });
    }
  }
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
