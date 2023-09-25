import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:max_hr/helper/api.dart';
import 'package:max_hr/helper/global.dart';
import 'package:max_hr/model/discount_rewards.dart';
import 'package:max_hr/model/lateness.dart';
import 'package:max_hr/model/requests.dart';

class EmployeeRequestsController extends GetxController{

  RxBool loading = false.obs;
  List<EmployeeRequest> employeeRequests = <EmployeeRequest>[];
  ScrollController scrollController = ScrollController();
  initPage()async{
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      loading(true);
      await Api.hasInternet();
      employeeRequests = await Api.getEmployeeRequests();
      loading(false);
      await Future.delayed(Duration(milliseconds: 100));
      scrollController.animateTo(scrollController.position.maxScrollExtent,  curve: Curves.easeOut,
        duration: const Duration(milliseconds: 800),);
    });

  }

}