import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotherepy_doctor/app/modules/auth_page/views/sign_up_view.dart';
import 'package:gotherepy_doctor/app/modules/auth_page/views/verification_page_view.dart';
import '../../../appWidgets/appButtons.dart';
import '../../../appWidgets/appTextField.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../app_constants/app_images.dart';
import '../../../app_constants/constants_appColors.dart';
import '../../home/views/home_view.dart';
import '../controllers/auth_page_controller.dart';
import 'auth_page_view.dart';

class SignInView extends GetView {
  const SignInView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AuthPageController authPageController = Get.find<AuthPageController>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                // width: Get.width,
                height: 150,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [AppColors.bluishColor, AppColors.bluishColor.withOpacity(0.7)]),
                    image: DecorationImage(image: AssetImage(AppImages.appbarBackgroundPngImage), fit: BoxFit.fitWidth)),
                child: Center(
                    child: Text(
                  'GoTherapy',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                )),
              ),
            ],
          ),
          Positioned(
            bottom: 0.0,
            height: Get.height - 120,
            width: Get.width,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18.0,vertical: 30.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Form(
                    key: authPageController.signInFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text16by400(text: 'Welcome Back', fontSize: 24),
                        Text16by400(
                          text: 'Sign in with your account',
                          fontSize: 14,
                          color: AppColors.greyTextColor,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        CustomTextFieldWithTitle(
                          title: 'Username',
                          textEditingController: authPageController.emailController,
                          hintText: 'Username@email.com',
                        ),
                        CustomPasswordTextField(
                          title: 'Password',
                          textEditingController: authPageController.passwordController,
                          hintText: 'Password',
                          inputType: TextInputType.phone,
                          isObscureText: true,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        CustomSolidButton(
                            buttonText: 'Sign In',
                            onClick: () {
                              if (authPageController.signInFormKey.currentState!.validate()) {
                                Get.to(() => HomeView());
                              }
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            RichText(
                              textAlign: TextAlign.right,
                              text: TextSpan(
                                  text: 'Forgot your password? ',
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.bluishTextColor),
                                  children: [
                                    TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Get.to(() => VerificationPageView());
                                        },
                                      text: 'Reset here',
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.tealColor),
                                    )
                                  ]),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: RichText(
                            textAlign: TextAlign.right,
                            text: TextSpan(
                                text: 'Haven’t an Account? ',
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.blackishTextColor),
                                children: [
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.to(() => SignUpView());
                                      },
                                    text: 'Register ',
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.tealColor),
                                  )
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
