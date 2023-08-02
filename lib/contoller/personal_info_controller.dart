import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:max_hr/helper/api.dart';
import 'package:max_hr/helper/app.dart';
import 'package:max_hr/model/employee_document.dart';

class PersonalInfoController extends GetxController{

  RxBool loading = false.obs;
  List<EmployeeDocument> docs = <EmployeeDocument>[];
  initPage()async{
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      loading(true);
      await Api.hasInternet();
      docs = await Api.getEmployeeDocument();
      loading(false);
    });

  }

  deleteDocument(BuildContext context,int? de_id)async{
   if(de_id != null){
     loading(true);
     await Api.hasInternet();
     bool succ = await Api.deleteDocument(de_id);
     if(!succ){
       loading(false);
       App.errMsg(context, "documents", "wrong");
     }else{
       initPage();
     }
   }
  }


}