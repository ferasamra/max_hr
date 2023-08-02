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
  int? selected_notification;
  int ot_id_notification = -1;
  int vr_id_notification = -1;
  initPage(int? selected,int? id)async{
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      if(selected!=null&&id!=null&&selected == 0){
        ot_id_notification = id;
      }else if(id!=null){
        vr_id_notification = id;
      }
      loading(true);
      await getData();
      loading(false);
    });

  }

  Future<MyRequests?> getData()async{
    await Api.hasInternet();
    myRequests = await Api.getRequests();
    if(myRequests == null){
      return getData();
    }else{
      return myRequests;
    }
  }

  changeOvertimeState(int state , OvertimeRequest overtimeRequest,BuildContext context)async{
    overtimeRequest.loading(true);
    await Api.hasInternet();
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
    await Api.hasInternet();
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
    await Api.hasInternet();
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
    await Api.hasInternet();
    await Api.archiveOverTime(overtimeRequest.otId);
    loading(true);
    await getData();
    loading(false);
    overtimeRequest.loading(false);
  }

  archiveVacation(VacationRequest vacationRequest)async{
    vacationRequest.loading(true);
    await Api.hasInternet();
    await Api.archiveOverTime(vacationRequest.vrId);
    loading(true);
    await getData();
    loading(false);
    vacationRequest.loading(false);
  }

}