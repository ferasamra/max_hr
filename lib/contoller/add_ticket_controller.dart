import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max_hr/helper/api.dart';
import 'package:max_hr/helper/app.dart';
import 'package:max_hr/model/employee.dart';
import 'package:max_hr/model/request_type.dart';
import 'package:max_hr/model/ticket_types.dart';

class AddTicketController extends GetxController{
  RxBool loading = false.obs;
  RxBool successfully = false.obs;
  RxBool fake = false.obs;
  RxBool validation = false.obs;
  TextEditingController note = TextEditingController();
  List<TicketType> types = <TicketType>[];
  List<Employee> employees = <Employee>[];
  int ticket_type = -1;
  int mention_id = -1;

  @override
  void onInit() {
    super.onInit();
    getData();
  }
  getData()async{
    loading(true);
    types = await Api.getTicketTypes();
    employees = await Api.getEmployeeToMentionTo();
    if(types.isNotEmpty){
      ticket_type = types.first.ttId;
    }
    if(types.isNotEmpty){
      mention_id = employees.first.eId;
    }
    loading(false);
  }
  refreshPage(){
    fake(!fake.value);
  }
  save(BuildContext context)async{
    validation(true);
    if(ticket_type != -1 && mention_id != -1 && note.text.isNotEmpty){
      loading(true);
      await Api.hasInternet();
      bool succ= await Api.addTicket(
          ticket_type,
          mention_id,
          note.text
      );
      if(succ){
        // App.succMsg(context, "overtime", "overtime_requested_succ");
        successfully(true);
        await Future.delayed(Duration(milliseconds: 1500));
        Get.back();
      }else{
        App.errMsg(context, "tickets", "wrong");
      }
      loading(false);
    }
  }

}