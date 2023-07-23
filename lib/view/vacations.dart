import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:max_hr/app_localization.dart';
import 'package:max_hr/contoller/lateness_controller.dart';
import 'package:max_hr/contoller/vacations_controller.dart';
import 'package:max_hr/helper/app.dart';
import 'package:max_hr/helper/global.dart';
import 'package:max_hr/view/main.dart';
import 'package:max_hr/widgets/header.dart';
import 'package:max_hr/widgets/header_with_back.dart';
import 'package:max_hr/widgets/month_card.dart';

class Vacations extends StatelessWidget {
  VacationController vacationController = Get.put(VacationController());

  Vacations(){
    vacationController.initPage();
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
                          controller: vacationController.scrollController,
                          itemCount: vacationController.months.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context ,index){
                            return Padding(padding: EdgeInsets.symmetric(horizontal: 5),
                              child: MonthCard(onPressed: (){
                                vacationController.refreshData(vacationController.months[index].number, vacationController.months[index].year);
                              }, color: vacationController.months[index].selected.value?App.primary:Colors.grey,
                                  text:vacationController.months[index].year.toString()+"/"+vacationController.months[index].shortName+"("+vacationController.months[index].number.toString()+")" ),
                            );
                          }),
                    ),
                    SizedBox(height: 15,),
                  ],
                ),
              ),
              Expanded(child: vacationController.loading.value?
              App.loading(context)
                  :SingleChildScrollView(child: Column(
                children: [
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/icons/vacation.svg",width: 30,height: 30,),
                      SizedBox(width: 10,),
                      Text(App_Localization.of(context).translate("Vacations"),style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: App.darkBlue),)

                    ],
                  ),
                  SizedBox(height: 30,),
                  ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                      itemCount: vacationController.vacationList.isEmpty
                          ?0:
                      vacationController.vacationList.length,
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
                                  Text(App_Localization.of(context).translate("Submission_Date"),style: TextStyle(fontWeight: FontWeight.bold,color: App.darkBlue,fontSize: 13),),
                                  Text(vacationController.vacationList[index].requestedAt,style: TextStyle(color: App.grey2,fontSize: 13),),

                                  Text(App_Localization.of(context).translate("type"),style: TextStyle(fontWeight: FontWeight.bold,color: App.darkBlue,fontSize: 13),),
                                  Text(vacationController.vacationList[index].vacation,style: TextStyle(color: App.grey2,fontSize: 13),),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(App_Localization.of(context).translate("from"),style: TextStyle(fontWeight: FontWeight.bold,color: App.darkBlue,fontSize: 13),),
                                  Text(vacationController.vacationList[index].fromDate.toString()+" "+vacationController.vacationList[index].fromTime.toString(),style: TextStyle(color: App.primary,fontSize: 13),),

                                  Text(App_Localization.of(context).translate("to"),style: TextStyle(fontWeight: FontWeight.bold,color: App.darkBlue,fontSize: 13),),
                                  Text(vacationController.vacationList[index].toDate.toString()+" "+vacationController.vacationList[index].toTime.toString(),style: TextStyle(color: App.red,fontSize: 13),),
                                ],
                              ),
                              vacationController.vacationList[index].note.isEmpty?Center()
                                  :Column(
                                children: [
                                  SizedBox(height: 10,),
                                  SizedBox(
                                    width: Get.width,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(App_Localization.of(context).translate("note"),style: TextStyle(fontWeight: FontWeight.bold,color: App.darkBlue,fontSize: 13),),
                                            Spacer(),
                                            Row(
                                              children: [
                                                  Container(
                                                    width: 10,
                                                    height: 10,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: vacationController.vacationList[index].isPaid == 1?App.primary:App.red
                                                    ),
                                                  ),
                                                SizedBox(width: 6,),
                                                vacationController.vacationList[index].isPaid == 1?
                                                Text(App_Localization.of(context).translate("paid"),style: TextStyle(color: App.primary),)
                                                :Text(App_Localization.of(context).translate("unpaid"),style: TextStyle(color: App.red),),
                                              ],
                                            )
                                          ],
                                        ),
                                        Text(vacationController.vacationList[index].note,style: TextStyle(color: App.grey2,fontSize: 13),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              vacationController.vacationList[index].lineManageres.isEmpty?Center()
                                  :Column(
                                children: [
                                  SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: vacationController.vacationList[index].lineManageres.map((e) => positionCard(context,e.managerPosition, e.state, e.managerNote)).toList(),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      })
                ],
              ),))
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
