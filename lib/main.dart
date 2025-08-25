import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_day_flow/app/routes/route_names.dart';
import 'package:my_day_flow/app/utils/helpers/check_connectivity.dart';
import 'package:my_day_flow/core/service/hive_service.dart';
import 'package:my_day_flow/core/service/local_notification_service.dart';
import 'package:my_day_flow/core/service/local_storage_service.dart';
import 'package:my_day_flow/app/routes/route_pages.dart';
import 'package:my_day_flow/core/constants/strings.dart';
import 'package:my_day_flow/core/themes/my_theme.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  // Ensure binding is initialized before doing anything else
  WidgetsFlutterBinding.ensureInitialized();

  // Now it's safe to use SharedPreferences
  await LocalStorageService.init();

  // INITALIZE THE HIVE DB
  await HiveInitializer.init();

  tz.initializeTimeZones();
  await NotificationService.initialize();

  // RUN THE APP
  runApp(const MyDayFlow());
}

class MyDayFlow extends StatelessWidget {
  const MyDayFlow({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // ALWAYS START FROM SPLASH
      initialRoute: MyAppRouteNames.splash,
      initialBinding: BindingsBuilder(() {
        Get.put(ConnectivityHelper());
      }),
      title: AppStrings.appName,
      theme: myTheme,
      // WE HANDLE PAGES ON HERE
      getPages: MyAppRoutes.pages,
    );
  }
}
