import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:max_hr/helper/api.dart';
import 'package:max_hr/helper/app.dart';
import 'package:max_hr/model/requests.dart';

class ApprovalController extends GetxController{

  RxBool loading = false.obs;
  RxInt selectedPage = 0.obs;
  MyRequests? myRequests;
  TextEditingController overTimeNote = TextEditingController();
  TextEditingController vacationNote = TextEditingController();

  initPage()async{
    loading(true);
    await getData();
    loading(false);
  }

  Future<MyRequests?> getData()async{
    myRequests = await Api.getRequests();
    if(myRequests == null){
      return getData();
    }else{
      return myRequests;
    }
  }

  changeOvertimeState(int state , OvertimeRequest overtimeRequest,BuildContext context)async{
    overtimeRequest.loading(true);
    bool succ = await Api.changeOvertimeState(state, overTimeNote.text, overtimeRequest.otId);
    if(succ){
      loading(true);
      await getData();
      loading(false);
    }else{
      App.errMsg(context, "overtime", "please_wait_until_manager_response_before_you");
    }
    overtimeRequest.loading(false);
  }
  changeVacationState(int state , VacationRequest vacationRequest,BuildContext context)async{
    vacationRequest.loading(true);
    bool succ = await Api.changeVacationState(state, vacationNote.text, vacationRequest.vrId);
    if(succ){
      loading(true);
      await getData();
      loading(false);
    }else{
      App.errMsg(context, "overtime", "please_wait_until_manager_response_before_you");
    }
    vacationRequest.loading(false);
  }
  acceptNotPaid(VacationRequest vacationRequest,BuildContext context)async{
    vacationRequest.loading(true);
    bool succ = await Api.acceptVacationAsNotPaid(1, vacationNote.text, vacationRequest.vrId);
    if(succ){
      loading(true);
      await getData();
      loading(false);
    }else{
      App.errMsg(context, "overtime", "please_wait_until_manager_response_before_you");
    }
    vacationRequest.loading(false);
  }
  archiveOverTime(OvertimeRequest overtimeRequest)async{
    overtimeRequest.loading(true);
    await Api.archiveOverTime(overtimeRequest.otId);
    loading(true);
    await getData();
    loading(false);
    overtimeRequest.loading(false);
  }

  archiveVacation(VacationRequest vacationRequest)async{
    vacationRequest.loading(true);
    await Api.archiveOverTime(vacationRequest.vrId);
    loading(true);
    await getData();
    loading(false);
    vacationRequest.loading(false);
  }

}