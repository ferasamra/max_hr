import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:max_hr/helper/api.dart';
import 'package:max_hr/helper/global.dart';
import 'package:max_hr/model/attendance.dart';
import 'package:max_hr/model/ticket_details.dart';

class TicketReplayController extends GetxController{
  ScrollController scrollController = ScrollController();
  RxBool loading = false.obs;
  RxBool typing = false.obs;
  RxBool fake = false.obs;
  TicketsDetailsDecoder? ticketsDetailsDecoder;
  TextEditingController msg = TextEditingController();
  initPage(int ticket_id)async{
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      loading(true);
      await Api.hasInternet();
      await getData(ticket_id);
      loading(false);
    });
  }

  getData(int ticket_id)async{
    ticketsDetailsDecoder = await Api.getTicketDetails(ticket_id);
    if(ticketsDetailsDecoder == null){
      return await getData(ticket_id);
    }else{
      scrollToEnd();
      return true;
    }
  }
  scrollToEnd()async{
    fake(!fake.value);
    await Future.delayed(Duration(milliseconds: 100));
    scrollController.animateTo(scrollController.position.maxScrollExtent,  curve: Curves.easeOut,
      duration: const Duration(milliseconds: 100),);

  }

  sendMsg(TicketReplay ticketReplay)async{
    ticketReplay.isSent(false);
    bool succ = await Api.addTicketReplay(ticketReplay.msg, ticketReplay.toEId, ticketReplay.ticketId);
    if(succ){
      ticketReplay.isSent(true);
    }else{
      sendMsg(ticketReplay);
    }
  }
}