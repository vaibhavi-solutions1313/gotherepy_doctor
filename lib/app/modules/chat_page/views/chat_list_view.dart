import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gotherepy_doctor/app/appWidgets/appButtons.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /*TabBar(
              padding: EdgeInsets.all(6.0),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Colors.tealAccent
              ),
                controller: controller.chatTabController,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                tabs: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 4.0),
                    child: Text('Request\'s'),
                  ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 4.0),
                child: Text('Chats'),
              ),

            ]),*/
            Container(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                border:
                Border.all(width: 1, color: AppColors.lightGreyTextColor),
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.transparent,
              ),
              child: TabBar(
                padding: EdgeInsets.zero,
                // indicatorPadding: EdgeInsets.all(15.0),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: AppColors.bluishColor,
                ),
                labelColor: Colors.white,
                labelStyle:
                TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                unselectedLabelStyle:
                TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                // isScrollable: true,
                indicatorSize: TabBarIndicatorSize.tab,
                unselectedLabelColor: AppColors.lightGreyTextColor,
                controller: controller.chatTabController,
                tabs: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      // color: Color(0xFFF5C316),
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                        child: Text(
                          'Requests'.tr,
                        )),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                        child: Text(
                          'Chats'.tr,
                        )),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: controller.chatTabController,
                  children: [
                    GetBuilder(
                        init: ChatPageController(),
                        builder: (appointmentController){
                      return FutureBuilder(future: controller.getAppointmentRequests(doctorId: doctorInfo.records!.doctorId.toString(),
                          type: "chat", status: 'pending'),
                          builder: (context, snapData){
                            if(snapData.connectionState==ConnectionState.waiting){
                              return Center(child: CircularProgressIndicator());
                            }else{
                              if(snapData.data!.results!=null){
                                return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapData.data!.results!.length,
                                    itemBuilder: (buildContext, index){
                                      return  Container(
                                          margin: EdgeInsets.symmetric(horizontal: 6.0,vertical: 16.0),
                                          padding: EdgeInsets.all(12.0),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(16.0),
                                              border: Border.all(width: 0.5,color: AppColors.bluishColor)
                                          ),
                                          child:Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      CircleAvatar(),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(snapData.data!.results![index].patientName??'N/A'),
                                                          Container(
                                                            // color: Colors.red,
                                                            child: RichText(
                                                              softWrap: true,
                                                              textAlign: TextAlign.start,
                                                                text: TextSpan(
                                                                    style: TextStyle(color: Colors.black26,),
                                                                    children: [
                                                              TextSpan(text:'Type:',),
                                                              WidgetSpan(
                                                                alignment: PlaceholderAlignment.middle,
                                                                  child: Container(
                                                                margin: EdgeInsets.symmetric(vertical: 3.0),
                                                                padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 1.0),
                                                                  decoration: BoxDecoration(
                                                                    color: AppColors.appThemeColor.withOpacity(0.3),
                                                                    borderRadius: BorderRadius.circular(16.0),
                                                                  ),
                                                                  child: Text('${snapData.data!.results![index].bookingType??'N/A'}')))

                                                            ])),
                                                          )
                                                        ],
                                                      ),

                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(snapData.data!.results![index].bookingDate??'N/A'),
                                                      Text("Booking Id: ${snapData.data!.results![index].id!=null?snapData.data!.results![index].id!.toString():'#####'}"),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(6.0),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(16.0),
                                                    border: Border.all(width: 0.3,color: AppColors.bluishColor.withOpacity(0.4))
                                                ),
                                                child: Text('${snapData.data!.results![index].bookingStartTime??'N/A'} - ${snapData.data!.results![index].bookingEndTime??'N/A'}'),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  CustomSolidButton( onClick: (){
                                                    controller.acceptAppointment(bookingId: snapData.data!.results![index].id.toString(), bookingType: snapData.data!.results![index].bookingType!).then((value) {
                                                      controller.update();
                                                    });
                                                  },vPadding: 4.0,boxColor:AppColors.bluishColor,buttonText: 'accept',),
                                                  CustomSolidButton( onClick: (){
                                                    // controller.cancelAppointment();
                                                  },vPadding: 4.0,buttonText: 'Reject',),
                                                ],
                                              ),
                                            ],
                                          )
                                      );
                                    });
                              }else{
                                return Text('empty');
                              }
                            }

                          });
                    }),
                    GetBuilder<ChatPageController>(
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
                                        return Container(
                                          margin: EdgeInsets.symmetric(horizontal: 6.0,vertical: 16.0),
                                          child: Column(
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
                                          ),
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

              ]),
            ),
          ],),
      ),
    );
  }
}

class MyCustomClip extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path path=Path();
    path.lineTo(0, 20);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }
}
