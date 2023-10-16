import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../appWidgets/appTextField.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../app_constants/app_images.dart';
import '../../../app_constants/constants_appColors.dart';
import '../controllers/chat_page_controller.dart';
import '../model/conversation.dart';

class ChatPageView extends GetView<ChatPageController> {
  final String? userId;
  final String? patientName;
  const ChatPageView( {Key? key, this.userId,this.patientName, }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ChatPageController controller=ChatPageController();
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
                      InkWell(
                          onTap:(){
                            Get.back();
                          },
                          child: Icon(Icons.arrow_back)),
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
                                  Text16by600(text: patientName??'Hello user',color: Colors.white,),
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
          Expanded(
            child: FutureBuilder<Rx<Conversation>>(
                future: controller.getConversation(userId: userId.toString(), doctorId: doctorInfo.records!.doctorId!.toString()),
                builder: (context,snapData){
                  if(snapData.connectionState==ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(),);
                  }else if(snapData.hasError){
                    return Center(child: Text('snapData.error.toString()'),);
                  }else{
                    controller.userConversation.value=snapData.data!.value;
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() => controller.userConversation.value.results!.isNotEmpty?
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            reverse: true,
                            itemCount: controller.userConversation.value.results!.length,
                            itemBuilder: (context, index) {
                              return Align(
                                  alignment: controller.userConversation.value.results![index].isDoctorUser!=0?Alignment.centerRight:Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ChatMessage(text: controller.userConversation.value.results![index].message.toString(),alignment: controller.userConversation.value.results![index].isDoctorUser!),
                                  ));
                            },
                          ),
                        )
                            :Center(child: Text('No chats available')
                        ),),
                        Row(
                          children: [
                            IconButton(onPressed: (){}, icon: Icon(Icons.emoji_emotions_outlined,color: Colors.grey,size: 28)),
                            // IconButton(onPressed: (){}, icon: Icon(Icons.camera_alt_outlined,color: Colors.grey,size: 28)),
                            Expanded(child: Container(child: CustomTextFieldWithoutBorderAndHeading(hintText: 'Type Your problems', textEditingController: controller.messageEditingController, maxLine: 1,))),
                            Obx(() => IconButton(onPressed: (){
                              controller.sendMessages(
                                  userId: userId.toString(),
                                  doctorId: doctorInfo.records!.doctorId!.toString(),
                                  message: controller.messageEditingController.text.trim(),
                              ).whenComplete(() {
                                controller.getConversation(userId: userId.toString(), doctorId: doctorInfo.records!.doctorId!.toString(),);
                              });
                              controller.messageEditingController.clear();
                            },
                                icon: controller.isMessagingFetching.value?const CircularProgressIndicator():Icon(Icons.send,color: Colors.grey,size: 28,))),
                          ],
                        )
                      ],
                    );
                  }
                }
            ),
          ),
        ],
      ),
    );
  }
}
class ChatMessage extends StatelessWidget {
  final String text;
  final int alignment;
  const ChatMessage({super.key, required this.text, required this.alignment});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(alignment==0?20.0:30.0),
          topLeft: Radius.circular(alignment==0?30.0:20.0),
          bottomRight: Radius.circular(alignment==0?20.0:0.0),
          bottomLeft: Radius.circular(alignment==0?0.0:20.0),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }
}