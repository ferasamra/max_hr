import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:max_hr/helper/api.dart';
import 'package:max_hr/helper/app.dart';
import 'package:max_hr/helper/global.dart';
import 'package:max_hr/helper/store.dart';
import 'package:max_hr/model/login_info.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomeController extends GetxController{
  PersistentTabController pageController = PersistentTabController(initialIndex: 0);
  RxInt selectedPage = 0.obs;
  RxBool loading = false.obs;
  RxBool shadow = false.obs;
  final ImagePicker picker = ImagePicker();
  TextEditingController attendanceJustification = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    alwaysRunning();
  }

  alwaysRunning()async{
    while(true){
      await Future.delayed(const Duration(milliseconds: 500));
      shadow(!shadow.value);
    }
  }

  checkInOut(BuildContext context)async{
    try{
      loading(true);
      await Api.hasInternet();
      // ignore: use_build_context_synchronously
      Position? location = await _determinePosition(context);
      if(location != null){
        String locationString =  "https://www.google.com/maps/search/?api=1&query=${location.latitude},${location.longitude}";
        if(Global.employee!.need_photo_at_check_in == 1
        &&!(Global.employee!.lastOperation != null && Global.employee!.lastOperation!.outDateTime == null)){
          final XFile? image = await picker.pickImage(source: ImageSource.camera,
              imageQuality: 15,
              preferredCameraDevice: CameraDevice.front,
          );
          if(image != null ){
            if(Global.employee!.lastBreakOperation !=null &&
                Global.employee!.lastBreakOperation!.outDateTime ==null){
              await Api.breakInOut();
            }
            await Api.checkInOutWithImage(locationString,image,attendanceJustification.text);
          }else{
            // ignore: use_build_context_synchronously
            App.errMsg(context, "attendance", "please_take_a_photo_because_it_required");
            loading(false);
            return;
          }
        }else{
          if(Global.employee!.lastBreakOperation !=null &&
              Global.employee!.lastBreakOperation!.outDateTime ==null){
            await Api.breakInOut();
          }
          await Api.checkInOutWithImage(locationString,null,attendanceJustification.text);
        }
        await updateEmployeeData();
      }
      loading(false);
    }catch(e){
      App.errMsg(context, "attendance", "wrong");
    }
  }

  breakInOut(BuildContext context)async{
    try{
      loading(true);
      await Api.hasInternet();
      await Api.breakInOut();
      await updateEmployeeData();
      loading(false);
    }catch(e){
      App.errMsg(context, "attendance", "wrong");
    }
  }

  Future<bool> updateEmployeeData()async{
    LoginInfo? loginInfo = await Store.loadLoginInfo();
    await Api.hasInternet();
    attendanceJustification.clear();
    Global.employee = await Api.login(loginInfo!.email, loginInfo.password);
    if(Global.employee == null){
      return updateEmployeeData();
    }else{
      return true;
    }
  }

  Future<Position?> _determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ignore: use_build_context_synchronously
      App.errMsg(context,"location", "please_turn_location_on");
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied||permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ignore: use_build_context_synchronously
        App.errMsg(context,"location", "Please_allow_location");
        return null;
      }
    }

    var curr = await Geolocator.getCurrentPosition();
    return curr;
  }

}