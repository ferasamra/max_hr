import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:max_hr/app_localization.dart';
import 'package:max_hr/contoller/attendance_controller.dart';
import 'package:max_hr/contoller/home_controller.dart';
import 'package:max_hr/helper/app.dart';
import 'package:max_hr/view/attendance.dart';
import 'package:max_hr/view/home.dart';
import 'package:max_hr/view/profile.dart';
import 'package:max_hr/view/requests.dart';
import 'package:max_hr/view/services.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Main extends StatelessWidget {

  HomeController homeController = Get.put(HomeController());
  AttendanceController attendanceController = Get.put(AttendanceController());

  List<PersistentBottomNavBarItem> _navBarsItems(BuildContext context) {
    return [
      PersistentBottomNavBarItem(
        icon:
        Obx(() =>
        homeController.selectedPage.value == 0?
          SvgPicture.asset("assets/icons/home_2.svg"):SvgPicture.asset("assets/icons/home_1.svg")),
        title: App_Localization.of(context).translate("home").toUpperCase(),
        textStyle: TextStyle(fontSize: 9),
        activeColorPrimary: App.darkBlue,
        inactiveColorPrimary: App.grey2,

      ),
      PersistentBottomNavBarItem(
        icon:
        Obx(() =>
        homeController.selectedPage.value == 1?
        SvgPicture.asset("assets/icons/service_2.svg"):SvgPicture.asset("assets/icons/service_1.svg")),
        title: App_Localization.of(context).translate("service").toUpperCase(),
        textStyle: TextStyle(fontSize: 9),
        activeColorPrimary: App.darkBlue,
        inactiveColorPrimary: App.grey2,
      ),
      PersistentBottomNavBarItem(
        icon:
        Obx(() =>
        homeController.selectedPage.value == 2?
        SvgPicture.asset("assets/icons/attendance_2.svg"):SvgPicture.asset("assets/icons/attendance_1.svg")),
        title: App_Localization.of(context).translate("attendance").toUpperCase(),
        textStyle: TextStyle(fontSize: 9),
        activeColorPrimary: App.darkBlue,
        inactiveColorPrimary: App.grey2,
      ),
      PersistentBottomNavBarItem(
        icon:
        Obx(() =>
        homeController.selectedPage.value == 3?
        SvgPicture.asset("assets/icons/requests_2.svg"):SvgPicture.asset("assets/icons/requests_1.svg")),
        title: App_Localization.of(context).translate("requests").toUpperCase(),
        textStyle: TextStyle(fontSize: 9),
        activeColorPrimary: App.darkBlue,
        inactiveColorPrimary: App.grey2,
      ),
      PersistentBottomNavBarItem(
        icon:
        Obx(() =>
        homeController.selectedPage.value == 4?
        SvgPicture.asset("assets/icons/setting_2.svg"):SvgPicture.asset("assets/icons/setting_1.svg")),
        title: App_Localization.of(context).translate("profile").toUpperCase(),
        textStyle: TextStyle(fontSize: 9),
        activeColorPrimary: App.darkBlue,
        inactiveColorPrimary: App.grey2,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: homeController.pageController,
      navBarHeight: 65,
      screens: [
        Home(),
        Services(),
        AttendanceView(),
        Requests(),
        Profile(),
      ],
      onItemSelected: (index){
        if(index == 2){
          attendanceController.scrollToSelected();
        }
        homeController.selectedPage.value = index;
      },

      items: _navBarsItems(context),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
          colorBehindNavBar: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.14),
                offset: Offset(0, -2),
                spreadRadius: 2,
                blurRadius: 9
            )
          ]
        // gradient:  LinearGradient(colors: [App.primary_light,App.primary],begin: Alignment.topCenter ,end: Alignment.bottomCenter)
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties:const ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation:const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style14,
      // navBarStyle: NavBarStyle.style6,
    );
  }
}
