import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gotherepy_doctor/app/modules/home/model/session_appointment_model.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../main.dart';
import '../../../app_constants/constants_appColors.dart';
import '../providers/sessions_provider.dart';

class SessionPageController extends GetxController with GetSingleTickerProviderStateMixin {
  //TODO: Implement SessionPageController
  SessionsProvider sessionsProvider = SessionsProvider();
  PageController pageController = PageController();
  Rx<SessionPendingAppointmentModel> sessionPendingAppointment = SessionPendingAppointmentModel().obs;
  TextEditingController reasonController = TextEditingController();

  final ImagePicker picker = ImagePicker();
  late TabController tabController;

  final pendingSessions = <Results>[].obs;
  final acceptedSessions = <Results>[].obs;

  TextEditingController reportTextEditingController = TextEditingController();
  RxList<String> selectedImagePath = <String>[].obs;

  final count = 0.obs;
  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    getPendingAppointmentById();
    getBookedAppointmentById();
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

 Future<void> approveAppointment({required String appointmentId})async{
    //  sessionsProvider.acceptAppointment(appointmentId: appointmentId, type: 'session').then((value)async {
    //   Fluttertoast.showToast(msg: jsonDecode(await value.stream.bytesToString())['msg']);
    // });
   await sessionsProvider.acceptAppointment(appointmentId: appointmentId, type: 'session');
   await getPendingAppointmentById();
   print('Session added to upcoming sessions');
   Get.snackbar("Success", "Session accepted successfully", backgroundColor: AppColors.greenColor);

   // final acceptedSession = pendingSessions.firstWhere((session) => session.id == int.parse(appointmentId));
    // pendingSessions.remove(acceptedSession);
    // acceptedSessions.add(acceptedSession);
 }

  Future<void> rejectAppointment({required String appointmentId, required String cancelledBy, required String reason})async{
    // sessionsProvider.cancelAppointment(appointmentId: appointmentId, cancelBy: cancelledBy, reason: reason).then((value)async {
    //   Fluttertoast.showToast(msg: jsonDecode(await value.stream.bytesToString())['msg']);
    // });

    await sessionsProvider.cancelAppointment(appointmentId: appointmentId, cancelBy: cancelledBy, reason: reason);
    await getPendingAppointmentById();
    print('Session removed successfully');
    Get.snackbar("Reject", "Session removed successfully", backgroundColor: AppColors.redishD44041);

    // final rejectedSession = pendingSessions.firstWhere((session) =>
    // session.id == int.parse(appointmentId));
    // pendingSessions.remove(rejectedSession);
  }

 Future<void> getPendingAppointmentById() async{
    print('-------------doctorId------------------------');
    print(doctorInfo.records!.doctorId.toString());
    /*sessionsProvider.fetchSessionAppointmentList(
        doctorId: doctorInfo.records!.doctorId.toString(),
        bookingType: 'session',
        status: 'pending').then((pendingAppointmentsResponseValue) {
          sessionAppointmentRequests.value = pendingAppointmentsResponseValue;
          print('Fetched pending appointment list...');
    });*/
   SessionPendingAppointmentModel? sessionData = await sessionsProvider.fetchPendingSessionAppointment(doctorId: doctorInfo.records!.doctorId.toString());
   if(sessionData!=null){
     pendingSessions.removeWhere((session) =>
         sessionData.results!.any((accepted) => accepted.id == session.id));

     sessionPendingAppointment.value = sessionData;
   }

    /*final pendingAppointments = await sessionsProvider.fetchPendingSessionAppointment(
        doctorId: doctorInfo.records!.doctorId.toString());
    print('Fetched pending appointment list...');
    pendingSessions.assignAll(pendingAppointments.results!);*/
 }

  Future<void> getBookedAppointmentById() async{
    /*sessionsProvider.fetchSessionAppointmentList(
        doctorId: doctorInfo.records!.doctorId.toString(),
        bookingType: 'session',
        status: 'booked').
    then((bookedAppointmentsResponseValue) {
      sessionAppointmentRequests.value=bookedAppointmentsResponseValue;
      print('Fetched booked appointment list...');
    });*/
    final bookedAppointments = await sessionsProvider.fetchPendingSessionAppointment(
        doctorId: doctorInfo.records!.doctorId.toString());
    print('Fetched booked appointment list');
    acceptedSessions.assignAll(bookedAppointments?.results! as Iterable<Results>);
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
