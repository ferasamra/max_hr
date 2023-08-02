import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max_hr/app_localization.dart';
import 'package:max_hr/contoller/home_controller.dart';
import 'package:max_hr/helper/app.dart';
import 'package:max_hr/helper/global.dart';
import 'package:max_hr/model/employee.dart';
import 'package:max_hr/view/approval.dart';
import 'package:max_hr/view/overtime.dart';
import 'package:max_hr/view/vacation_request.dart';
import 'package:max_hr/view/vacations.dart';
import 'package:max_hr/widgets/month_card.dart';
import 'package:max_hr/widgets/header.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    try{
      if (message.data!=null&&message.data['page'].toString() == 'vacations') {
        Get.to(()=>Vacations());
      }else if (message.data!=null&&message.data['page'].toString() == 'overtime'){
        Get.to(()=>OverTime());
      }else if (message.data!=null&&message.data['page'].toString() == 'approvals'){
        Get.to(()=>Approval(
          id: int.parse(message.data['id'].toString()),
          seleted_tab: int.parse(message.data['selected_tab'].toString()),
        ));
      }
    }catch(e){

    }
  }

  @override
  void initState() {
    super.initState();
    setupInteractedMessage();
  }

  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: App.bgGrey,
      body: Obx(() => SafeArea(child:
      homeController.loading.value?
      App.loading(context)
          :Container(
            child: SingleChildScrollView(
        child: Column(
            children: [
              Container(
                width: Get.width,
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Header()
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MonthCard(onPressed: (){

                  }, color: App.primary, text: Global.currentMonth.name)
                ],
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: Get.width,
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          App_Localization.of(context).translate("attendance_and_tardiness"),
                          style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: ((Get.width-20)/3)-10,
                          height: (((Get.width-20)/3)-10) * 70 / 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage("assets/images/background.png"),fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(Global.employee!.attendancePercentPerMonth.toStringAsFixed(2)+" %",style: TextStyle(color: App.primary,fontSize: 19),),
                              SizedBox(height: 8,),
                              Text(App_Localization.of(context).translate("attendance_rate"),style: TextStyle(color: App.grey1,fontSize: 11),)
                            ],
                          ),
                        ),
                        Container(
                          width: ((Get.width-20)/3)-10,
                          height: (((Get.width-20)/3)-10) * 70 / 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage("assets/images/background.png"),fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(Global.employee!.absenceCount.toString(),style: TextStyle(color: App.primary,fontSize: 19),),
                              SizedBox(height: 8,),
                              Text(App_Localization.of(context).translate("absence"),style: TextStyle(color: App.grey1,fontSize: 11),)
                            ],
                          ),
                        ),
                        Container(
                          width: ((Get.width-20)/3)-10,
                          height: (((Get.width-20)/3)-10) * 70 / 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage("assets/images/background.png"),fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(Global.employee!.latnessCount.toString(),style: TextStyle(color: App.primary,fontSize: 19),),
                              SizedBox(height: 8,),
                              Text(App_Localization.of(context).translate("lateness"),style: TextStyle(color: App.grey1,fontSize: 11),)
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              lastOperation(context,Global.employee!.lastOperation),
              SizedBox(height: 20,),
              AnimatedContainer(
                width: Get.width /2,
                duration: Duration(milliseconds: 500),
                height: Get.width /2,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Global.employee!.lastOperation == null|| (Global.employee!.lastOperation!.out_date != null)
                            ?App.grey4:homeController.shadow.value?
                        App.primary:App.darkPrimary,
                      ),
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: -5.0,
                        blurRadius: 20.0,
                      ),
                    ]
                ),
                child: GestureDetector(
                  onTap: (){
                    homeController.checkInOut(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: App.bgGrey,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(App_Localization.of(context).translate("press_to"),style: TextStyle(color: App.grey2),),
                          SizedBox(height: 5,),
                          Global.employee!.lastOperation == null|| (Global.employee!.lastOperation!.out_date != null)?
                          Text(App_Localization.of(context).translate("check_in"),style: TextStyle(color: App.grey2,fontWeight: FontWeight.bold,fontSize: 18),)
                              :Text(App_Localization.of(context).translate("check_out"),style: TextStyle(color: App.grey2,fontWeight: FontWeight.bold,fontSize: 18),),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
        ),
      ),
          ))),
    );
  }

  lastOperation(BuildContext context,LastOperation? lastOperation){
    if(lastOperation ==null){
      return Center();
    }
    return Container(
      width: Get.width,

      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
      child: Column(
        children: [
          LastOperationText(context , lastOperation.inDateTime, lastOperation.outDateTime),
          Text(
              lastOperation.out_time!=null
                  ?lastOperation.out_time.toString()
                  :lastOperation.in_time.toString(),
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40,letterSpacing: 4),
          ),
          SizedBox(height: 10,),
          Container(
            width: 100,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1.0,
                    blurRadius: 2.0,
                  ),
                ]
            ),
            child: Center(
              child: Text(
                lastOperation.out_date!=null
                    ?lastOperation.out_date.toString()
                    :lastOperation.in_date.toString(),
                style: TextStyle(color: App.grey3,fontSize: 12),
              ),
            ),
          ),
          SizedBox(height: 20,),
          Divider(height: 1,thickness: 1,color: App.grey3,)
        ],
      ),
    );
  }

  LastOperationText(BuildContext context,DateTime inDate,DateTime? outDate){
    if(outDate != null){
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(App_Localization.of(context).translate("last_out"),style: TextStyle(color: App.primary,fontSize: 19,fontWeight: FontWeight.bold,letterSpacing: 4),),
      );
    }else{
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(App_Localization.of(context).translate("last_in"),style: TextStyle(color: App.primary,fontSize: 19,fontWeight: FontWeight.bold,letterSpacing: 4),),
      );
    }

  }
}
