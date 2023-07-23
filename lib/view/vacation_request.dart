import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:max_hr/app_localization.dart';
import 'package:max_hr/contoller/vacation_requests_controller.dart';
import 'package:max_hr/helper/app.dart';
import 'package:max_hr/model/vacations_type.dart';
import 'package:max_hr/widgets/header_with_back.dart';

class VacationRequest extends StatelessWidget {

  VacationRequestController vacationRequestController = Get.put(VacationRequestController());
  VacationRequest(){
    vacationRequestController.initPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => Stack(
        children: [
          SafeArea(
            child:Container(
              width: Get.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    vacationRequestController.fake.value?Center():Center(),
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
                      vacationRequestController.successfully.value
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
                      vacationRequestController.loading.value
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
                              Text(App_Localization.of(context).translate("vacation_request"),style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)
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
                                  vacationRequestController.fromDate = pickedDate;
                                  vacationRequestController.refreshPage();
                                },
                                child: Container(
                                  height: 50,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: App.bgGrey,
                                      border: Border.all(color:
                                      vacationRequestController.fromDate == null &&
                                          vacationRequestController.validation.value
                                          ?App.red
                                          :App.primary
                                      ),
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        vacationRequestController.fromDate == null
                                            ?"yyyy-mm-dd"
                                            :getDate(vacationRequestController.fromDate!)
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
                                  vacationRequestController.fromTime = selectedTime;
                                  vacationRequestController.refreshPage();
                                },
                                child: Container(
                                  height: 50,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: App.bgGrey,
                                      border: Border.all(color:
                                      vacationRequestController.fromTime == null &&
                                          vacationRequestController.validation.value
                                          ?App.red
                                          :App.primary
                                      ),
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        vacationRequestController.fromTime == null
                                            ?"hh-mm"
                                            :vacationRequestController.fromTime!.format(context)
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
                                  vacationRequestController.toDate = pickedDate;
                                  vacationRequestController.refreshPage();
                                },
                                child: Container(
                                  height: 50,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: App.bgGrey,
                                      border: Border.all(color:
                                      vacationRequestController.toDate == null &&
                                          vacationRequestController.validation.value
                                          ?App.red
                                          :App.primary
                                      ),
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        vacationRequestController.toDate == null
                                            ?"yyyy-mm-dd"
                                            :getDate(vacationRequestController.toDate!)
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
                                  vacationRequestController.toTime = selectedTime;
                                  vacationRequestController.refreshPage();
                                },
                                child: Container(
                                  height: 50,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: App.bgGrey,
                                      border: Border.all(color:
                                      vacationRequestController.toTime == null &&
                                          vacationRequestController.validation.value
                                          ?App.red
                                          :App.primary
                                      ),
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        vacationRequestController.toTime == null
                                            ?"hh-mm"
                                            :vacationRequestController.toTime!.format(context)
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
                              Text(App_Localization.of(context).translate("choose_vacation_type"),style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Container(
                            width: Get.width,
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: App.primary),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: DropdownButton<VacationType>(
                              value: vacationRequestController.selectedVacation,
                              icon: const Icon(Icons.arrow_drop_down_outlined,color: App.grey2),
                              elevation: 16,
                              isExpanded: true,
                              style: const TextStyle(color: App.grey2),
                              underline: Container(
                                height: 2,
                                color: Colors.transparent,
                              ),
                              onChanged: (VacationType? value) {
                                // This is called when the user selects an item.
                                vacationRequestController.selectedVacation = value;
                                vacationRequestController.refreshPage();
                                vacationRequestController.clearSelectedFiles();
                              },
                              items: vacationRequestController.vacations.map<DropdownMenuItem<VacationType>>((VacationType value) {
                                return DropdownMenuItem<VacationType>(
                                  value: value,
                                  child: Text(value.name),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(height: 30,),
                          Column(
                            children: vacationRequestController.selectedVacation!.vacationDocs.map((e) => Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(e.document,style: TextStyle(fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  GestureDetector(
                                    onTap: (){
                                      vacationRequestController.openPicker(e.document,e.docId);
                                    },
                                    child: Container(
                                      width: Get.width,
                                      height: 50,
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        border: Border.all(color:
                                        !vacationRequestController.getIfSelected(e.docId)&& vacationRequestController.validation.value
                                            ?App.red
                                        :App.primary),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            App_Localization.of(context).translate("upload_file")
                                            ,style: TextStyle(color: App.grey2),),
                                          vacationRequestController.getIfSelected(e.docId)
                                              ?Icon(Icons.check,color: App.primary,)
                                              :Icon(Icons.file_copy_outlined,color: App.grey2,),

                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 30,),
                                ],
                              ),
                            )).toList(),
                          ),
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
                              controller: vacationRequestController.note,
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
                              vacationRequestController.save(context);
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
              ),
            ),
          ),
          vacationRequestController.showImagePicker.value?
          GestureDetector(
            onTap: (){
              vacationRequestController.showImagePicker(false);
            },
            child: Container(
              width: Get.width,
              height: Get.height,
              color: Colors.grey.withOpacity(0.6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: (){
                          vacationRequestController.pickCamera();
                        },
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: App.primary
                          ),
                          child: Icon(Icons.camera,color: Colors.white,size: 55),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          vacationRequestController.pickGallary();
                        },
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: App.primary
                          ),
                          child: Icon(Icons.photo,color: Colors.white,size: 55),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ):Center()
        ],
      )),
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
