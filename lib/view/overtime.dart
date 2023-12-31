import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:max_hr/app_localization.dart';
import 'package:max_hr/contoller/overtime_controller.dart';
import 'package:get/get.dart';
import 'package:max_hr/helper/app.dart';
import 'package:max_hr/widgets/header_with_back.dart';
import 'package:max_hr/widgets/month_card.dart';

class OverTime extends StatelessWidget {
  bool pushedFromNotification;
  OverTimeController overTimeController = Get.put(OverTimeController());
  OverTime({this.pushedFromNotification = false}){
    overTimeController.initPage();
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
                        HeaderBack(hasNotification: pushedFromNotification?false:true),
                        SizedBox(height: 15,),
                        Container(
                          height: 32,
                          width: Get.width,
                          child: ListView.builder(
                              controller: overTimeController.scrollController,
                              itemCount: overTimeController.months.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context ,index){
                                return Padding(padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: MonthCard(onPressed: (){
                                    overTimeController.refreshData(overTimeController.months[index].number, overTimeController.months[index].year);
                                  }, color: overTimeController.months[index].selected.value?App.primary:Colors.grey,
                                      text:overTimeController.months[index].year.toString()+"/"+overTimeController.months[index].shortName+"("+overTimeController.months[index].number.toString()+")" ),
                                );
                              }),
                        ),
                        SizedBox(height: 15,),
                      ],
                    ),
                  ),
                  Expanded(child: overTimeController.loading.value?
                  App.loading(context)
                      :SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/icons/overtime.svg",width: 30,height: 30,),
                            SizedBox(width: 10,),
                            Text(App_Localization.of(context).translate("OverTimeSchedule"),style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: App.darkBlue),)
                          ],
                        ),
                        // SizedBox(height: 10,),
                        ListView.builder(
                            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                            itemCount: overTimeController.overtimeList.isEmpty
                                ?0:
                            overTimeController.overtimeList[0].details.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context , index){
                              return Container(
                                padding: EdgeInsets.all(15),
                                margin: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                    color: App.bgGrey,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(App_Localization.of(context).translate("day"),style: TextStyle(fontWeight: FontWeight.bold,color: App.darkBlue,fontSize: 13),),
                                        Text(App.getDayFromDateTZ(overTimeController.overtimeList[0].details[index].date.toIso8601String()),style: TextStyle(color: App.grey2,fontSize: 13),),

                                        Text(App_Localization.of(context).translate("date"),style: TextStyle(fontWeight: FontWeight.bold,color: App.darkBlue,fontSize: 13),),
                                        Text(App.formatDateFromTZ(overTimeController.overtimeList[0].details[index].date.toIso8601String()),style: TextStyle(color: App.grey2,fontSize: 13),),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(App_Localization.of(context).translate("from"),style: TextStyle(fontWeight: FontWeight.bold,color: App.darkBlue,fontSize: 13),),
                                        Text(overTimeController.overtimeList[0].details[index].fromDate.toString()+" "+overTimeController.overtimeList[0].details[index].fromTime.toString(),style: TextStyle(color: App.primary,fontSize: 13),),

                                        Text(App_Localization.of(context).translate("to"),style: TextStyle(fontWeight: FontWeight.bold,color: App.darkBlue,fontSize: 13),),
                                        Text(overTimeController.overtimeList[0].details[index].toDate.toString()+" "+overTimeController.overtimeList[0].details[index].toTime.toString(),style: TextStyle(color: App.red,fontSize: 13),),
                                      ],
                                    ),
                                    overTimeController.overtimeList[0].details[index].note.isEmpty?Center()
                                        :Column(
                                      children: [
                                        SizedBox(height: 10,),
                                        SizedBox(
                                          width: Get.width,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(App_Localization.of(context).translate("note"),style: TextStyle(fontWeight: FontWeight.bold,color: App.darkBlue,fontSize: 13),),
                                              Text(overTimeController.overtimeList[0].details[index].note,style: TextStyle(color: App.grey2,fontSize: 13),),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    overTimeController.overtimeList[0].details[index].lineManageres.isEmpty?Center()
                                        :Column(
                                      children: [
                                        SizedBox(height: 10,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: overTimeController.overtimeList[0].details[index].lineManageres.map((e) => positionCard(context,e.managerPosition, e.state, e.managerNote)).toList(),
                                        ),
                                      ],
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
  Widget positionCard(BuildContext context,String title,int state , String note){
    return GestureDetector(
      onTap: (){
        if(state == -1){
          openPopUp(context,note);
        }
      },
      child: Column(
        children: [
          SvgPicture.asset("assets/icons/position.svg",width: 20,height: 20,),
          SizedBox(height: 5,),
          Text(title,style: TextStyle(color: App.darkBlue),),
          SizedBox(height: 5,),
          state == -1 ?SvgPicture.asset("assets/icons/close.svg",width: 10,height: 10,)
              :state == 1 ?SvgPicture.asset("assets/icons/check.svg",width: 10,height: 10,)
              :SvgPicture.asset("assets/icons/dash.svg",width: 10,height: 2.5,)
        ],
      ),
    );
  }
  openPopUp(BuildContext context , String note){
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(App_Localization.of(context).translate("manager_note")),
          content:  Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(note,style: TextStyle(color: App.grey2),)
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(App_Localization.of(context).translate("close")),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
