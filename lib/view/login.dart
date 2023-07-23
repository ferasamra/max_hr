import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:max_hr/app_localization.dart';
import 'package:max_hr/contoller/login_contoller.dart';
import 'package:max_hr/helper/app.dart';
import 'package:max_hr/widgets/logo.dart';
import 'package:max_hr/widgets/primary_bottun.dart';

class Login extends StatelessWidget {

  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/background.png"),fit: BoxFit.cover)
        ),
        child: Obx(() => SafeArea(child:
            loginController.loading.value
                ?App.loading(context)
                :
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 60,),
              Logo(70),
              SizedBox(height: 40,),
              Text(App_Localization.of(context).translate("login_now"),style: TextStyle(color: App.grey1,fontSize: 25,fontWeight: FontWeight.bold,),),
              SizedBox(height: 40,),
              Container(
                width: Get.width * 0.9,
                height: 50,
                decoration: BoxDecoration(
                    color: App.lightBlue.withOpacity(0.72),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: TextField(
                  controller: loginController.username,
                  style: TextStyle(color: App.grey1),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person,color: Colors.white,),
                    enabledBorder: loginController.validation.value && loginController.username.text.isEmpty
                        ?OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(10)
                    )
                        :OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(10)
                    ),

                    focusedBorder:  loginController.validation.value && loginController.username.text.isEmpty
                        ?OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(10)
                    )
                        :OutlineInputBorder(
                      borderSide: BorderSide(color: App.primary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    label: Text(App_Localization.of(context).translate("username"),style: TextStyle(color: App.grey1),),
                    labelStyle: TextStyle(color: App.grey1),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                width: Get.width * 0.9,
                height: 50,
                decoration: BoxDecoration(
                    color: App.lightBlue.withOpacity(0.72),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: TextField(
                  controller: loginController.password,
                  style: TextStyle(color: App.grey1),
                  obscureText: loginController.hidePassword.value,

                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock,color: Colors.white,),
                    suffix: IconButton(onPressed: (){
                      loginController.hidePassword(!loginController.hidePassword.value);
                    },icon: Icon(loginController.hidePassword.value?Icons.visibility_off_outlined:Icons.visibility_outlined,color: App.grey1,),),
                    enabledBorder: loginController.validation.value && loginController.password.text.length <= 5
                        ?OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(10)
                    )
                        :OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(10)
                    ),

                    focusedBorder:  loginController.validation.value && loginController.password.text.length <= 5
                        ?OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(10)
                    )
                        :OutlineInputBorder(
                      borderSide: BorderSide(color: App.primary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    label: Text(App_Localization.of(context).translate("password"),style: TextStyle(color: App.grey1),),
                    labelStyle: TextStyle(color: App.grey1),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              PrimaryBottun(width: Get.width * 0.9,
                height: 50,
                onPressed: (){
                  loginController.submit(context);
                }, color: App.primary,
                text: "login",
                radiuce: 25,
              )
            ],
          ),
        ))),
      ),
    );
  }
}
