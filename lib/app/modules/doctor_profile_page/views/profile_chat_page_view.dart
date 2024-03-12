import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gotherepy_doctor/app/appWidgets/appButtons.dart';
import 'package:gotherepy_doctor/app/modules/doctor_profile_page/controllers/profile_chat_page_controller.dart';
import '../../../../main.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../appWidgets/universalAppBar.dart';
import '../../../app_constants/app_images.dart';
import '../../../app_constants/constants_appColors.dart';
import '../../chat_page/controllers/chat_page_controller.dart';
import '../../chat_page/views/chat_page_view.dart';


class ProfileChatPageView extends GetView<ChatPageController> {
   ProfileChatPageView({Key? key}) : super(key: key);

  ProfileChatPageController _profileChatPageController = Get.put(ProfileChatPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.arrow_back, size: 18,)
        ),
        // leadingWidth: 30,
        titleSpacing: 0,
        flexibleSpace: Container(
          height: 100,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [AppColors.bluishColor,
                AppColors.bluishColor.withOpacity(0.7)]),
              image: DecorationImage(image: AssetImage(AppImages.appbarBackgroundPngImage),
                  fit: BoxFit.fitWidth)),
        ),
        centerTitle: false,
        title: Text(
          'Chat',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
                          'Waiting'.tr,
                        )),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                        child: Text(
                          'Queue'.tr,
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
                                              margin: EdgeInsets.symmetric(horizontal: 6.0,vertical: 8.0),
                                              padding: EdgeInsets.all(12.0),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(16.0),
                                                  border: Border.all(width: 1.0,color: Colors.grey.shade300)
                                              ),
                                              child:Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text('Patient For: ',
                                                                style: TextStyle(
                                                                  color: AppColors.bluishTextColor,
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.bold
                                                                ),

                                                              ),
                                                              Text(snapData.data!.results![index].bookingType?.toUpperCase()??'N/A',
                                                                style: TextStyle(
                                                                    color: AppColors.bluishTextColor,
                                                                    fontSize: 14,
                                                                    fontWeight: FontWeight.bold
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 10,),
                                                          Row(
                                                            children: [
                                                              Text('Patient Name: ',
                                                                style: TextStyle(
                                                                    fontSize: 12,
                                                                ),

                                                              ),
                                                              Text(snapData.data!.results![index].patientName ?? 'N/A',
                                                                style: TextStyle(
                                                                    color: AppColors.blackish5E5E5E,
                                                                    fontSize: 12,
                                                                    fontWeight: FontWeight.bold
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 10,),
                                                          Row(
                                                            children: [
                                                              Text('Session: ',
                                                                style: TextStyle(
                                                                    fontSize: 12,
                                                                ),
                                                                textAlign: TextAlign.start,
                                                              ),
                                                              Text(snapData.data!.results![index].id.toString(),
                                                                style: TextStyle(
                                                                    color: AppColors.blackish5E5E5E,
                                                                    fontSize: 12,
                                                                    fontWeight: FontWeight.bold
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      CircleAvatar(
                                                        radius: 30,
                                                        backgroundImage: AssetImage('assets/sample_image.jpg'),
                                                        // child: Image.network(
                                                        //     snapData.data!.results != null && snapData.data!.results![index].avatar!=null
                                                        //         ? EndPoints.imageBaseUrl + snapData.data!.results![index].avatar!
                                                        //         : ''
                                                        // ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(Icons.calendar_month, color: AppColors.greyColor676464, size: 14,),
                                                          SizedBox(width: 5,),
                                                          Text(
                                                              '${snapData.data!.results![index].bookingDate ??'N/A'}',
                                                            style: TextStyle(
                                                                color: AppColors.blackish5E5E5E,
                                                                fontSize: 14,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      // SizedBox(width: 40,),
                                                      Row(
                                                        children: [
                                                          Icon(Icons.access_time, color: AppColors.greyColor676464, size: 14,),
                                                          SizedBox(width: 5,),
                                                          Text(
                                                            '${snapData.data!.results![index].bookingStartTime??'N/A'} - ${snapData.data!.results![index].bookingEndTime??'N/A'}',
                                                            style: TextStyle(
                                                              color: AppColors.blackish5E5E5E,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  CustomSolidButton( onClick: (){
                                                    // controller.cancelAppointment();
                                                    if(snapData.data!.results![index].doctorId!=null){
                                                      Get.to(() => ChatPageView(
                                                        userId: snapData.data!.results![index].doctorId!.toString(),
                                                      ));
                                                    }else{
                                                      Fluttertoast.showToast(msg: 'Patient not available');
                                                    }
                                                  },
                                                    vPadding:8.0,buttonText: 'Chat', fontSize: 14,),
                                                ],
                                              )
                                          );
                                        });
                                  }else{
                                    return Text('No waiting chats to be displayed...');
                                  }
                                }

                              });
                        }),
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
                                              margin: EdgeInsets.symmetric(horizontal: 6.0,vertical: 8.0),
                                              padding: EdgeInsets.all(12.0),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(16.0),
                                                  border: Border.all(width: 1.0,color: Colors.grey.shade300)
                                              ),
                                              child:Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text('Patient For: ',
                                                                style: TextStyle(
                                                                  color: AppColors.bluishTextColor,
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.bold
                                                                ),

                                                              ),
                                                              Text(snapData.data!.results![index].bookingType?.toUpperCase()??'N/A',
                                                                style: TextStyle(
                                                                    color: AppColors.bluishTextColor,
                                                                    fontSize: 14,
                                                                    fontWeight: FontWeight.bold
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 10,),
                                                          Row(
                                                            children: [
                                                              Text('Patient Name: ',
                                                                style: TextStyle(
                                                                    fontSize: 12,
                                                                ),

                                                              ),
                                                              Text(snapData.data!.results![index].patientName ?? 'N/A',
                                                                style: TextStyle(
                                                                    color: AppColors.blackish5E5E5E,
                                                                    fontSize: 12,
                                                                    fontWeight: FontWeight.bold
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 10,),
                                                          Row(
                                                            children: [
                                                              Text('Session: ',
                                                                style: TextStyle(
                                                                    fontSize: 12,
                                                                ),
                                                                textAlign: TextAlign.start,
                                                              ),
                                                              Text(snapData.data!.results![index].id.toString(),
                                                                style: TextStyle(
                                                                    color: AppColors.blackish5E5E5E,
                                                                    fontSize: 12,
                                                                    fontWeight: FontWeight.bold
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      CircleAvatar(
                                                        radius: 30,
                                                        backgroundImage: AssetImage('assets/sample_image.jpg'),
                                                        // child: Image.network(
                                                        //     snapData.data!.results != null && snapData.data!.results![index].avatar!=null
                                                        //         ? EndPoints.imageBaseUrl + snapData.data!.results![index].avatar!
                                                        //         : ''
                                                        // ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(Icons.calendar_month, color: AppColors.greyColor676464, size: 14,),
                                                          SizedBox(width: 5,),
                                                          Text(
                                                              '${snapData.data!.results![index].bookingDate ??'N/A'}',
                                                            style: TextStyle(
                                                                color: AppColors.blackish5E5E5E,
                                                                fontSize: 14,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      // SizedBox(width: 40,),
                                                      Row(
                                                        children: [
                                                          Icon(Icons.access_time, color: AppColors.greyColor676464, size: 14,),
                                                          SizedBox(width: 5,),
                                                          Text(
                                                            '${snapData.data!.results![index].bookingStartTime??'N/A'} - ${snapData.data!.results![index].bookingEndTime??'N/A'}',
                                                            style: TextStyle(
                                                              color: AppColors.blackish5E5E5E,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      CustomSolidButton( onClick: (){
                                                        // controller.cancelAppointment();
                                                        Fluttertoast.showToast(msg: 'Chat is approved');
                                                      },
                                                        vPadding:8.0,buttonText: 'Approve', fontSize: 14, hPadding: 48,),

                                                      CustomSolidButton( onClick: () {
                                                        // controller.cancelAppointment();
                                                        Get.defaultDialog(
                                                            titlePadding: EdgeInsets.zero,
                                                            contentPadding: EdgeInsets.zero,
                                                            title: '',
                                                            middleText: '',
                                                            content: Flexible(
                                                              child: SingleChildScrollView(
                                                                child: Container(
                                                                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                                                                  child: Column(
                                                                    children: [
                                                                      Icon(
                                                                        Icons.cancel_outlined,
                                                                        size: 56,
                                                                        color: AppColors.greyTextColor,
                                                                      ),
                                                                      const SizedBox(
                                                                        height: 10,
                                                                      ),
                                                                      const Text16by600(
                                                                        text: 'Cancel',
                                                                        fontSize: 20,
                                                                      ),
                                                                      const SizedBox(
                                                                        height: 15,
                                                                      ),
                                                                      const FooterTextWithCenterAligned(
                                                                        text:
                                                                        'Please give specific reason.',
                                                                        fontSize: 16,
                                                                      ),
                                                                      const SizedBox(
                                                                        height: 10,
                                                                      ),
                                                                      TextField(
                                                                        controller:
                                                                        _profileChatPageController.reasonController,
                                                                        maxLines: 4,
                                                                        keyboardType:
                                                                        TextInputType
                                                                            .multiline,
                                                                        decoration:
                                                                        InputDecoration(
                                                                          filled:
                                                                          true,
                                                                          fillColor:
                                                                          Colors.grey[
                                                                          300],
                                                                          hintText:
                                                                          'Type here...',
                                                                          border:
                                                                          OutlineInputBorder(
                                                                            borderRadius:
                                                                            BorderRadius.circular(
                                                                                10.0),
                                                                            borderSide:
                                                                            BorderSide
                                                                                .none,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height: 10,
                                                                      ),
                                                                      CustomSolidButton(
                                                                        buttonText:
                                                                        'Cancel',
                                                                        onClick:
                                                                            () async {
                                                                          /// TODO: Implement reject event
                                                                          Navigator.pop(context);
                                                                          Fluttertoast.showToast(msg: 'Chat is rejected');
                                                                          // Get.to(() => SessionPageView());
                                                                          // Get.back();
                                                                        },
                                                                        fontSize: 16,
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ));
                                                      },
                                                        vPadding:8.0,buttonText: 'Reject',
                                                        fontSize: 14, hPadding: 48,
                                                        boxColor: AppColors.redishD44041,),
                                                    ],
                                                  ),
                                                ],
                                              )
                                          );
                                        });
                                  }else{
                                    return Text('No waiting chats to be displayed...');
                                  }
                                }

                              });
                        }),

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
