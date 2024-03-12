import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gotherepy_doctor/app/modules/doctor_profile_page/controllers/set_availability_controller.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'app/app_constants/constants_appColors.dart';
import 'app/data/doctor_user_info.dart';
import 'app/routes/app_pages.dart';

final localStorage = GetStorage();
DoctorProfileInfo doctorInfo= DoctorProfileInfo();
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // NotificationServices notificationServices = NotificationServices();
  await GetStorage.init();

  runApp(
    GlobalLoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: const Center(
        child: SpinKitChasingDots(
          //SpinKitChasingDots
          color: Colors.teal,
          size: 50.0,
        ),
      ),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Application",
        theme: ThemeData(
          useMaterial3: true,
          primaryColor:  AppColors.blackishTextColor,
          fontFamily: GoogleFonts.roboto(color: Colors.red).fontFamily,
          primaryTextTheme: GoogleFonts.robotoTextTheme(),
          appBarTheme: const AppBarTheme(
            color: AppColors.tealColor,
          ),
          iconTheme: const IconThemeData(
              color: Colors.white
          ),
        ),
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    ),
  );
}



