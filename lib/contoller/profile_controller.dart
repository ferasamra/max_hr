import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:max_hr/helper/api.dart';
import 'package:max_hr/helper/app.dart';
import 'package:max_hr/helper/global.dart';
import 'package:max_hr/helper/store.dart';
import 'package:max_hr/main.dart';
import 'package:max_hr/model/login_info.dart';

class ProfileController extends GetxController{

  RxBool loading = false.obs;
  RxBool showImagePicker = false.obs;
  final ImagePicker picker = ImagePicker();

  pickGallery(BuildContext context)async{
    final XFile? image = await picker.pickImage(source: ImageSource.gallery,imageQuality: 15);
    if(image != null){
      showImagePicker(false);
      loading(true);
      await Api.hasInternet();
      var succ = await Api.uploadAvatar(image);
      if(succ){
        await updateEmployeeData();
      }else{
        App.errMsg(context, "profile", "wrong");
      }
      loading(false);
    }
  }
  pickCamera(BuildContext context)async{
    final XFile? image = await picker.pickImage(source: ImageSource.camera,imageQuality: 15);
    if(image != null){
      showImagePicker(false);
      loading(true);
      await Api.hasInternet();
      var succ = await Api.uploadAvatar(image);
      if(succ){
        await updateEmployeeData();
      }else{
        App.errMsg(context, "profile", "wrong");
      }
      loading(false);
    }
  }

  Future<bool> updateEmployeeData()async{
    LoginInfo? loginInfo = await Store.loadLoginInfo();
    await Api.hasInternet();
    Global.employee = await Api.login(loginInfo!.email, loginInfo.password);
    if(Global.employee == null){
      return updateEmployeeData();
    }else{
      return true;
    }
  }

  changeLanguage(BuildContext context){
    String lang = "en";
    if(Global.locale == "en"){
      lang = "ar";
    }
    MyApp.set_locale(context, Locale(lang));
    Get.updateLocale(Locale(lang));
    Global.locale = lang;
    Store.saveLanguage(lang);
  }
}