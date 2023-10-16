import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gotherepy_doctor/app/modules/auth_page/views/new_user_info_page_view.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../appWidgets/appButtons.dart';
import '../../../appWidgets/appTextField.dart';
import '../../../appWidgets/phoneTextField.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../app_constants/app_images.dart';
import '../../../app_constants/constants_appColors.dart';
import '../controllers/auth_page_controller.dart';

class VerificationPageView extends GetView {
  final bool newUser;
  final String? newUserToken;
  const VerificationPageView( {this.newUser=false,this.newUserToken, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AuthPageController authPageController=Get.find<AuthPageController>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                // width: Get.width,
                height:  150,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [AppColors.bluishColor, AppColors.bluishColor.withOpacity(0.7)]),
                    image: DecorationImage(
                        image: AssetImage(AppImages.appbarBackgroundPngImage),fit: BoxFit.fitWidth
                    )
                ),
                child: Center(child: Text('GoTherepy',style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),textAlign: TextAlign.center,)),
              ),
            ],
          ),
          Positioned(
            bottom: 0.0,
            height: Get.height-120,
            width: Get.width,
            child: Container(
              padding: EdgeInsets.all(18.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
              ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    if(newUser==true)...[Text('Sign up',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 24,color: AppColors.bluishTextColor),)],
                    if(newUser==false)...[Text('Reset Password',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 24,color: AppColors.bluishTextColor),)],
                    // :..[Text('Reset Password',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 24,color: AppColors.bluishTextColor),)],
                    Text16by400(text: 'Sign in to access your account',fontSize: 14,color: AppColors.greyTextColor,),
                    SizedBox(height: 50,),
                    Row(
                      children: [
                        Text16by400(text: 'Enter Your Mobile No',color: AppColors.greyTextColor,),
                      ],
                    ),
                    PhoneTextField(title: 'text', phoneController: authPageController.phoneController, hint: 'phone',),
                    Obx(() => CustomSolidButton(buttonText: authPageController.canResendOtp.value?'Send OTP':'Resend otp in ${authPageController.timer.value} sec',
                        boxColor: authPageController.canResendOtp.value?AppColors.tealColor:AppColors.greyColor676464.withOpacity(0.5),
                        onClick: (){
                      if(authPageController.phoneController.text.isNotEmpty){
                        authPageController.sendOtp(context,authPageController.phoneController.text);
                      }
                      authPageController.showResetPasswordField.value=true;
                    }),
                    ),
                    SizedBox(height: 30,),
                    Row(
                      children: [
                        Text16by400(text: 'Enter OTP',color: AppColors.greyTextColor,),
                      ],
                    ),
                    PinCodeTextField(
                      mainAxisAlignment: MainAxisAlignment.start,
                      keyboardType: TextInputType.phone,
                      controller: authPageController.otpNumber,
                      length: 4,
                      textStyle: TextStyle(color: Color(0xff00AC4F),),
                      obscureText: false,
                      enablePinAutofill: true,

                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        fieldOuterPadding: EdgeInsets.only(top:10.0,right: 10),
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 50,
                        activeFillColor: AppColors.scaffoldColor,
                        activeColor: AppColors.bluishColor,
                        selectedFillColor: Colors.white70,
                        selectedColor: AppColors.bluishColor,
                        inactiveFillColor:  AppColors.lightGreyTextColor.withOpacity(0.3),
                        inactiveColor: AppColors.lightGreyTextColor.withOpacity(0.4),
                      ),
                      animationDuration: const Duration(milliseconds: 300),
                      // backgroundColor: Colors.blue.shade50,
                      enableActiveFill: true,
                      // errorAnimationController: errorController,
                      // controller: textEditingController,
                      onCompleted: (v) {
                        print("Completed");
                        //verifyController.enteredOTP.value = v;
                      },
                      onChanged: (value) {
                        print(value);
                        // setState(() {
                        //   currentText = value;
                        // });
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      }, appContext: context,
                    ),
                    Row(
                      children: [
                        Text16by400(text: 'Send Again',fontSize: 12,color: AppColors.tealColor,),
                      ],
                    ),
                     if(newUser==false)...[Obx(() => Visibility(
                        visible: authPageController.showResetPasswordField.value,
                        child: Column(
                          children: [
                            CustomPasswordTextField(hintText: 'Password', textEditingController: authPageController.setNewPassword, title: 'Password'),
                            CustomPasswordTextField(hintText: 'Confirm Password', textEditingController: authPageController.confirmNewPassword, title: 'Confirm Password'),
                          ],
                        ),
                      ))],

                    CustomSolidButton(buttonText: newUser?'Submit':'Update', onClick: (){
                      if(newUser){
                        authPageController.authProvider.verifyOtp(mobile: authPageController.phoneController.text, otp:authPageController.otpNumber.text).then((value)async{
                          var decodedData=jsonDecode(await value.stream.bytesToString());
                          if(decodedData['status']==true){
                            Get.to(() =>  NewUserInfoPageView(newUserToken: newUserToken!,));
                          }else{
                            Fluttertoast.showToast(msg: decodedData['message']);
                          }
                        });

                      }
                      else if(authPageController.setNewPassword.text==authPageController.confirmNewPassword.text){
                        authPageController.setPassword(authPageController.setNewPassword.text);
                      }else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password not matched')));
                      }
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
