import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:max_hr/app_localization.dart';
import 'package:max_hr/helper/api.dart';
import 'package:max_hr/helper/app.dart';
import 'package:max_hr/model/employee.dart';
import 'package:max_hr/view/main.dart';

class LoginController extends GetxController{
  RxBool validation = false.obs;
  RxBool loading = false.obs;
  RxBool hidePassword = true.obs;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  submit(BuildContext context)async{
    validation(true);
    if(username.text.isNotEmpty && password.text.length >= 5){
      loading(true);
      await Api.hasInternet();
      Employee? employee = await Api.login(username.text, password.text);
      if(employee != null){
        App.succMsg(context,
            "login",
            "login_successfully");
        Get.offAll(()=>Main());
      }else{
        App.errMsg(context,
            "login",
            "login_error");
      }
      loading(false);
    }
  }

}