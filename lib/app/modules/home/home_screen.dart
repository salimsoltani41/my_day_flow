import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:my_day_flow/app/modules/home/home_widgets/drawer.dart';
import 'package:my_day_flow/app/modules/home/home_controller.dart';
import 'package:my_day_flow/app/modules/home/home_widgets/completed_view.dart';
import 'package:my_day_flow/app/modules/home/home_widgets/current_view.dart';
import 'package:my_day_flow/app/modules/home/home_widgets/header_home.dart';
import 'package:my_day_flow/app/routes/route_names.dart';
import 'package:my_day_flow/core/constants/colors.dart';
import 'package:my_day_flow/core/constants/strings.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // Drawer for menu
        drawer: MyDrawer(controller: controller),
        // header as appbar you can customize it here
        appBar: HeaderHome(),
        floatingActionButton: FloatingActionButton(
          tooltip: AppStrings.toolTipHabit,
          backgroundColor: AppColors.turqoise,
          onPressed: () => Get.toNamed(MyAppRouteNames.entry),
          child: Icon(Iconsax.add),
        ),
        // Body section
        body: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(gradient: AppGradient.backgroundGradient),
          child: TabBarView(
            controller: controller.tabController,
            children: [MyCurrentView(), MyCompletedView()],
          ),
        ),
      ),
    );
  }
}
