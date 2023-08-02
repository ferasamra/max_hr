import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:max_hr/app_localization.dart';
import 'package:max_hr/contoller/change_password_controller.dart';
import 'package:max_hr/helper/app.dart';
import 'package:max_hr/widgets/header_with_back.dart';
class ChangePassword extends StatelessWidget {

  ChangePasswordController changePasswordController = Get.put(ChangePasswordController());

  ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: Get.width,
          child: Obx(()=>SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: App.bgGrey,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 25,
                            spreadRadius: 2,
                            offset: const Offset(0, 3)
                        )
                      ]
                  ),
                  width: Get.width,
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      HeaderBack(),
                      SizedBox(height: 10,),
                    ],
                  ),
                ),
                Container(
                  width: Get.width,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child:
                  changePasswordController.successfully.value
                      ?SizedBox(
                      width: Get.width,
                      height: Get.height* 0.7,
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: App.primary,width: 2)
                          ),
                          child: const Icon(Icons.check,color: App.primary,size: 50,),
                        ),
                      )
                  )
                      :
                  changePasswordController.loading.value
                      ?SizedBox(
                    width: Get.width,
                    height: Get.height* 0.7,
                    child: App.loading(context),
                  )
                      :Column(
                    children: [
                      const SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(App_Localization.of(context).translate("change_password"),style: const TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)
                        ],
                      ),
                      const SizedBox(height: 30,),
                      Row(
                        children: [
                          Text(App_Localization.of(context).translate("old_password"),style: const TextStyle(fontWeight: FontWeight.bold),),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: App.bgGrey,
                            border: Border.all(color: App.primary),
                        ),
                        child: TextField(
                          controller: changePasswordController.old,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                            suffix: GestureDetector(
                              onTap: (){
                                changePasswordController.hidOld(!changePasswordController.hidOld.value);
                              },
                              child: changePasswordController.hidOld.value
                                  ?const Icon(Icons.visibility_off,color: App.primary):const Icon(Icons.visibility,color: App.primary,),
                            )
                          ),
                          obscureText: changePasswordController.hidOld.value,

                        ),
                      ),
                      const SizedBox(height: 30,),
                      Row(
                        children: [
                          Text(App_Localization.of(context).translate("new_password"),style: const TextStyle(fontWeight: FontWeight.bold),),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: App.bgGrey,
                            border: Border.all(color: App.primary)
                        ),
                        child: TextField(
                          controller: changePasswordController.newPass,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              suffix: GestureDetector(
                                onTap: (){
                                  changePasswordController.hideNew(!changePasswordController.hideNew.value);
                                },
                                child: changePasswordController.hideNew.value
                                    ?const Icon(Icons.visibility_off,color: App.primary):const Icon(Icons.visibility,color: App.primary,),
                              )
                          ),
                          obscureText: changePasswordController.hideNew.value,
                        ),
                      ),
                      const SizedBox(height: 30,),
                      Row(
                        children: [
                          Text(App_Localization.of(context).translate("confirm_password"),style: const TextStyle(fontWeight: FontWeight.bold),),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: App.bgGrey,
                            border: Border.all(color: App.primary)
                        ),
                        child: TextField(
                          controller: changePasswordController.confirm,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              suffix: GestureDetector(
                                onTap: (){
                                  changePasswordController.hideConfirm(!changePasswordController.hideConfirm.value);
                                },
                                child: changePasswordController.hideConfirm.value
                                    ?const Icon(Icons.visibility_off,color: App.primary):const Icon(Icons.visibility,color: App.primary,),
                              )
                          ),
                          obscureText: changePasswordController.hideConfirm.value,
                        ),
                      ),
                      const SizedBox(height: 30,),
                      GestureDetector(
                        onTap: (){
                          changePasswordController.submit(context);
                        },
                        child: Container(
                          width: Get.width,
                          height: 50,
                          decoration: BoxDecoration(
                              color: App.primary,
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Center(
                            child: Text(App_Localization.of(context).translate("save"),style: const TextStyle(color: Colors.white),),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30,),
                    ],
                  ),
                )




              ],
            ),
          )),
        ),
      ),
    );
  }

  getDate(DateTime dateTime){
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return formattedDate;
  }
  getTime(DateTime dateTime){
    String formattedDate = DateFormat('kk:mm').format(dateTime);
    return formattedDate;
  }
}
