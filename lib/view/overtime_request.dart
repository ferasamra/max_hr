import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:max_hr/app_localization.dart';
import 'package:max_hr/contoller/overtime_request_controller.dart';
import 'package:max_hr/helper/app.dart';
import 'package:max_hr/widgets/header.dart';
import 'package:max_hr/widgets/header_with_back.dart';
class OverTimeRequest extends StatelessWidget {

  OverTimeRequestController overTimeRequestController = Get.put(OverTimeRequestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: Get.width,
          child: Obx(()=>SingleChildScrollView(
            child: Column(
              children: [
                overTimeRequestController.fake.value?Center():Center(),
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
                      HeaderBack(),
                      SizedBox(height: 10,),
                    ],
                  ),
                ),
                Container(
                  width: Get.width,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child:
                  overTimeRequestController.successfully.value
                      ?Container(
                        width: Get.width,
                        height: Get.height* 0.7,
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: App.primary,width: 2)
                            ),
                            child: Icon(Icons.check,color: App.primary,size: 50,),
                          ),
                        )
                      )
                      :
                  overTimeRequestController.loading.value
                  ?Container(
                    width: Get.width,
                    height: Get.height* 0.7,
                    child: App.loading(context),
                  )
                  :Column(
                    children: [
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(App_Localization.of(context).translate("overtime_request"),style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)
                        ],
                      ),
                      SizedBox(height: 30,),
                      Row(
                        children: [
                          Expanded(child:  Center(
                            child: Text("From Date",style: TextStyle(fontWeight: FontWeight.bold),),
                          )),
                          SizedBox(width: 10,),
                          Expanded(child:  Center(
                            child: Text("From Time",style: TextStyle(fontWeight: FontWeight.bold),),
                          )),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Expanded(child:  GestureDetector(
                            onTap: ()async{
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2023),
                                  lastDate: DateTime(DateTime.now().year+1));
                              overTimeRequestController.fromDate = pickedDate;
                              overTimeRequestController.refreshPage();
                            },
                            child: Container(
                              height: 50,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: App.bgGrey,
                                  border: Border.all(color:
                                  overTimeRequestController.fromDate == null &&
                                      overTimeRequestController.validation.value
                                      ?App.red
                                      :App.primary
                                  ),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                  overTimeRequestController.fromDate == null
                                      ?"yyyy-mm-dd"
                                      :getDate(overTimeRequestController.fromDate!)
                                ,style: TextStyle(color: App.grey2),),
                                  Icon(Icons.date_range,color: App.grey2,),
                                ],
                              ),
                            ),
                          ),),
                          SizedBox(width: 10,),
                          Expanded(child:  GestureDetector(
                            onTap: ()async{
                              TimeOfDay? selectedTime = await showTimePicker(
                                initialTime: TimeOfDay.now(),
                                context: context,
                              );
                              print(selectedTime);
                              overTimeRequestController.fromTime = selectedTime;
                              overTimeRequestController.refreshPage();
                            },
                            child: Container(
                              height: 50,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: App.bgGrey,
                                  border: Border.all(color:
                                  overTimeRequestController.fromTime == null &&
                                      overTimeRequestController.validation.value
                                      ?App.red
                                      :App.primary
                                  ),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    overTimeRequestController.fromTime == null
                                        ?"hh-mm"
                                        :overTimeRequestController.fromTime!.format(context)
                                    ,style: TextStyle(color: App.grey2),),
                                  Icon(Icons.access_time,color: App.grey2,),
                                ],
                              ),
                            ),
                          ),),
                        ],
                      ),
                      SizedBox(height: 30,),
                      Row(
                        children: [
                          Expanded(child:  Center(
                            child: Text("To Date",style: TextStyle(fontWeight: FontWeight.bold),),
                          )),
                          SizedBox(width: 10,),
                          Expanded(child:  Center(
                            child: Text("To Time",style: TextStyle(fontWeight: FontWeight.bold),),
                          )),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Expanded(child:  GestureDetector(
                            onTap: ()async{
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2023),
                                  lastDate: DateTime(DateTime.now().year+1));
                              overTimeRequestController.toDate = pickedDate;
                              overTimeRequestController.refreshPage();
                            },
                            child: Container(
                              height: 50,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: App.bgGrey,
                                  border: Border.all(color:
                                  overTimeRequestController.toDate == null &&
                                      overTimeRequestController.validation.value
                                      ?App.red
                                      :App.primary
                                  ),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    overTimeRequestController.toDate == null
                                        ?"yyyy-mm-dd"
                                        :getDate(overTimeRequestController.toDate!)
                                    ,style: TextStyle(color: App.grey2),),
                                  Icon(Icons.date_range,color: App.grey2,),
                                ],
                              ),
                            ),
                          ),),
                          SizedBox(width: 10,),
                          Expanded(child:  GestureDetector(
                            onTap: ()async{
                              TimeOfDay? selectedTime = await showTimePicker(
                                initialTime: TimeOfDay.now(),
                                context: context,
                              );
                              print(selectedTime);
                              overTimeRequestController.toTime = selectedTime;
                              overTimeRequestController.refreshPage();
                            },
                            child: Container(
                              height: 50,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: App.bgGrey,
                                  border: Border.all(color:
                                  overTimeRequestController.toTime == null &&
                                      overTimeRequestController.validation.value
                                      ?App.red
                                      :App.primary
                                  ),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    overTimeRequestController.toTime == null
                                        ?"hh-mm"
                                        :overTimeRequestController.toTime!.format(context)
                                    ,style: TextStyle(color: App.grey2),),
                                  Icon(Icons.access_time,color: App.grey2,),
                                ],
                              ),
                            ),
                          ),),
                        ],
                      ),
                      SizedBox(height: 30,),
                      Row(
                        children: [
                          Text(App_Localization.of(context).translate("note"),style: TextStyle(fontWeight: FontWeight.bold),),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                            color: App.bgGrey,
                          border: Border.all(color: App.primary)
                        ),
                        child: TextField(
                          controller: overTimeRequestController.note,
                          keyboardType: TextInputType.multiline,
                          minLines: 1, // <-- SEE HERE
                          maxLines: 10, // <-- SEE HERE
                          decoration: InputDecoration(
                            border: InputBorder.none
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                      GestureDetector(
                        onTap: (){
                          overTimeRequestController.save(context);
                        },
                        child: Container(
                          width: Get.width,
                          height: 50,
                          decoration: BoxDecoration(
                            color: App.primary,
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: Center(
                            child: Text(App_Localization.of(context).translate("save"),style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                    ],
                  ),
                )




              ],
            ),
          )),
        ),
      ),
    );
  }

  getDate(DateTime dateTime){
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return formattedDate;
  }
  getTime(DateTime dateTime){
    String formattedDate = DateFormat('kk:mm').format(dateTime);
    return formattedDate;
  }
}
