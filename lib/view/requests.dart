import 'package:flutter/material.dart';
import 'package:max_hr/app_localization.dart';
import 'package:max_hr/helper/app.dart';
import 'package:get/get.dart';
import 'package:max_hr/view/add_request.dart';
import 'package:max_hr/view/add_tickets.dart';
import 'package:max_hr/view/overtime_request.dart';
import 'package:max_hr/view/vacation_request.dart';
import 'package:max_hr/widgets/header.dart';

class Requests extends StatelessWidget {
  const Requests({Key? key}) : super(key: key);

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
              Container(
                width: Get.width,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.to(()=>VacationRequest());
                      },
                      child: Container(
                        width: Get.width,
                        height: 50,
                        decoration: BoxDecoration(
                            color: App.bgGrey,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: App.primary)
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(App_Localization.of(context).translate("vacation_request"),style: TextStyle(color: App.grey2),),
                              Icon(Icons.arrow_forward_ios,color: App.grey2,)
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    GestureDetector(
                      onTap: (){
                        Get.to(()=>OverTimeRequest());
                      },
                      child: Container(
                        width: Get.width,
                        height: 50,
                        decoration: BoxDecoration(
                            color: App.bgGrey,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: App.primary)
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(App_Localization.of(context).translate("overtime_request"),style: TextStyle(color: App.grey2),),
                              Icon(Icons.arrow_forward_ios,color: App.grey2,)
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    GestureDetector(
                      onTap: (){
                        Get.to(()=>AddRequest());
                      },
                      child: Container(
                        width: Get.width,
                        height: 50,
                        decoration: BoxDecoration(
                            color: App.bgGrey,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: App.primary)
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(App_Localization.of(context).translate("add_requests"),style: TextStyle(color: App.grey2),),
                              Icon(Icons.arrow_forward_ios,color: App.grey2,)
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    GestureDetector(
                      onTap: (){
                        Get.to(()=>AddTicket());
                      },
                      child: Container(
                        width: Get.width,
                        height: 50,
                        decoration: BoxDecoration(
                            color: App.bgGrey,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: App.primary)
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(App_Localization.of(context).translate("add_ticket"),style: TextStyle(color: App.grey2),),
                              Icon(Icons.arrow_forward_ios,color: App.grey2,)
                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                )
              ),

            ],
          ),
        ),
      ),
    );
  }
}
