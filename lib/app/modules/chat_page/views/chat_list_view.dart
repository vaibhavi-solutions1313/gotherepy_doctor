import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../main.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../appWidgets/universalAppBar.dart';
import '../../../app_constants/constants_appColors.dart';
import '../../../app_constants/constants_end_points.dart';
import '../controllers/chat_page_controller.dart';
import '../model/chat_list_model.dart';
import 'chat_page_view.dart';


class ChatListView extends GetView<ChatPageController> {  
  const ChatListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomUniversalAppBar(title: 'Chat with our experts', appBar: AppBar(),),
      // body: Obx(() => Get.find<HomeController>().usersAppointmentsModel.value.results!.isNotEmpty?
      // ListView.builder(
      //     itemCount: Get.find<HomeController>().usersAppointmentsModel.value.results!.length,
      //     itemBuilder: (context,index){
      //   return  Column(
      //     children: [
      //       ListTile(
      //         onTap: (){
      //           Get.to(()=>ChatPageView(userId: '${Get.find<HomeController>().usersAppointmentsModel.value.results![index].userId??''}',patientName: Get.find<HomeController>().usersAppointmentsModel.value.results![index].patientName??'',));
      //         },
      //         // leading: Padding(
      //         //   padding: const EdgeInsets.only(right: 8.0),
      //         //   child: CircularPercentIndicator(
      //         //     radius: 25.0,
      //         //     animation: true,
      //         //     animationDuration: 1200,
      //         //     linearGradient: const LinearGradient(
      //         //       begin: Alignment.topRight,
      //         //       end: Alignment.bottomLeft,
      //         //       colors: [
      //         //         Color(0xFF44C3D4),
      //         //         Color(0xFF44C3D4),
      //         //       ],
      //         //     ),
      //         //     lineWidth: 2.0,
      //         //     percent: 0.6,
      //         //     center: CircleAvatar(
      //         //         radius: 30,
      //         //         backgroundColor: Colors.red,
      //         //         child: ClipRRect(
      //         //             borderRadius: BorderRadius.circular(140.0),
      //         //             child: Image.network( EndPoints.imageBaseUrl+Get.find<HomeController>().usersAppointmentsModel.value.results![index].))),
      //         //     circularStrokeCap: CircularStrokeCap.round,
      //         //     startAngle: 150,
      //         //     backgroundColor: Colors.transparent,
      //         //   ),
      //         // ),
      //         title:   Text14by400(text: Get.find<HomeController>().usersAppointmentsModel.value.results![index].patientName??''),
      //         subtitle: Text14by400(text: Get.find<HomeController>().usersAppointmentsModel.value.results![index].reason??'', color: AppColors.lightGreyTextColor),
      //       ),
      //       Divider(),
      //     ],
      //   );
      // })
      // :Text16by700(text: 'No chats')),
      body: GetBuilder<ChatPageController>(
        init: ChatPageController(),
        builder: (getBuilderController) {
          if(doctorInfo.records!.doctorId!=null) {
            print('5555555555555555555555----------5555555555555555555555');
            return FutureBuilder<ChatListModel>(
              future: controller.getAllChatList(userId: doctorInfo.records!.doctorId!.toString()),
              builder: (context, snapData) {
                print('nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn');
                print(doctorInfo.records!.doctorId);
                print(snapData.data.toString());
                if (snapData.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapData.hasError) {
                  return Center(
                      child: Text16by400(
                    text: 'Something went wrong',
                    fontSize: 12,
                    color: AppColors.lightGreyTextColor,
                  ));
                } else {
                  if (snapData.data!.results!.isEmpty) {
                    return Center(
                        child: Text16by400(
                      text: 'Not available',
                      fontSize: 12,
                      color: AppColors.lightGreyTextColor,
                    )
                    );
                  } else {
                    // allTherapist=snapData.data;
                    return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapData.data!.results?.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  if(snapData.data!.results![index].doctorId!=null){
                                    Get.to(() => ChatPageView(
                                      userId: snapData.data!.results![index].doctorId!.toString(),
                                    ));
                                  }else{
                                    Fluttertoast.showToast(msg: 'Doctor not available');
                                  }
                                  },
                                leading: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: CircularPercentIndicator(
                                    radius: 25.0,
                                    animation: true,
                                    animationDuration: 1200,
                                    linearGradient: const LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Color(0xFF44C3D4),
                                        Color(0xFF44C3D4),
                                      ],
                                    ),
                                    lineWidth: 2.0,
                                    percent: 0.6,
                                    center: CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.red,
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(140.0),
                                            child: Image.network(snapData.data!.results != null && snapData.data!.results![index].avatar!=null
                                                ? EndPoints.imageBaseUrl + snapData.data!.results![index].avatar!
                                                : ''))),
                                    circularStrokeCap: CircularStrokeCap.round,
                                    startAngle: 150,
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                                title: Text14by400(text: snapData.data!.results?[index].patientName ?? ''),
                                subtitle: Text14by400(text: snapData.data!.results?[index].message.toString() ?? '', color: AppColors.lightGreyTextColor),
                                trailing:  Text14by400(text: DateTime.parse(snapData.data!.results![index].bookingDate!).day.toString()+"-" +DateTime.parse(snapData.data!.results![index].bookingDate!).month.toString()+"-" +DateTime.parse(snapData.data!.results![index].bookingDate!).year.toString() ?? 'N/A', color: AppColors.lightGreyTextColor),
                              ),
                              Divider(height: 0.0,),
                            ],
                          );
                        });
                  }
                }
              },
            );
          }else{
            return Center(child: Text('No chats'),);
          }
        },

      ),

    );
  }
}
