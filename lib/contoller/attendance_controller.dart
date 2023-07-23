import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:max_hr/helper/api.dart';
import 'package:max_hr/helper/global.dart';
import 'package:max_hr/model/attendance.dart';

class AttendanceController extends GetxController{

  RxBool loading = false.obs;
  List<Attendance> attendanceList = <Attendance>[];
  List<MyMonth> months = <MyMonth>[];
  ScrollController scrollController = ScrollController();
  initPage()async{
    loading(true);
    months.clear();
    months.addAll(Global.months);
    await Api.hasInternet();
    attendanceList = await Api.getAttendance(Global.currentMonth.year, Global.currentMonth.number);
    loading(false);
  }
  scrollToSelected()async{
    int posistion = 0;
    for(int i=0;i <months.length ; i++){
      if(months[i].selected.value){
        posistion = (i+1)*110;
        break;
      }
    }
    await Future.delayed(Duration(milliseconds: 100));
    scrollController.animateTo(posistion.toDouble(),  curve: Curves.easeOut,
      duration: const Duration(milliseconds: 800),);
  }

  refreshData(int month, int year)async{
    loading(true);
    await Api.hasInternet();
    for(int i=0 ; i<months.length ; i++){
      if(months[i].number == month &&
          months[i].year == year){
        months[i].selected(true);
      }else{
        months[i].selected(false);
      }
    }
    attendanceList = await Api.getAttendance(year, month);
    loading(false);
  }
}