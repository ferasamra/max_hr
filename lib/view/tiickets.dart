import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:max_hr/app_localization.dart';
import 'package:max_hr/contoller/disount_reward_controller.dart';
import 'package:max_hr/contoller/overtime_controller.dart';
import 'package:get/get.dart';
import 'package:max_hr/contoller/employee_requests_controller.dart';
import 'package:max_hr/contoller/tickets_controller.dart';
import 'package:max_hr/helper/app.dart';
import 'package:max_hr/view/tickets_replay.dart';
import 'package:max_hr/widgets/header_with_back.dart';
import 'package:max_hr/widgets/month_card.dart';

class Tickets extends StatelessWidget {
  TicketsController ticketsController = Get.put(TicketsController());

  Tickets(){
    ticketsController.initPage();
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
                  ],
                ),
              ),
              Expanded(child: ticketsController.loading.value?
              App.loading(context)
                  :SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/icons/tickets.svg",width: 30,height: 30,),
                        SizedBox(width: 10,),
                        Text(App_Localization.of(context).translate("tickets"),style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: App.darkBlue),)
                      ],
                    ),

                    ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                        itemCount: ticketsController.tickets.length,
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
                                    Text(ticketsController.tickets[index].ticketType ,style: TextStyle(fontWeight: FontWeight.bold,color: App.darkBlue,fontSize: 13),),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(App_Localization.of(context).translate("day"),style: TextStyle(fontWeight: FontWeight.bold,color: App.darkBlue,fontSize: 13),),
                                    Text(App.getDayFromDateTZ(ticketsController.tickets[index].requestedAt.toIso8601String()),style: TextStyle(color: App.grey2,fontSize: 13),),

                                    Text(App_Localization.of(context).translate("date"),style: TextStyle(fontWeight: FontWeight.bold,color: App.darkBlue,fontSize: 13),),
                                    Text(App.formatDateFromTZ(ticketsController.tickets[index].requestedAt.toIso8601String()),style: TextStyle(color: App.grey2,fontSize: 13),),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                SizedBox(
                                  width: Get.width,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(App_Localization.of(context).translate("note"),style: TextStyle(color: App.darkBlue,fontWeight: FontWeight.bold),),
                                      Text(ticketsController.tickets[index].note,style: TextStyle(color: App.grey2),)
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ticketsController.tickets[index].isArchive == 1
                                          ?Text("Archive",style: TextStyle(color: Colors.red),)
                                          :ticketsController.tickets[index].status == 'Closed'
                                          ?Text("Closed",style: TextStyle(color: Colors.blue),)
                                          :Text("Pending",style: TextStyle(color: Colors.orange),),
                                    ),
                                    Expanded(
                                      child: ticketsController.tickets[index].isArchive == 1
                                          ?Center()
                                          :ticketsController.tickets[index].status == 'Closed'
                                          ?Center()
                                          :Container(
                                            alignment: Alignment.centerRight,
                                            child: GestureDetector(
                                              onTap: (){
                                                Get.to(()=>TicketsReplay(ticketsController.tickets[index].ticketId));
                                              },
                                              child: Icon(Icons.chat_outlined,color: App.primary),
                                            ),
                                          )
                                    )
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
              :SvgPicture.asset("assets/icons/dash.svg",width: 10,height: 10,)
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
