
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gotherepy_doctor/app/appWidgets/text_styles.dart';

import '../../../appWidgets/appButtons.dart';
import '../../../appWidgets/universalAppBar.dart';
import '../../../app_constants/constants_appColors.dart';
import '../controllers/session_page_controller.dart';

class CreateReportView extends GetView<SessionPageController> {
  final String userAppointmentId;
  const CreateReportView( {Key? key,required this.userAppointmentId,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomUniversalAppBar(title: 'Make Report',appBar: AppBar(),),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text14by500(text: 'Ritvik Sarwal',color: AppColors.bluishColor,fontSize: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Text16by400(text: '07 December 2023, 9:40AM',fontSize: 12,color: AppColors.lightGreyTextColor,),
                    ),
                    Table(
                        children: [
                          TableRow(children: [
                            Text16by400(text:'Regarding :'),
                            Text14by500(text: 'Fever',),
                          ]),
                        ]),
                    Table(
                        children: [
                          TableRow(children: [
                            Text16by400(text:'Session :'),
                            Text14by500(text: '1st',),
                          ]),
                        ]),
                    Table(
                        children: [
                          TableRow(children: [
                            Text16by400(text:'Payment Mode :'),
                            Text14by500(text: 'Net Banking',),
                          ]),
                        ]),
                    Table(
                        children: [
                          TableRow(children: [
                            Text16by400(text:'Report :'),
                            Row(
                              children: [
                                Icon(Icons.file_download_outlined,color: AppColors.tealColor,),
                                Text14by500(text: 'Download PDF',color: AppColors.tealColor,),
                              ],
                            ),
                          ]),
                        ]),

                  ],
                ),
                SizedBox(height: 12.0,),
                Text14by500(text: 'Write report'),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 6.0),
                  decoration: BoxDecoration(
                    color: AppColors.containerColor,
                    border: Border.all(width: 1.0,color: AppColors.greyTextColor),
                    borderRadius: BorderRadius.circular(16.0)
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.reportTextEditingController,
                        maxLines: 9,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(16.0)
                          ),
                          filled: true,
                          fillColor: AppColors.containerColor,
                          hintText: 'Type here...'
                        ),
                      ),
                      Obx(() => controller.selectedImagePath.isNotEmpty
                          ?Container(
                        constraints: BoxConstraints(
                          minHeight: 80,
                          maxHeight: 150,
                        ),

                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                                itemCount: controller.selectedImagePath.length,
                                itemBuilder: (context,index){
                              return Container(child: Image.file(File(controller.selectedImagePath[index]),width: Get.width*0.3,fit: BoxFit.contain,),);
                            }),
                          ):const SizedBox.shrink()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Text14by500( text: '20 Jan 2022',),
                          IconButton(color: AppColors.tealColor, onPressed: () {
                            controller.getMediaFromDevice();
                          }, icon: Icon(Icons.image),)
                        ],),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(child: BorderButton(buttonText: 'Clear image', onClick: (){
                  controller.selectedImagePath.clear();
                },fontSize: 12,)),
                SizedBox(width: 10,),
                Expanded(child: CustomSolidButton(buttonText: 'Send',
                  onClick: (){
                  controller.createReport(appointmentId: userAppointmentId, reportText: controller.reportTextEditingController.text, imagePaths: controller.selectedImagePath);
                },fontSize: 12,)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
