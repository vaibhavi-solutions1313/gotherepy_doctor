import 'package:get/get.dart';

import '../modules/auth_page/bindings/auth_page_binding.dart';
import '../modules/auth_page/views/auth_page_view.dart';
import '../modules/chat_page/bindings/chat_page_binding.dart';
import '../modules/chat_page/views/chat_page_view.dart';
import '../modules/doctor_profile_page/bindings/doctor_profile_page_binding.dart';
import '../modules/doctor_profile_page/views/doctor_profile_page_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/intro_screen/bindings/intro_screen_binding.dart';
import '../modules/intro_screen/views/intro_screen_view.dart';
import '../modules/live_video_call_page/bindings/live_video_call_page_binding.dart';
import '../modules/live_video_call_page/views/live_video_call_page_view.dart';
import '../modules/patient_page/bindings/patient_page_binding.dart';
import '../modules/patient_page/views/patient_page_view.dart';
import '../modules/session_page/bindings/session_page_binding.dart';
import '../modules/session_page/views/session_page_view.dart';
import '../modules/setting_page/bindings/setting_page_binding.dart';
import '../modules/setting_page/views/setting_page_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.AUTH_PAGE,
      page: () => const AuthPageView(),
      binding: AuthPageBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.INTRO_SCREEN,
      page: () => const IntroScreenView(),
      binding: IntroScreenBinding(),
    ),
    GetPage(
      name: _Paths.SESSION_PAGE,
      page: () => const SessionPageView(),
      binding: SessionPageBinding(),
    ),
    GetPage(
      name: _Paths.PATIENT_PAGE,
      page: () => const PatientPageView(),
      binding: PatientPageBinding(),
    ),
    GetPage(
      name: _Paths.SETTING_PAGE,
      page: () => const SettingPageView(),
      binding: SettingPageBinding(),
    ),
    GetPage(
      name: _Paths.DOCTOR_PROFILE_PAGE,
      page: () => const DoctorProfilePageView(),
      binding: DoctorProfilePageBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_PAGE,
      page: () => const ChatPageView(),
      binding: ChatPageBinding(),
    ),
    GetPage(
      name: _Paths.LIVE_VIDEO_CALL_PAGE,
      page: () => const LiveVideoCallPageView(),
      binding: LiveVideoCallPageBinding(),
    ),
  ];
}
