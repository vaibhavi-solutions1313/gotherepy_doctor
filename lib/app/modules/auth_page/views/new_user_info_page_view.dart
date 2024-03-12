import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gotherepy_doctor/app/appWidgets/appButtons.dart';
import 'package:gotherepy_doctor/app/appWidgets/appTextField.dart';
import 'package:gotherepy_doctor/app/modules/auth_page/controllers/auth_page_controller.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../appWidgets/universalAppBar.dart';
import '../../../app_constants/constants_appColors.dart';

class NewUserInfoPageView extends GetView {
  final String newUserToken;
  const NewUserInfoPageView({Key? key,required this.newUserToken,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AuthPageController authPageController=Get.find<AuthPageController>();

    return Scaffold(
      appBar: CustomUniversalAppBar(title: 'Create Your Profile',appBar: AppBar()),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Column(
            children: [
              Stack(
                // clipBehavior:Clip.none ,
                children: [
                  Obx(() => ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      width: Get.width /3,
                      height: Get.width /3,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        shape: BoxShape.circle
                      ),
                      child:  authPageController.selectedUserImage.value.isEmpty?
                      Icon(Icons.person,size: 75,color: AppColors.containerColor,)
                          :Image.file(File(authPageController.selectedUserImage.value.toString(),),fit: BoxFit.cover,
                      ),
                    ),
                  )),
                  Positioned(
                    bottom: 5,
                    right: 2.5,
                    child: InkWell(
                        onTap: ()=>authPageController.selectProfileImage(),
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: AppColors.containerColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.lightGreyTextColor,
                                offset: Offset(0.5,0.5),
                                spreadRadius: 0.5,
                                blurRadius: 1.0
                              )
                            ]
                          ),
                          child: Icon(Icons.edit,size:14,color: AppColors.tealColor,),
                        )),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text16by600(text: 'Basic Details'),
          ),
          Form(
            key: authPageController.newUserRegisterFormKey,
            child: Column(
              children: [
                CustomCircularBorderTextFieldWithHintTextAndTitle(title: 'Title', hintText: 'Enter your title',
                  textEditingController: authPageController.userTitleController, readOnly: false,),
                CustomCircularBorderTextFieldWithHintTextAndTitle(title: 'Name', hintText: 'Full name', textEditingController: authPageController.userFullNameController,),
                CustomCircularBorderTextFieldWithHintTextAndTitle(title: 'Specialization', hintText: 'Type your specialization', textEditingController: authPageController.userSpecializationController,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text14by400(
                        text: 'Gender',
                        color: AppColors.blackish2D2D2D,
                      ),
                      SizedBox(height: 6.0,),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(width: 0.2,color: AppColors.whiteShadow),
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0.5, 1.0),
                                  blurRadius: 1.0,
                                  spreadRadius: 1.0,
                                  color: AppColors.lightGreyTextColor.withOpacity(0.5)
                              )
                            ]
                        ),
                        child: IntrinsicHeight(
                          child: Obx(() =>  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              RadioMenuButton(style: ButtonStyle(),value: 0, groupValue: authPageController.userGenderValue.value, onChanged: (val){authPageController.userGenderValue.value=val!;}, child: Text('male')),
                              VerticalDivider(),
                              RadioMenuButton(value: 1, groupValue: authPageController.userGenderValue.value, onChanged: (val){authPageController.userGenderValue.value=val!;}, child: Text('female')),
                            ],
                          )),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text14by400(
                            text: 'Education Qualification and proof',
                            color: AppColors.blackish2D2D2D,
                          ),
                          Align(
                              alignment: Alignment.topCenter,
                              child: Icon(Icons.star,size: 10,color: Colors.red,))
                        ],
                      ),
                      SizedBox(height: 6.0,),
                      InkWell(
                        onTap: () {
                          authPageController.selectImageFromGallery();
                        },
                        child: Obx(() =>  Material(
                          elevation: 2.0,
                          color: Colors.white,
                          shadowColor: AppColors.whiteShadow,
                          borderRadius: BorderRadius.circular(10.0),
                          child: TextFormField(
                            onTap: ()=>authPageController.selectImageForEducationFromGallery(),
                            readOnly:true,
                            autofocus: false,
                            controller: authPageController.userQualificationDetailsController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'This field is required';
                              }else{
                                return null;
                              }
                            },
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.blackishTextColor,
                            ),
                            cursorColor: AppColors.blackishTextColor,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                              border: InputBorder.none,
                              hintText: authPageController.selectedIdentityProof.value.isEmpty?'Document to be uploaded':authPageController.selectedIdentityProof.value,
                            ),

                          ),
                        )),
                      ),
                    ],
                  ),
                ),

                CustomCircularBorderTextFieldWithHintTextAndTitle(title: 'About yourself', hintText: 'Registration Details', textEditingController: authPageController.aboutTextController),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text14by400(
                            text: 'Identity proof',
                            color: AppColors.blackish2D2D2D,
                          ),
                            Align(
                                alignment: Alignment.topCenter,
                                child: Icon(Icons.star,size: 10,color: Colors.red,))
                        ],
                      ),
                      SizedBox(height: 6.0,),
                      InkWell(
                        onTap: () {
                          authPageController.selectImageFromGallery();
                          },
                        child: Obx(() =>  Material(
                          elevation: 2.0,
                          color: Colors.white,
                          shadowColor: AppColors.whiteShadow,
                          borderRadius: BorderRadius.circular(10.0),
                          child: TextFormField(
                             onTap: ()=>authPageController.selectImageFromGallery(),
                            readOnly:true,
                            autofocus: false,
                            controller: authPageController.idProofImagePathController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'This field is required';
                              }else{
                                return null;
                              }
                            },
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.blackishTextColor,
                            ),
                            cursorColor: AppColors.blackishTextColor,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                              border: InputBorder.none,
                              hintText: authPageController.selectedIdentityProof.value.isEmpty?'document to be uploaded':authPageController.selectedIdentityProof.value,
                            ),

                          ),
                        )),
                      ),
                    ],
                  ),
                ),
                CustomSolidButton(buttonText: 'Update', onClick: (){
                  if(authPageController.selectedUserImage.value.isNotEmpty){

                    if(authPageController.newUserRegisterFormKey.currentState!.validate()){
                      authPageController.saveNewUserInfo(
                          newUserToken: newUserToken,
                          avatar: authPageController.selectedUserImage.value,
                          title: authPageController.userTitleController.text,
                          name: authPageController.userFullNameController.text,
                          specialization: authPageController.userSpecializationController.text,
                          gender: authPageController.userGenderValue.value==0?'m':'f',
                          education_proof: authPageController.userQualificationDetailsController.text,
                          about: authPageController.aboutTextController.text,
                          id_proof: authPageController.idProofImagePathController.text,
                          counselling: [authPageController.doctorTypeId.value]
                      );
                    }
                  }else{
                    Fluttertoast.showToast(msg: 'Add your profile image');
                  }

                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
