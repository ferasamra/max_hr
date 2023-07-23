import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:max_hr/app_localization.dart';
import 'package:max_hr/contoller/attendance_controller.dart';
import 'package:max_hr/contoller/overtime_controller.dart';
import 'package:get/get.dart';
import 'package:max_hr/helper/app.dart';
import 'package:max_hr/helper/global.dart';
import 'package:max_hr/model/attendance.dart';
import 'package:max_hr/widgets/header_with_back.dart';
import 'package:max_hr/widgets/month_card.dart';

class AttendanceView extends StatelessWidget {
  AttendanceController attendanceController = Get.find();
  AttendanceView(){
    attendanceController.initPage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => SafeArea(
        child: Container(
          child:
          Column(
            children: [
              //header
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
                child: Column(
                  children: [
                    SizedBox(height: 15,),
                    HeaderBack(),
                    SizedBox(height: 15,),
                    Container(
                      height: 32,
                      width: Get.width,
                      child: ListView.builder(
                          controller: attendanceController.scrollController,
                          itemCount: attendanceController.months.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context ,index){
                            return Padding(padding: EdgeInsets.symmetric(horizontal: 5),
                              child: MonthCard(onPressed: (){
                                attendanceController.refreshData(attendanceController.months[index].number, attendanceController.months[index].year);
                              }, color: attendanceController.months[index].selected.value?App.primary:Colors.grey,
                                  text:attendanceController.months[index].year.toString()+"/"+attendanceController.months[index].shortName+"("+attendanceController.months[index].number.toString()+")" ),
                            );
                          }),
                    ),
                    SizedBox(height: 15,),
                  ],
                ),
              ),
              Expanded(child: attendanceController.loading.value?
              App.loading(context)
                  :SingleChildScrollView(
                child: Column(
                  children: [
                    // SizedBox(height: 10,),
                    // Text(attendanceController.attendanceList.length.toString(),style: TextStyle(color: Colors.black,fontSize: 50),),
                    ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                        itemCount: attendanceController.attendanceList.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context , index){
                          return Container(
                            // padding: EdgeInsets.all(15),
                            margin: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                color: App.bgGrey,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                attendanceController.attendanceList[index].data.holiday.length>0
                                    ?Container(
                                  height: 40,
                                  width: Get.width,
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    color: Color(0xff2B455D),
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(10) )
                                  ),
                                  child: Center(
                                    child: Text(attendanceController.attendanceList[index].data.holiday[0].name,style: TextStyle(color: Colors.white,fontSize: 16),),
                                  ),
                                )
                                    :Center(),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(App_Localization.of(context).translate("state"),style: TextStyle(fontWeight: FontWeight.bold,color: App.darkBlue,fontSize: 13),),
                                              getState(context,attendanceController.attendanceList[index]),
                                            ],
                                          )),

                                          SizedBox(width: 20,),

                                          Expanded(child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(App_Localization.of(context).translate("date"),style: TextStyle(fontWeight: FontWeight.bold,color: App.darkBlue,fontSize: 13),),
                                              Text(attendanceController.attendanceList[index].dayName+" "+attendanceController.attendanceList[index].dayDate.toString().split(" ")[0],style: TextStyle(color: App.grey2,fontSize: 13),),
                                            ],
                                          ))
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Column(
                                        children: attendanceController.attendanceList[index].data.details.map((e) {
                                          return Padding(
                                            padding: const EdgeInsets.only(bottom: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text("In",style: TextStyle(fontWeight: FontWeight.bold,color: App.darkBlue,fontSize: 13),),
                                                    Text(e.inTime,style: TextStyle(color: App.primary,fontSize: 13),),
                                                  ],
                                                )),
                                                SizedBox(width: 20,),
                                                Expanded(child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text("Out",style: TextStyle(fontWeight: FontWeight.bold,color: App.darkBlue,fontSize: 13),),
                                                    Text(e.outTime==null?"NaN":(e.outTime!+(e.inDate != e.outDate?(" "+e.outDate!):"")),style: TextStyle(color: App.red,fontSize: 13),),
                                                  ],
                                                )),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(App_Localization.of(context).translate("work_hours"),style: TextStyle(fontWeight: FontWeight.bold,color: App.darkBlue,fontSize: 13),),
                                              Text(attendanceController.attendanceList[index].data.durationAllDay!=null
                                                  ?App.getTextFromMinutes(attendanceController.attendanceList[index].data.durationAllDay!)
                                                  :"NaN",
                                                style: TextStyle(color: App.grey2,fontSize: 11),),
                                            ],
                                          )),

                                          SizedBox(width: 20,),

                                          Expanded(child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(App_Localization.of(context).translate("lateness"),style: TextStyle(fontWeight: FontWeight.bold,color: App.darkBlue,fontSize: 13),),
                                              Text(attendanceController.attendanceList[index].data.lateness.length > 0
                                                  ?App.getTextFromMinutes(attendanceController.attendanceList[index].data.lateness[0].minutes)
                                                  :"NaN",
                                                style: TextStyle(color: App.grey2,fontSize: 11),),
                                            ],
                                          ))
                                        ],
                                      ),
                                      attendanceController.attendanceList[index].data.overtime.length > 0
                                          ?Column(
                                        children: [
                                          SizedBox(height: 10,),
                                          Text(App_Localization.of(context).translate("overtime"),style: TextStyle(fontWeight: FontWeight.bold,color: App.darkBlue,fontSize: 13),),
                                          SizedBox(height: 10,)
                                        ],
                                      )
                                          :Center(),
                                      Column(
                                        children: attendanceController.attendanceList[index].data.overtime.map((e) {
                                          return Padding(
                                            padding: const EdgeInsets.only(bottom: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text("From",style: TextStyle(fontWeight: FontWeight.bold,color: App.darkBlue,fontSize: 13),),
                                                    Text(e.from,style: TextStyle(color: App.primary,fontSize: 13),),
                                                  ],
                                                )),
                                                SizedBox(width: 20,),
                                                Expanded(child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text("To",style: TextStyle(fontWeight: FontWeight.bold,color: App.darkBlue,fontSize: 13),),
                                                    Text(e.to+" "+(e.toDate!=e.fromDate?(" "+ e.toDate):""),style: TextStyle(color: App.red,fontSize: 13),),
                                                  ],
                                                )),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                )

                              ],
                            ),
                          );
                        })
                  ],
                ),
              ))
            ],
          ),
        ),
      )),
    );
  }


  getState(BuildContext context,Attendance attendance){

    if(attendance.data.holiday.isNotEmpty){
      return Text(App_Localization.of(context).translate("holiday"),style: TextStyle(color: App.red,fontSize: 13),);
    }else if(attendance.data.absence.isNotEmpty){
      return Text(App_Localization.of(context).translate("absence"),style: TextStyle(color: App.red,fontSize: 13),);
    }else if(attendance.data.lateness.isNotEmpty){
      return Text(App_Localization.of(context).translate("late"),style: TextStyle(color: App.red,fontSize: 13),);
    }else if(attendance.data.vacations.isNotEmpty){
      return Text(App_Localization.of(context).translate("vacation"),style: TextStyle(color: App.red,fontSize: 13),);
    }else if(attendance.data.durationAllDay==null){
      return Text(App_Localization.of(context).translate("NaN"),style: TextStyle(color: App.red,fontSize: 13),);
    }else if((attendance.data.durationAllDay! /60).toInt()>= attendance.data.employeeDuration){
      return Text(App_Localization.of(context).translate("presence"),style: TextStyle(color: App.primary,fontSize: 13),);
    }else if((attendance.data.durationAllDay! /60).toInt()< attendance.data.employeeDuration){
      return Text(App_Localization.of(context).translate("incomplete"),style: TextStyle(color: App.red,fontSize: 13),);
    }else{
      return Text(App_Localization.of(context).translate("NaN"),style: TextStyle(color: App.red,fontSize: 13),);
    }

  }
}
