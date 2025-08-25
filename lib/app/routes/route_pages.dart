import 'package:get/get.dart';
import 'package:my_day_flow/app/modules/about_us/about_us_binding.dart';
import 'package:my_day_flow/app/modules/about_us/about_us_screen.dart';
import 'package:my_day_flow/app/modules/analytics/analytics_binding.dart';
import 'package:my_day_flow/app/modules/analytics/analytics_screen.dart';
import 'package:my_day_flow/app/modules/auth/forget_password/forget_password_binding.dart';
import 'package:my_day_flow/app/modules/auth/forget_password/forget_password_screen.dart';
import 'package:my_day_flow/app/modules/auth/login/login_binding.dart';
import 'package:my_day_flow/app/modules/auth/login/login_screen.dart';
import 'package:my_day_flow/app/modules/auth/reset_password/reset_password_binding.dart';
import 'package:my_day_flow/app/modules/auth/reset_password/reset_password_screen.dart';
import 'package:my_day_flow/app/modules/auth/signup/signup_binding.dart';
import 'package:my_day_flow/app/modules/auth/signup/signup_screen.dart';
import 'package:my_day_flow/app/modules/entry/entry_view/entry_screen.dart';
import 'package:my_day_flow/app/modules/entry/entry_binding.dart';
import 'package:my_day_flow/app/modules/home/home_binding.dart';
import 'package:my_day_flow/app/modules/home/home_screen.dart';
import 'package:my_day_flow/app/modules/notifications/notification_binding.dart';
import 'package:my_day_flow/app/modules/notifications/notification_screen.dart';
import 'package:my_day_flow/app/modules/profile/profile_binding.dart';
import 'package:my_day_flow/app/modules/profile/profile_screen.dart';
import 'package:my_day_flow/app/modules/quotes/quote_binding.dart';
import 'package:my_day_flow/app/modules/quotes/quote_screen.dart';
import 'package:my_day_flow/app/modules/splash/splash_bindings.dart';
import 'package:my_day_flow/app/modules/splash/splash_view.dart';
import 'package:my_day_flow/app/routes/route_names.dart';

class MyAppRoutes {
  static List<GetPage<dynamic>>? pages = [
    // SPLASH PAGE =========================================================
    GetPage(
      name: MyAppRouteNames.splash,
      page: () => SplashScreen(),
      binding: SplashBindings(),
    ),
    // LOGIN PAGE =========================================================
    GetPage(
      name: MyAppRouteNames.login,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    // SIGNUP PAGE =========================================================
    GetPage(
      name: MyAppRouteNames.signup,
      page: () => SignupScreen(),
      binding: SignupBinding(),
    ),
    // FORGETPASSSWORD PAGE =========================================================
    GetPage(
      name: MyAppRouteNames.forgetPassword,
      page: () => ForgetPasswordScreen(),
      binding: ForgetPasswordBinding(),
    ),
    // RESETPASSWORD PAGE =========================================================
    GetPage(
      name: MyAppRouteNames.resetPassword,
      page: () => ResetPasswordScreen(),
      binding: ResetPasswordBinding(),
    ),
    // HOME PAGE =========================================================
    GetPage(
      name: MyAppRouteNames.home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    // ENTRY PAGE =========================================================
    GetPage(
      name: MyAppRouteNames.entry,
      page: () => AddEntryScreen(),
      binding: EntryBindings(),
    ),
    // PROFILE PAGE =========================================================
    GetPage(
      name: MyAppRouteNames.profile,
      page: () => ProfileScreen(),
      binding: ProfileBinding(),
    ),
    // QUOTE PAGE =========================================================
    GetPage(
      name: MyAppRouteNames.quotes,
      page: () => QuoteScreen(),
      binding: QuoteBinding(),
    ),
    // ANALYICS PAGE =========================================================
    GetPage(
      name: MyAppRouteNames.analytics,
      page: () => AnalyticsView(),
      binding: AnalyticsBinding(),
    ),

    // ABOUT US PAGE =========================================================
    GetPage(
      name: MyAppRouteNames.aboutUs,
      page: () => AboutUsView(),
      binding: AboutUsBinding(),
    ),
    // Notifications PAGE =========================================================
    GetPage(
      name: MyAppRouteNames.notification,
      page: () => NotificationView(),
      binding: NotificationBinding(),
    ),
  ];
}
