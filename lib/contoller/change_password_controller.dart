import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:max_hr/helper/api.dart';
import 'package:max_hr/helper/app.dart';

class ChangePasswordController extends GetxController {

  RxBool loading = false.obs;
  RxBool validation = false.obs;
  RxBool successfully = false.obs;
  RxBool hidOld = true.obs;
  RxBool hideNew = true.obs;
  RxBool hideConfirm = true.obs;
  TextEditingController old = TextEditingController();
  TextEditingController newPass = TextEditingController();
  TextEditingController confirm = TextEditingController();

  submit(BuildContext context)async{
    validation(true);
    if(confirm.text.length >= 6 &&
        newPass.text.length >= 6 &&
        old.text.length >= 6){
      await Api.hasInternet();
      loading(true);
      String msg = await Api.changePassword(old.text, newPass.text, confirm.text);
      if(msg == "password_change_successfully"){
        successfully(true);
        await Future.delayed(Duration(milliseconds: 1500));
        Get.back();
      }else{
        App.errMsg(context, "change_password", msg.replaceAll(" ", "_"));
      }
      loading(false);
    }else{
      App.errMsg(context, "change_password", "password_must_be_at_least_6_chars");
    }
  }

}