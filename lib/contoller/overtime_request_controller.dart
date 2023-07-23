import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:max_hr/helper/api.dart';
import 'package:max_hr/helper/app.dart';

class OverTimeRequestController extends GetxController{

  RxBool loading = false.obs;
  RxBool successfully = false.obs;
  RxBool fake = false.obs;
  RxBool validation = false.obs;
  DateTime? fromDate,toDate;
  TimeOfDay? fromTime,toTime;
  TextEditingController note = TextEditingController();

  refreshPage(){
    fake(!fake.value);
  }
  save(BuildContext context)async{
    validation(true);
    if(fromTime != null && fromDate != null && toTime != null && toDate != null){
      loading(true);
      await Api.hasInternet();
      bool succ= await Api.addOverTimeRequest(
        getFormatedDate(fromDate!)+" "+getFormatedTime(fromTime!)
      , getFormatedDate(toDate!)+" "+getFormatedTime(toTime!),
          getFormatedDate(fromDate!),
        note.text
      );
      if(succ){
        // App.succMsg(context, "overtime", "overtime_requested_succ");
        successfully(true);
        await Future.delayed(Duration(milliseconds: 1500));
        Get.back();
      }else{
        App.errMsg(context, "overtime", "wrong");
      }
      loading(false);
    }
  }
  getFormatedDate(DateTime dateTime){
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return formattedDate;
  }
  getFormatedTime(TimeOfDay timeOfDay ){
    DateTime now = DateTime.now();
    DateTime dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    String formattedTime = DateFormat('HH:mm:ss').format(dateTime);
    return formattedTime;
  }

}