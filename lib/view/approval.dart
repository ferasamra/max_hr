import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:max_hr/app_localization.dart';
import 'package:max_hr/contoller/approval_controller.dart';
import 'package:max_hr/helper/api.dart';
import 'package:max_hr/helper/app.dart';
import 'package:max_hr/model/requests.dart';
import 'package:max_hr/view/overtime_request.dart';
import 'package:max_hr/widgets/header_with_back.dart';
import 'package:shimmer/shimmer.dart';

class Approval extends StatelessWidget {

  ApprovalController approvalController = Get.put(ApprovalController());
  Approval({
    int? seleted_tab,
    int? id
  }){
    approvalController.initPage(seleted_tab, id);
    if(seleted_tab != null){
      approvalController.selectedPage(seleted_tab);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() => Container(
          child: Column(
            children: [
              SizedBox(height: 15,),
              HeaderBack(),
              SizedBox(height: 15,),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
                            color: App.bgGrey,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1.5,
                                  blurRadius: 3,
                                  offset: Offset(0, 4)
                              )
                            ]
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: (){
                                approvalController.selectedPage(0);
                              },
                              child: Container(
                                width: Get.width*0.5 - 2,
                                height: 50,
                                child: Center(
                                  child: Text(App_Localization.of(context).translate("overtime_request"),style: TextStyle(fontWeight: FontWeight.bold,
                                      color: approvalController.selectedPage.value == 0?Colors.black:App.grey1),),
                                ),
                              ),
                            ),
                            Container(
                              width: 2,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: App.primary,
                                  borderRadius: BorderRadius.circular(1)
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                approvalController.selectedPage(1);
                              },
                              child: Container(
                                width: Get.width*0.5 - 2,
                                height: 50,
                                child: Center(
                                  child: Text(App_Localization.of(context).translate("vacation"),style: TextStyle(fontWeight: FontWeight.bold,
                                      color: approvalController.selectedPage.value == 1?Colors.black:App.grey1)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child:
                        approvalController.loading.value?
                        Center(
                          child: App.loading(context),
                        ):approvalController.selectedPage.value == 0
                            ?_listOverTime(context)
                            :_listVacations(context),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
  _listOverTime(BuildContext context){
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 20),
        itemCount: approvalController.myRequests!.overtimes.length,
        itemBuilder: (context, index){
      return Obx(() => Container(
        // height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: App.bgGrey,
          border: Border.all(
              color: approvalController.ot_id_notification == approvalController.myRequests!.overtimes[index].otId
                  ?App.primary
                  :Colors.transparent
          )
        ),
        // padding: EdgeInsets.only(bottom: 15,right: 15,left: 15),
        margin: EdgeInsets.only(left: 15,right: 15,top: 15),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      halfCard(App_Localization.of(context).translate("employee"),
                          approvalController.myRequests!.overtimes[index].employee),
                      SizedBox(width: 20,),
                      halfCard(App_Localization.of(context).translate("date"),
                          approvalController.myRequests!.overtimes[index].date.toIso8601String().split("T")[0]),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      halfCard(App_Localization.of(context).translate("from"),
                          approvalController.myRequests!.overtimes[index].from_date+" "+approvalController.myRequests!.overtimes[index].from),
                      SizedBox(width: 20,),
                      halfCard(App_Localization.of(context).translate("to"),
                          approvalController.myRequests!.overtimes[index].to_date+" "+approvalController.myRequests!.overtimes[index].to),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: Get.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(App_Localization.of(context).translate("note"),style: TextStyle(fontWeight: FontWeight.bold,color: App.darkBlue,fontSize: 13),),
                        Text(approvalController.myRequests!.overtimes[index].note,style: TextStyle(color: App.grey2,fontSize: 13),),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  approvalController.myRequests!.overtimes[index].lineManageres.isEmpty?Center():
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: approvalController.myRequests!.overtimes[index].lineManageres.map((e) => positionCard(context,e.manager, e.state, e.managerNote)).toList(),
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          openPopUpOverTime(context, approvalController.myRequests!.overtimes[index]);
                        },
                        child: Container(
                          width: Get.width * 0.25,
                          height: 30,
                          decoration: BoxDecoration(
                              color: App.red,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Center(
                            child: Text(App_Localization.of(context).translate("reject"),style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          approvalController.changeOvertimeState(1, approvalController.myRequests!.overtimes[index], context);
                        },
                        child: Container(
                          width: Get.width * 0.25,
                          height: 30,
                          decoration: BoxDecoration(
                              color: App.primary,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Center(
                            child: Text(App_Localization.of(context).translate("accept"),style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          approvalController.archiveOverTime(approvalController.myRequests!.overtimes[index]);
                        },
                        child: Container(
                          width: Get.width * 0.25,
                          height: 30,
                          decoration: BoxDecoration(
                              color: App.grey1,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Center(
                            child: Text(App_Localization.of(context).translate("archive"),style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
            approvalController.myRequests!.overtimes[index].loading.value
                ?Positioned.fill(
                  child: Shimmer.fromColors(
                  baseColor: App.bgGrey,
                  highlightColor:Colors.grey.withOpacity(0.3),
                  child:  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(15)
                    ),
                  )
            ),
                )
                :Center()
          ],
        ),
      ));
    });
  }
  _listVacations(BuildContext context){
    return ListView.builder(
        padding: EdgeInsets.only(bottom: 20),
        itemCount: approvalController.myRequests!.vacations.length,
        itemBuilder: (context, index){
          return Obx(() => Container(
            // height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: App.bgGrey,
              border: Border.all(
                color: approvalController.vr_id_notification == approvalController.myRequests!.vacations[index].vrId
                    ?App.primary
                    :Colors.transparent
              )
            ),
            // padding: EdgeInsets.only(bottom: 15,right: 15,left: 15),
            margin: EdgeInsets.only(left: 15,right: 15,top: 15),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          halfCard(App_Localization.of(context).translate("vacation"),
                              approvalController.myRequests!.vacations[index].vacationType),
                          SizedBox(width: 20,),
                          halfCard(App_Localization.of(context).translate("at"),
                              approvalController.myRequests!.vacations[index].date.toIso8601String().split("T")[0]),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          halfCard(App_Localization.of(context).translate("employee"),
                              approvalController.myRequests!.vacations[index].employee),
                          SizedBox(width: 20,),
                          halfCard(App_Localization.of(context).translate("date"),
                              approvalController.myRequests!.vacations[index].date.toIso8601String().split("T")[0]),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          halfCard(App_Localization.of(context).translate("from"),
                              approvalController.myRequests!.vacations[index].from),
                          SizedBox(width: 20,),
                          halfCard(App_Localization.of(context).translate("to"),
                              approvalController.myRequests!.vacations[index].from),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Container(
                        width: Get.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(App_Localization.of(context).translate("note"),style: TextStyle(fontWeight: FontWeight.bold,color: App.darkBlue,fontSize: 13),),
                            Text(approvalController.myRequests!.vacations[index].note,style: TextStyle(color: App.grey2,fontSize: 13),),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(App_Localization.of(context).translate("old_vacations"),style: TextStyle(fontWeight: FontWeight.bold,color: App.darkBlue,fontSize: 13),),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              color: approvalController.myRequests!.vacations[index].isPaid==0
                                  ?App.red:App.primary,
                              borderRadius: BorderRadius.circular(3)
                            ),
                            child: Text(App_Localization.of(context).translate(approvalController.myRequests!.vacations[index].isPaid==0?"unpaid":"paid"),style: TextStyle(color: Colors.white),),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(App_Localization.of(context).translate("paid"),style: TextStyle(fontWeight: FontWeight.bold,color: App.primary,fontSize: 13),),
                                SizedBox(width: 3,),
                                Expanded(child: Text("${approvalController.myRequests!.vacations[index].paid.days.toString()}D-${approvalController.myRequests!.vacations[index].paid.days.toString()}hr${approvalController.myRequests!.vacations[index].paid.vacationYouHave}",style: TextStyle(color: App.grey2,fontSize: 13,overflow: TextOverflow.ellipsis),overflow: TextOverflow.ellipsis)),
                              ],
                            ),
                          ),
                          SizedBox(width: 20,),
                          Expanded(child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(App_Localization.of(context).translate("unpaid"),style: TextStyle(fontWeight: FontWeight.bold,color: App.red,fontSize: 13),),
                              SizedBox(width: 3,),
                              Expanded(child: Text("${approvalController.myRequests!.vacations[index].unpaid.days.toString()}D-${approvalController.myRequests!.vacations[index].unpaid.days.toString()}hr${approvalController.myRequests!.vacations[index].unpaid.vacationYouHave}",style: TextStyle(color: App.grey2,fontSize: 13,overflow: TextOverflow.ellipsis),overflow: TextOverflow.ellipsis)),
                            ],
                          ),)
                        ],
                      ),
                      SizedBox(height: 10,),
                      Wrap(
                        children: approvalController.myRequests!.vacations[index].docs.map((e) => GestureDetector(
                          onTap: (){
                            print(Api.media_url+e.doc);
                            // var googleDocsUrl = 'https://docs.google.com/gview?embedded=true&url=${}';
                            App.myLaunchUrl(Api.media_url+e.doc);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                            decoration: BoxDecoration(
                              color: App.primary,
                              borderRadius: BorderRadius.circular(3)
                            ),
                            child: Text(e.type_name,style: TextStyle(color: Colors.white),),
                          ),
                        )).toList(),
                      ),
                      SizedBox(height: 10,),
                      approvalController.myRequests!.vacations[index].lineManageres.isEmpty?Center():
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: approvalController.myRequests!.vacations[index].lineManageres.map((e) => positionCard(context,e.manager, e.state, '')).toList(),
                          ),
                          SizedBox(height: 10,),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (){
                              openPopUpVacation(context, approvalController.myRequests!.vacations[index],-1);
                            },
                            child: Container(
                              width: Get.width * 0.25,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: App.red,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Center(
                                child: Text(App_Localization.of(context).translate("reject"),style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              approvalController.changeVacationState(1, approvalController.myRequests!.vacations[index], context);
                            },
                            child: Container(
                              width: Get.width * 0.25,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: App.primary,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Center(
                                child: Text(App_Localization.of(context).translate("accept"),style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              approvalController.archiveVacation(approvalController.myRequests!.vacations[index]);
                            },
                            child: Container(
                              width: Get.width * 0.25,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: App.grey1,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Center(
                                child: Text(App_Localization.of(context).translate("archive"),style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
                approvalController.myRequests!.vacations[index].loading.value
                    ?Positioned.fill(
                  child: Shimmer.fromColors(
                      baseColor: App.bgGrey,
                      highlightColor:Colors.grey.withOpacity(0.3),
                      child:  Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(15)
                        ),
                      )
                  ),
                )
                    :Center()
              ],
            ),
          ));
        });
  }
  Widget positionCard(BuildContext context,String title,int state , String? note){
    return GestureDetector(
      onTap: (){
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
  openPopUpOverTime(BuildContext context , OvertimeRequest overTimeRequest){
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(App_Localization.of(context).translate("manager_note")),
          content:  SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: approvalController.overTimeNote,
                  keyboardType: TextInputType.multiline,
                  maxLength: null,
                  maxLines: null,
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(App_Localization.of(context).translate("close")),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(App_Localization.of(context).translate("submit")),
              onPressed: () {
                Navigator.of(context).pop();
                approvalController.changeOvertimeState(-1, overTimeRequest,context);
              },
            ),
          ],
        );
      },
    );
  }
  openPopUpVacation(BuildContext context , VacationRequest vacationRequest, int state){
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(App_Localization.of(context).translate("manager_note")),
          content:  Column(
            children: [
              TextField(
                controller: approvalController.vacationNote,
                keyboardType: TextInputType.multiline,
                maxLength: null,
                maxLines: null,
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(App_Localization.of(context).translate("close")),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(App_Localization.of(context).translate("submit")),
              onPressed: () {
                Navigator.of(context).pop();
                if(state == 1){
                  approvalController.acceptNotPaid(vacationRequest,context);
                }else{
                  approvalController.changeVacationState(-1, vacationRequest,context);
                }

              },
            ),
          ],
        );
      },
    );
  }

  halfCard(String title , String content){
    return Expanded(child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,style: TextStyle(fontWeight: FontWeight.bold,color: App.darkBlue,fontSize: 13),),
        Text(content,style: TextStyle(color: App.grey2,fontSize: 13),),
      ],
    ));
  }
}
