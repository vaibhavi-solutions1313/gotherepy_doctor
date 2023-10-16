import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../providers/sessions_provider.dart';

class SessionPageController extends GetxController with GetSingleTickerProviderStateMixin {
  //TODO: Implement SessionPageController
  SessionsProvider sessionsProvider = SessionsProvider();
  final ImagePicker picker = ImagePicker();
  late TabController tabController;

  TextEditingController reportTextEditingController = TextEditingController();
  RxList<String> selectedImagePath = <String>[].obs;

  final count = 0.obs;
  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
 approveAppointment({required String appointmentId,})async{
    sessionsProvider.acceptAppointment(appointmentId: appointmentId).then((value)async {
      Fluttertoast.showToast(msg: jsonDecode(await value.stream.bytesToString())['msg']);
    });
 }
  getMediaFromDevice() async {
    List<XFile> imageFile = await picker.pickMultiImage();
    if (imageFile.isNotEmpty) {
      for (var x in imageFile) {
        selectedImagePath.add(x.path);
        selectedImagePath.refresh();
      }
      return selectedImagePath;
    }
  }

  createReport({required String appointmentId, required String reportText, required List<String> imagePaths}) {
    sessionsProvider.submitReport(appointmentId: appointmentId, reportText: reportText, imagePaths: imagePaths).then((value) async{
      var messageDecodedData=jsonDecode(await value.stream.bytesToString());
      selectedImagePath.clear();
      Fluttertoast.showToast(msg: messageDecodedData['message']);
    });
  }
}
