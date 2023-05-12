import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../appWidgets/appButtons.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../appWidgets/universalAppBar.dart';
import '../../../app_constants/app_images.dart';
import '../../../app_constants/constants_appColors.dart';
import '../controllers/doctor_profile_page_controller.dart';

class DoctorProfilePageView extends GetView<DoctorProfilePageController> {
  const DoctorProfilePageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DoctorProfilePageController doctorProfilePageController=Get.put(DoctorProfilePageController());
    return Scaffold(
      appBar:CustomUniversalAppBar(title: 'Profile',appBar: AppBar(),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Image.asset(AppImages.marriage,height: 80,),
                SizedBox(height: 15,),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: doctorProfilePageController.doctorDetail.length,
                    itemBuilder: (context,index){
                      return  ListTile(
                        horizontalTitleGap: 0.0,
                        contentPadding: EdgeInsets.zero,
                        isThreeLine: false,
                        leading: Icon(Icons.add),
                        title: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text16by600(text: doctorProfilePageController.doctorDetail[index]['title'].toString(),color: AppColors.greyColor6A6A6A,),
                                InkWell(
                                  onTap: (){},
                                  child: CircleAvatar(
                                    radius: 13,
                                      backgroundColor: AppColors.tealColor,
                                      child: Icon(Icons.edit,size: 13,color: Colors.white,)),
                                ),
                              ],
                            ),
                            TextField(
                              maxLines: 3,
                              minLines: 1,
                              readOnly: true,
                              decoration: InputDecoration(
                                hintText: doctorProfilePageController.doctorDetail[index]['value'].toString(),
                                border: InputBorder.none
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ],
            ),

            CustomSolidButton(buttonText: 'Book Now', onClick: (){})
          ],
        ),
      ),
    );
  }
}
