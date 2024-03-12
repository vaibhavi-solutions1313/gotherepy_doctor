import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:gotherepy_doctor/app/appWidgets/appButtons.dart';
import 'package:gotherepy_doctor/app/modules/auth_page/controllers/auth_page_controller.dart';

import '../../../appWidgets/appTextField.dart';
import '../../../appWidgets/universalAppBar.dart';

class SessionPriceView extends GetView{
  @override
  Widget build(BuildContext context) {
    AuthPageController authPageController = Get.find<AuthPageController>();

    return Scaffold(
      appBar: CustomUniversalAppBar(title: 'Session Details',appBar: AppBar()),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Form(
            key: authPageController.sessionPriceKey,
            child: Column(
              children: [
                CustomCircularBorderTextFieldWithHintTextAndTitle(
                    title: 'Add Session Count',
                    hintText: 'Session Count',
                    inputType: TextInputType.number,
                    textEditingController: authPageController.sessionCountController
                ),
                CustomCircularBorderTextFieldWithHintTextAndTitle(
                    title: 'Add Session Price',
                    hintText: 'Session Price (In Rs)',
                    inputType: TextInputType.number,
                    textEditingController: authPageController.sessionPriceController
                ),
                CustomCircularBorderTextFieldWithHintTextAndTitle(
                    title: 'Add Session Discount',
                    hintText: 'Discount (In %)',
                    inputType: TextInputType.number,
                    textEditingController: authPageController.sessionDiscountController
                ),
                CustomCircularBorderTextFieldWithHintTextAndTitle(
                    title: 'Add Session Time',
                    hintText: 'Session Time (In mins)',
                    inputType: TextInputType.number,
                    textEditingController: authPageController.sessionTimeController
                ),
                CustomSolidButton(
                    buttonText: 'Save Session Details',
                    onClick: (){
                      if(authPageController.sessionPriceKey.currentState!.validate()){
                        authPageController.saveSessionPrice(
                            sPrice: authPageController.sessionPriceController.text,
                            sCount: authPageController.sessionCountController.text,
                            sDiscount: authPageController.sessionDiscountController.text,
                            sTime: authPageController.sessionTimeController.text
                        );
                        Fluttertoast.showToast(msg: 'Session Details saved successfully');
                      } else{
                        Fluttertoast.showToast(msg: 'All fields are required');
                      }
                    }
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

}