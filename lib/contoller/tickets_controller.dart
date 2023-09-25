import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:max_hr/helper/api.dart';
import 'package:max_hr/helper/global.dart';
import 'package:max_hr/model/discount_rewards.dart';
import 'package:max_hr/model/lateness.dart';
import 'package:max_hr/model/requests.dart';
import 'package:max_hr/model/tickets.dart';

class TicketsController extends GetxController{

  RxBool loading = false.obs;
  List<Ticket> tickets = <Ticket>[];

  initPage()async{
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      loading(true);
      await Api.hasInternet();
      tickets = await Api.getTickets();
      loading(false);
    });
  }

}