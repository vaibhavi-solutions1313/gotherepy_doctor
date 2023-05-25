import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'app/app_constants/constants_appColors.dart';
import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
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
          appBarTheme: AppBarTheme(
            color: AppColors.tealColor,
          ),
          iconTheme: IconThemeData(
              color: Colors.white
          ),
        ),
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    ),
  );
}
