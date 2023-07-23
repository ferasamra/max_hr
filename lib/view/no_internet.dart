import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max_hr/app_localization.dart';
import 'package:max_hr/helper/api.dart';
import 'package:max_hr/helper/app.dart';
import 'package:max_hr/widgets/primary_bottun.dart';

class NoInternet extends StatelessWidget {

  RxBool loading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: App.primary_mid,
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/background.png"),fit: BoxFit.cover)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() => AnimatedSwitcher(
                duration: Duration(milliseconds: 250),
                child: loading.value
                    ?Container(
                      height: 70,
                      child: Center(
                        child: App.loading(context),
                      ),
                    )
                    :Icon(Icons.wifi_off,color: Colors.white,size: 70,),
              ),
            ),
            SizedBox(height: 20,),
            Text(App_Localization.of(context).translate("no_internet_connection"),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
            SizedBox(height: 20,),
            PrimaryBottun(width: Get.width * 0.4, height: 40, onPressed: ()async{
              loading.value = true;
              if(await Api.checkInterNet()){
                loading.value = false;
                Get.back();
              }else{
                await Future.delayed(Duration(milliseconds: 1000));
                loading.value = false;
              }
            }, color: App.grey1, text: "reload",)
          ],
        ),
      ),
    );
  }
}
