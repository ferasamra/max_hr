import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max_hr/app_localization.dart';
import 'package:max_hr/helper/app.dart';
import 'package:max_hr/helper/global.dart';
import 'package:max_hr/widgets/header.dart';

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(

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
                          offset: Offset(0, 3)
                      )
                    ]
                ),
                width: Get.width,
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Header(),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              card(App_Localization.of(context).translate("name"),Global.employee!.name),
              card(App_Localization.of(context).translate("email"),Global.employee!.email),
              card(App_Localization.of(context).translate("username"),Global.employee!.username),
              card(App_Localization.of(context).translate("employee_duration"),Global.employee!.duration.toString()),
              Global.employee!.isFlixable == 1?Center():
              card("In Time",Global.employee!.inTime.toString()),
              Global.employee!.isFlixable == 1?Center():
              card("Out Time",Global.employee!.outTime.toString()),

            ],
          ),
        ),
      ),
    );
  }

  card(String title , String content){
    return content.isEmpty?Center():Column(
      children: [
        Row(
          children: [
            Text(title,style: TextStyle(fontWeight: FontWeight.bold),),
            Text(content,),
          ],
        ),
        SizedBox(height: 20,),
      ],
    );
  }
}
