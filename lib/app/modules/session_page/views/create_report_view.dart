import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gotherepy_doctor/app/appWidgets/text_styles.dart';

import '../../../appWidgets/appButtons.dart';
import '../../../appWidgets/universalAppBar.dart';
import '../../../app_constants/constants_appColors.dart';

class CreateReportView extends GetView {
  const CreateReportView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomUniversalAppBar(title: 'Make Report',appBar: AppBar(),),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Text14by500( text: '20 Jan 2022',),
                          Icon(Icons.delete_outline,color: AppColors.tealColor,)
                        ],),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(child: BorderButton(buttonText: 'Edit', onClick: (){},fontSize: 12,)),
                SizedBox(width: 10,),
                Expanded(child: CustomSolidButton(buttonText: 'Send', onClick: (){},fontSize: 12,)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
