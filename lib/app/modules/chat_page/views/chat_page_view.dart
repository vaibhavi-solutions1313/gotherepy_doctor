import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../appWidgets/appTextField.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../app_constants/app_images.dart';
import '../../../app_constants/constants_appColors.dart';
import '../controllers/chat_page_controller.dart';

class ChatPageView extends GetView<ChatPageController> {
  const ChatPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController sendMessageController=TextEditingController();
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.tealColor.withOpacity(0.6),
                  AppColors.tealColor,
                  // AppColors.tealColor.withOpacity(0.7),
                  AppColors.bluishColor.withOpacity(0.8),
                  AppColors.bluishColor.withOpacity(0.9),
                  AppColors.bluishColor,
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
              image: DecorationImage(image: AssetImage(AppImages.appbarBackgroundPngImage),
                fit: BoxFit.cover,
                // repeat: ImageRepeat.repeatY
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.arrow_back),
                      SizedBox(width: 10),
                      Text16by600(text: 'Help',color: Colors.white),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(

                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30.0),
                                child: Container(
                                  height:60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent.withOpacity(0.8),
                                    shape: BoxShape.circle,
                                    image: DecorationImage(image: AssetImage(AppImages.marriage),
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  child: Image.asset(AppImages.marriage),
                                ),
                              ),
                              Text.rich(
                                TextSpan(text: 'Aevrage wait time',children: [
                                  TextSpan(text:' 3',style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500
                                  )),
                                  TextSpan(text:' minutes',style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500
                                  )),
                                ]),maxLines: 2,style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300
                              ),)
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text16by600(text: 'Hello',color: Colors.white,),
                                  Image.asset(AppImages().chatPageHandLogoOfPeace,height: 40,width: 50,)
                                ],
                              ),
                              Text.rich(TextSpan(text: 'We are here to help you'),maxLines: 2,style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300
                              ),)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.emoji_emotions_outlined,color: Colors.grey,size: 28)),
              IconButton(onPressed: (){}, icon: Icon(Icons.camera_alt_outlined,color: Colors.grey,size: 28)),
              Expanded(child: Container(child: CustomTextFieldWithoutBorderAndHeading(hintText: 'Type Your problems', textEditingController: sendMessageController, maxLine: 1,))),
              IconButton(onPressed: (){}, icon: Icon(Icons.send,color: Colors.grey,size: 28,)),
            ],
          )
        ],
      ),
    );
  }
}
