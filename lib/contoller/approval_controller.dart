import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:max_hr/helper/api.dart';
import 'package:max_hr/helper/app.dart';
import 'package:max_hr/model/requests.dart';
import 'package:max_hr/model/tickets.dart';

class ApprovalController extends GetxController{

  RxBool loading = true.obs;
  RxInt selectedPage = 0.obs;
  MyRequests? myRequests;
  TextEditingController overTimeNote = TextEditingController();
  TextEditingController vacationNote = TextEditingController();
  TextEditingController requestNote = TextEditingController();
  int? selected_notification;
  int ot_id_notification = -1;
  int vr_id_notification = -1;
  int r_id_notification = -1;
  int ticket_id_notification = -1;
  initPage(int? selected,int? id)async{
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      if(selected!=null&&id!=null&&selected == 0){
        ot_id_notification = id;
      }else if(selected!=null&&id!=null&&selected == 1){
        vr_id_notification = id;
      }else if(selected!=null&&id!=null&&selected == 2){
        r_id_notification = id;
      }else if(selected!=null&&id!=null&&selected == 3){
        ticket_id_notification = id;
      }
      loading(true);
      await getData();
      await Future.delayed(Duration(milliseconds: 300));
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
  closeTicket(Ticket ticket,BuildContext context)async{
    ticket.loading(true);
    await Api.hasInternet();
    bool succ = await Api.closeTicket(ticket.ticketId);
    if(succ){
      loading(true);
      await getData();
      loading(false);
    }else{
      App.errMsg(context, "tickets", "wrong");
    }
    ticket.loading(false);
  }
  changeRequestsState(int state , EmployeeRequest employeeRequest,BuildContext context)async{
    employeeRequest.loading(true);
    await Api.hasInternet();
    bool succ = await Api.changeRequestState(state, requestNote.text, employeeRequest.requests_id);
    if(succ){
      loading(true);
      await getData();
      loading(false);
    }else{
      App.errMsg(context, "requests", "please_wait_until_manager_response_before_you");
    }
    employeeRequest.loading(false);
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

  archiveRequests(EmployeeRequest employeeRequest)async{
    employeeRequest.loading(true);
    await Api.hasInternet();
    await Api.archiveRequest(employeeRequest.requests_id);
    loading(true);
    await getData();
    loading(false);
    employeeRequest.loading(false);
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