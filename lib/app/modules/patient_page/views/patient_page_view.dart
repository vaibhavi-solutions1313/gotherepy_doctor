import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../appWidgets/universalAppBar.dart';
import '../../../app_constants/constants_appColors.dart';
import '../controllers/patient_page_controller.dart';

class PatientPageView extends GetView<PatientPageController> {
  const PatientPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomUniversalAppBar(title: 'Paitent List',appBar: AppBar(),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(

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
      ),
    );
  }
}
