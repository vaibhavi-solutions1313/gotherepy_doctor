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
    DoctorProfilePageController doctorProfilePageController = Get.put(DoctorProfilePageController());
    return Scaffold(
      appBar: CustomUniversalAppBar(
        title: 'Profile',
        appBar: AppBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(AppImages.marriage),
                  // child: Image.asset(AppImages.marriage)
                ),
                SizedBox(
                  height: 15,
                ),
                ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: doctorProfilePageController.doctorDetail.length,
                  itemBuilder: (context, index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Icon(
                            index==0?Icons.person:index==1?Icons.account_box_outlined:Icons.info_outline,
                            size: 32,
                            color: Colors.black.withOpacity(0.9),
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text16by600(
                                text: doctorProfilePageController.doctorDetail[index]['title'].toString(),
                                color: AppColors.greyColor6A6A6A,
                              ),
                              Obx(() => TextField(
                                maxLines: 3,
                                minLines: 1,
                                readOnly: doctorProfilePageController.enableTexField.value,
                                decoration: InputDecoration(
                                  filled: !doctorProfilePageController.enableTexField.value,
                                    fillColor: Color(0xffFCF5E5),
                                    contentPadding: EdgeInsets.all(3.0),
                                    hintText: doctorProfilePageController.doctorDetail[index]['value'].toString(),
                                    border: InputBorder.none),
                              )),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              doctorProfilePageController.enableTexField.value=!doctorProfilePageController.enableTexField.value;
                            },
                            child: CircleAvatar(
                                radius: 13,
                                backgroundColor: AppColors.tealColor,
                                child: Obx(() => Icon(
                                  doctorProfilePageController.enableTexField.value? Icons.edit:Icons.cancel_outlined,
                                  size: 13,
                                  color: Colors.white,
                                ))),
                          ),
                        )
                      ],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 15,
                    );
                  },
                ),
              ],
            ),
            CustomSolidButton(buttonText: 'Book Now', onClick: () {})
          ],
        ),
      ),
    );
  }
}

