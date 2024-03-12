import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:gotherepy_doctor/app/appWidgets/appButtons.dart';
import 'package:gotherepy_doctor/app/modules/auth_page/controllers/auth_page_controller.dart';

import '../../../appWidgets/appTextField.dart';
import '../../../appWidgets/universalAppBar.dart';

class ChatPriceView extends GetView {
  @override
  Widget build(BuildContext context) {
    AuthPageController authPageController = Get.find<AuthPageController>();

    return Scaffold(
      appBar: CustomUniversalAppBar(title: 'Chat Details', appBar: AppBar()),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Form(
            key: authPageController.chatPriceKey,
            child: Column(
              children: [
                CustomCircularBorderTextFieldWithHintTextAndTitle(
                    title: 'Add Chat Price',
                    hintText: 'Chat Price (In Rs)',
                    inputType: TextInputType.number,
                    textEditingController:
                        authPageController.chatPriceController),
                CustomCircularBorderTextFieldWithHintTextAndTitle(
                    title: 'Add Chat Count',
                    hintText: 'Chat Count',
                    inputType: TextInputType.number,
                    textEditingController:
                        authPageController.chatCountController),
                CustomCircularBorderTextFieldWithHintTextAndTitle(
                    title: 'Add Chat Discount',
                    hintText: 'Chat (In %)',
                    inputType: TextInputType.number,
                    textEditingController:
                        authPageController.chatDiscountController),
                CustomCircularBorderTextFieldWithHintTextAndTitle(
                    title: 'Add Chat Time',
                    hintText: 'Chat Time (In mins)',
                    inputType: TextInputType.number,
                    textEditingController:
                        authPageController.chatTimeController),
                CustomSolidButton(
                    buttonText: 'Save Chat Details',
                    onClick: () {
                      if (authPageController.sessionPriceKey.currentState!.validate()) {
                        authPageController.saveChatPrice(
                            cPrice: authPageController.chatPriceController.text,
                            cCount: authPageController.chatCountController.text,
                            cDiscount: authPageController.chatDiscountController.text,
                            cTime: authPageController.chatTimeController.text);
                        Fluttertoast.showToast(msg: 'Chat Details saved successfully');
                        Fluttertoast.showToast(msg: 'Registered successfully!');
                      } else {
                        Fluttertoast.showToast(msg: 'All fields are required');
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
