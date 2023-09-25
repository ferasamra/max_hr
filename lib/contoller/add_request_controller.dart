import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max_hr/helper/api.dart';
import 'package:max_hr/helper/app.dart';
import 'package:max_hr/model/request_type.dart';

class AddRequestController extends GetxController{
  RxBool loading = false.obs;
  RxBool successfully = false.obs;
  RxBool fake = false.obs;
  RxBool validation = false.obs;
  int? request_type_id;
  TextEditingController note = TextEditingController();
  List<RequestType> types = <RequestType>[];


  @override
  void onInit() {
    super.onInit();
    getData();
  }
  getData()async{
    loading(true);
    types = await Api.getRequestTypes();
    if(types.isNotEmpty){
      request_type_id = types.first.rtId;
    }
    loading(false);
  }
  refreshPage(){
    fake(!fake.value);
  }
  save(BuildContext context)async{
    validation(true);
    if(request_type_id != null && note.text.isNotEmpty){
      loading(true);
      await Api.hasInternet();
      bool succ= await Api.addRequest(
          request_type_id!,
          note.text
      );
      if(succ){
        // App.succMsg(context, "overtime", "overtime_requested_succ");
        successfully(true);
        await Future.delayed(Duration(milliseconds: 1500));
        Get.back();
      }else{
        App.errMsg(context, "requests", "wrong");
      }
      loading(false);
    }
  }

}