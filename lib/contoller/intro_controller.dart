import 'package:get/get.dart';
import 'package:max_hr/contoller/login_contoller.dart';
import 'package:max_hr/helper/api.dart';
import 'package:max_hr/helper/global.dart';
import 'package:max_hr/helper/store.dart';
import 'package:max_hr/model/login_info.dart';
import 'package:max_hr/view/login.dart';
import 'package:max_hr/view/main.dart';

class IntroController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initApp();
  }

  initApp() async{
    await Future.delayed(Duration(milliseconds: 2000));
    await Api.hasInternet();
    LoginInfo? loginInfo = await Store.loadLoginInfo();
    if(loginInfo == null){
      Get.off(()=>Login());
    }else{
      Global.employee = await Api.login(loginInfo.email, loginInfo.password);
      if(Global.employee != null){
        Get.to(()=>Main());
      }else{
        Get.off(()=>Login());
      }
    }
  }

}