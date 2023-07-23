import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:max_hr/helper/api.dart';
import 'package:max_hr/helper/global.dart';
import 'package:max_hr/model/lateness.dart';

class LatenessController extends GetxController{

  RxBool loading = false.obs;
  List<Lateness> latenessList = <Lateness>[];
  List<MyMonth> months = <MyMonth>[];
  ScrollController scrollController = ScrollController();
  initPage()async{
    loading(true);
    months.clear();
    months.addAll(Global.months);
    await Api.hasInternet();
    latenessList = await Api.getLateness(Global.currentMonth.year, Global.currentMonth.number);
    loading(false);
    await Future.delayed(Duration(milliseconds: 100));
    scrollController.animateTo(scrollController.position.maxScrollExtent,  curve: Curves.easeOut,
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
    latenessList = await Api.getLateness(year, month);
    loading(false);
  }

}