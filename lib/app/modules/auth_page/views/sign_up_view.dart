import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotherepy_doctor/app/modules/auth_page/views/sign_in_view.dart';
import 'package:gotherepy_doctor/app/modules/auth_page/views/verification_page_view.dart';
import '../../../appWidgets/appButtons.dart';
import '../../../appWidgets/appTextField.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../app_constants/app_images.dart';
import '../../../app_constants/constants_appColors.dart';
import '../controllers/auth_page_controller.dart';


class SignUpView extends GetView {
  const SignUpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AuthPageController authPageController=Get.find<AuthPageController>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        // fit: StackFit.passthrough,
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.red,
                gradient: LinearGradient(colors: [AppColors.bluishColor, AppColors.bluishColor.withOpacity(0.7)]),
                image: DecorationImage(
                  image: AssetImage(AppImages.appbarBackgroundPngImage),
                  repeat: ImageRepeat.repeat,
                )

            ),
            child: SafeArea(
              child: Text('GoTherapy',style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),textAlign: TextAlign.center,),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: Get.width,
              height: Get.height / 1.13,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(25),topLeft: Radius.circular(25))
              ),
              child: ListView(
                      padding: EdgeInsets.symmetric(vertical: 25.0,horizontal: 18),
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Form(
                          key: authPageController.signUpFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text16by400(text: 'Enter your details',fontSize: 24),
                              SizedBox(height: 15,),
                              CustomTextFieldWithTitle(title: 'Username', textEditingController: authPageController.usernameController, hintText: 'Username',),
                              CustomTextFieldWithTitle(title: 'Email address', textEditingController: authPageController.signUpEmailController, hintText: 'Email address',),
                              CustomTextFieldWithTitle(title: 'Mobile number', textEditingController: authPageController.signUpPhoneController, hintText: 'Mobile number',inputType: TextInputType.number,),
                              CustomPasswordTextField(title: 'Password', textEditingController: authPageController.signUpPasswordController, hintText: 'Password', inputType: TextInputType.phone, isObscureText: true,),
                              CustomPasswordTextField(title: 'Confirm Password', textEditingController: authPageController.confirmPasswordController, hintText: 'Password', inputType: TextInputType.phone, isObscureText: true,),
                              SizedBox(height: 25,),
                              CustomSolidButton(buttonText: 'Sign up', onClick: (){
                                if(GetUtils.isEmail(authPageController.signUpEmailController.text)){
                                  if(authPageController.signUpFormKey.currentState!.validate()){
                                    if(authPageController.signUpPasswordController.text==authPageController.confirmPasswordController.text){
                                      authPageController.signUpNewUser(context);

                                    }else {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password mismatched')));
                                    }
                                  }
                                }
                                else {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Enter Valid Email')));
                                }
                              }),
                            ],
                          ),),],
            ),
          ))



          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.stretch,
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     Container(
          //       height:  Get.height,
          //       padding: EdgeInsets.only(top: 16.0),
          //       decoration: BoxDecoration(
          //           gradient: LinearGradient(colors: [AppColors.bluishColor, AppColors.bluishColor.withOpacity(0.7)]),
          //           image: DecorationImage(
          //               image: AssetImage(AppImages.appbarBackgroundPngImage),
          //             repeat: ImageRepeat.repeat,
          //           )
          //       ),
          //       child: SafeArea(
          //         child: Text('GoTherapy',style: TextStyle(
          //           color: Colors.white,
          //           fontSize: 30,
          //           fontWeight: FontWeight.w700,
          //         ),textAlign: TextAlign.center,),
          //       ),
          //     ),
          //   ],
          // ),
          // DraggableScrollableSheet(
          //   // expand: true,
          //     initialChildSize: 0.86,
          //     minChildSize: 0.45,
          //     maxChildSize: 0.86,
          //     builder: (context,scrollController){
          //   return Container(
          //     padding: EdgeInsets.all(18.0),
          //     decoration: const BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
          //     ),
          //     child: ListView(
          //       padding: EdgeInsets.symmetric(vertical: 18.0),
          //       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Form(
          //           key: authPageController.signUpFormKey,
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text16by400(text: 'Enter your details',fontSize: 24),
          //               SizedBox(height: 15,),
          //               CustomTextFieldWithTitle(title: 'Username', textEditingController: authPageController.usernameController, hintText: 'Username',),
          //               CustomTextFieldWithTitle(title: 'Email address', textEditingController: authPageController.signUpEmailController, hintText: 'Email address',),
          //               CustomTextFieldWithTitle(title: 'Mobile number', textEditingController: authPageController.signUpPhoneController, hintText: 'Mobile number',inputType: TextInputType.number,),
          //               CustomPasswordTextField(title: 'Password', textEditingController: authPageController.signUpPasswordController, hintText: 'Password', inputType: TextInputType.phone, isObscureText: true,),
          //               CustomPasswordTextField(title: 'Confirm Password', textEditingController: authPageController.confirmPasswordController, hintText: 'Password', inputType: TextInputType.phone, isObscureText: true,),
          //               SizedBox(height: 25,),
          //               CustomSolidButton(buttonText: 'Sign up', onClick: (){
          //                 if(GetUtils.isEmail(authPageController.signUpEmailController.text)){
          //                   if(authPageController.signUpFormKey.currentState!.validate()){
          //                     if(authPageController.signUpPasswordController.text==authPageController.confirmPasswordController.text){
          //                       Get.to(()=>VerificationPageView(newUser: true,));
          //                     }else {
          //                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password mismatched')));
          //                     }
          //                   }
          //                 }
          //                 else {
          //                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Enter Valid Email')));
          //                 }
          //               }),
          //             ],
          //           ),
          //         ),
          //         SizedBox(height: 10,),
          //         Column(
          //           children: [
          //             RichText(
          //               textAlign: TextAlign.right,
          //               text:  TextSpan(
          //                   text: 'Already Have an Account? ',
          //                   style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: AppColors.blackishTextColor),
          //                   children: [
          //                     TextSpan(
          //                       recognizer: TapGestureRecognizer()..onTap=(){
          //                         Get.to(()=>SignInView());
          //                       },
          //                       text: 'Sign In ',
          //                       style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: AppColors.tealColor),
          //                     )]
          //               ),
          //             ),
          //             // LoginWith()
          //           ],
          //         )
          //       ],
          //     ),
          //   );
          // })

        ],
      ),
    );
  }
}