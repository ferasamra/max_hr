import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max_hr/helper/app.dart';
import 'package:max_hr/helper/global.dart';
import 'package:max_hr/view/approval.dart';
import 'package:max_hr/view/overtime.dart';
import 'package:max_hr/view/requests.dart';
import 'package:max_hr/view/vacation_request.dart';
import 'package:max_hr/view/vacations.dart';
import 'package:max_hr/widgets/header_with_back.dart';

class MyNotification extends StatelessWidget {
  const MyNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: Get.width,
          child:Column(
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
                    HeaderBack(hasNotification: false),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              Expanded(
                child: Container(
                  width: Get.width,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                    itemCount: Global.employee!.notification.length,
                    itemBuilder: (context , index){
                      return GestureDetector(
                        onTap: (){
                          if(Global.employee!.notification[index].data != null){
                            var data = json.decode(Global.employee!.notification[index].data!);
                            if(json.decode(Global.employee!.notification[index].data!)["page"] != null){
                              try{
                                if (data!=null&&data['page'].toString() == 'vacations') {
                                  Get.to(()=>Vacations(pushedFromNotification: true));
                                }else if (data!=null&&data['page'].toString() == 'overtime'){
                                  Get.to(()=>OverTime(pushedFromNotification: true));
                                }else if (data!=null&&data['page'].toString() == 'requests'){
                                  Get.to(()=>Requests());
                                }else if (data!=null&&data['page'].toString() == 'approvals'){
                                  Get.to(()=>Approval(
                                    id: int.parse(data['id'].toString()),
                                    seleted_tab: int.parse(data['selected_tab'].toString()),
                                    pushedFromNotification: true,
                                  ));
                                }
                              }catch(e){

                              }
                            }
                          }

                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: App.bgGrey,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.notifications_none,color: App.primary,),
                              SizedBox(width: 10,),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(Global.employee!.notification[index].createdAt.toString().split(".")[0],style: TextStyle(color: App.grey3,fontSize: 10)),
                                    SizedBox(height: 0,),
                                    Text(Global.employee!.notification[index].title,style: TextStyle(fontWeight: FontWeight.bold),),
                                    SizedBox(height: 5,),
                                    Text(Global.employee!.notification[index].body,maxLines: 20,overflow: TextOverflow.clip),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  )

                ),
              )




            ],
          ),
        ),
      ),
    );
  }
}
