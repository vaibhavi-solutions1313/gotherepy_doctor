import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gotherepy_doctor/app/modules/auth_page/views/sign_in_view.dart';
import 'package:gotherepy_doctor/app/modules/auth_page/views/sign_up_view.dart';

import '../../../appWidgets/appButtons.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../app_constants/app_images.dart';
import '../../../app_constants/constants_appColors.dart';
import '../controllers/auth_page_controller.dart';

class AuthPageView extends GetView<AuthPageController> {
  const AuthPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AuthPageController authPageController=Get.put(AuthPageController(),permanent: true);
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: Container(
        height: Get.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.backgroundPngImage),repeat: ImageRepeat.repeat,),
        ),
        child: ListView(
          children: [
            Image.asset(AppImages.appLogoImage1,height:Get.height/4,fit: BoxFit.fitHeight,),
            Image.asset(AppImages.yogaImage,height:Get.height/4,fit: BoxFit.fitHeight),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text14by500(text: 'Register youself as',fontSize: 20,color: AppColors.bluishColor,),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ItemContainerWithBottomTitle(bottomTitle: 'Councillor',imagePath: AppImages.authCouncillorImage),
                      ItemContainerWithBottomTitle(bottomTitle: 'Yoga trainer',imagePath: AppImages.authYogaTrainerImage),
                      ItemContainerWithBottomTitle(bottomTitle: 'Meditator',imagePath: AppImages.authMeditatorImage),
                    ],
                  ),
                  SizedBox(height: 20,),
                  BorderButton(buttonText: 'Already Have an Account Sign In', onClick: () {Get.to(()=>const SignInView());},),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemContainerWithBottomTitle extends StatefulWidget {
  final String imagePath;
  final String bottomTitle;
  const ItemContainerWithBottomTitle({
    super.key, required this.imagePath, required this.bottomTitle,
  });

  @override
  State<ItemContainerWithBottomTitle> createState() => _ItemContainerWithBottomTitleState();
}

class _ItemContainerWithBottomTitleState extends State<ItemContainerWithBottomTitle> {
  @override
  Widget build(BuildContext context) {
    var isPressed=true.obs;
    return Column(
      children: [
        Obx(()=> InkWell(
          borderRadius: BorderRadius.circular(10.0),
          onTap:()async{
            isPressed.value=!isPressed.value;
            await Future.delayed(Duration(milliseconds: 60),(){
              isPressed.value=true;
              Get.to(()=>SignUpView());
            });

          },
          child: Container(
            height: 80,
            width: 80,
            padding: EdgeInsets.all(4.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  isPressed.value?
                  BoxShadow(
                      offset: Offset(0.0, 2.0),
                      color: AppColors.greyColor676464.withOpacity(0.8),
                      spreadRadius: -0.5,
                      blurRadius: 2.0
                  )
                      : BoxShadow(
                      offset: Offset(0.0, 2.0),
                      color: AppColors.greyColor676464.withOpacity(0.8),
                      spreadRadius: 0.0,
                      blurRadius: 0.0
                  )
                ]
            ),
            child: Image.asset(widget.imagePath),
          ),
        )),
         Padding(
           padding: const EdgeInsets.only(top: 4.0),
           child: Text(widget.bottomTitle,style: const TextStyle(
            color: Color(0xff777777),
            fontSize: 13,
              fontWeight: FontWeight.w300),),
         )
      ],
    );
  }
}

class LoginWith extends StatelessWidget {
  const LoginWith({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        SizedBox(height: 25,),
        Row(
          children: [
            Expanded(
              child: Divider(
                thickness: 2,
                height: 42,
                color: AppColors.lightGreyTextColor,
              ),
            ),
            Text16by400(text: ' Login With ',fontSize:14,color: AppColors.lightGreyTextColor,),
            Expanded(
              child: Divider(
                thickness: 2,
                height: 42,
                color: AppColors.lightGreyTextColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 15,),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: (){},
                    child: Ink(
                      padding: EdgeInsets.only(left: 0.0,top: 20.0,right: 30.0,bottom: 20.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                              width: 1,
                              color: AppColors.lightGreyTextColor
                          )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(AppImages.fbLogo,height: 25,width: 25,fit: BoxFit.fitHeight,),
                          Text16by400(text: 'Facebook')
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: (){},
                    child: Ink(
                      padding: EdgeInsets.only(left: 0.0,top: 20.0,right: 30.0,bottom: 20.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                              width: 1,
                              color: AppColors.lightGreyTextColor
                          )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(AppImages.googleLogo,height: 25,width: 25,fit: BoxFit.fitHeight,),
                          Text16by400(text: 'Google')
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),


          ],
        ),
        SizedBox(height: 10,),
      ],
    );
  }
}
