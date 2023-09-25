import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:max_hr/app_localization.dart';
import 'package:url_launcher/url_launcher.dart';

class App{
  // static Color primary = Color(0xfff37335);
  // static Color primary = Colors.orange;
  static const Color primary = Color(0xff6EDB42);
  static const Color darkPrimary = Color(0xff51c923);
  static const Color red = Color(0xffdb4242);
  static const Color lightBlue = Color(0xff5A7A92);
  static const Color darkBlue = Color(0xff13293d);
  static const Color grey1 = Color(0xffDBDBDB);
  static const Color grey2 = Color(0xffB7B7B7);
  static const Color grey3 = Color(0xffCBCBCB);
  static const Color grey4 = Color(0xffECECEC);
  static const Color bgGrey = Color(0xffF9F9F9);

  static succMsg(BuildContext context , String title , String msg){
    return Get.snackbar(App_Localization.of(context).translate(title)
    , App_Localization.of(context).translate(msg),colorText: Colors.white,backgroundColor: primary);
  }
  static Future<void> myLaunchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication,)) {
      throw Exception('Could not launch $url');
    }
  }
  static errMsg(BuildContext context , String title , String msg){
    return Get.snackbar(App_Localization.of(context).translate(title)
        , App_Localization.of(context).translate(msg),colorText: Colors.white,backgroundColor: red);
  }
  static succMsgWithoutTranslate(BuildContext context , String title , String msg){
    return Get.snackbar(title
        , msg,colorText: Colors.white,backgroundColor: primary);
  }
  static List<String> days = [
    "Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"
  ];
  static List<String> daysShort = [
    "Mon","Tue","Wed","Thur","Fri","Sat","Sun"
  ];
  static getDayFromDate(String date){
    var formated = DateTime.parse(date);
    return days[formated.weekday];
  }
  static getShortDayFromDate(String date){
    var formated = DateTime.parse(date);
    return daysShort[formated.weekday];
  }
  static getFormatedDate(String date){
    var inputFormat = DateFormat('dd/MM/yyyy');
    var inputDate = inputFormat.parse(date);
    return inputDate;
  }
  static String formatDateFromTZ(String dateString) {
    final inputFormat = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ");
    final outputFormat = DateFormat("dd/MM/yyyy");
    final parsedDate = inputFormat.parseUtc(dateString);
    final formattedDate = outputFormat.format(parsedDate.toLocal());
    return formattedDate;
  }
  static String getDayFromDateTZ(String dateString) {
    final inputFormat = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ");
    final parsedDate = inputFormat.parseUtc(dateString);
    return days[parsedDate.weekday-1];
  }
  static String getShortDayFromDateTZ(String dateString) {
    final inputFormat = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ");
    final parsedDate = inputFormat.parseUtc(dateString);
    return daysShort[parsedDate.weekday-1];
  }
  static BoxShadow darkBottomShadow = const BoxShadow(
    color: Color(0x33000000),
    offset: Offset(0, 2),
    blurRadius: 8,
    spreadRadius: 5,
  );

  static getTextFromMinutes(int minutes){
    int hr = (minutes / 60).toInt();
    int d = 0;
    if(hr >= 24){
      d = (hr / 24).toInt();
      hr = hr % 24;
    }
    int mins = minutes % 60;
    String text = "";
    if(d > 0){
      text+= d.toString()+"D ";
    }
    if(hr > 0){
      text+= hr.toString()+"Hr ";
    }
    text+= mins.toString()+"Mins";
    return text;
  }

  static noResult(BuildContext context){
    return Center(
      child: Text(App_Localization.of(context).translate("no_results_found"),textAlign: TextAlign.center),
    );
  }


  static loading(BuildContext context){
    return Center(
      child: Container(
        width: 150,
        child: Center(
          child:
          Platform.isAndroid
          ?CircularProgressIndicator(color: App.primary)
          :CupertinoActivityIndicator(color: App.primary,radius: 15,),
        ),
      ),
    );
  }

}