import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:max_hr/app_localization.dart';
import 'package:max_hr/contoller/add_request_controller.dart';
import 'package:max_hr/contoller/overtime_request_controller.dart';
import 'package:max_hr/helper/app.dart';
import 'package:max_hr/model/request_type.dart';
import 'package:max_hr/widgets/header.dart';
import 'package:max_hr/widgets/header_with_back.dart';
class AddRequest extends StatelessWidget {

  AddRequestController addRequestController = Get.put(AddRequestController());

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
                addRequestController.fake.value?Center():Center(),
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
                  addRequestController.successfully.value
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
                  addRequestController.loading.value
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
                          Text(App_Localization.of(context).translate("requests"),style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)
                        ],
                      ),
                      SizedBox(height: 30,),
                      Row(
                        children: [
                          Text(App_Localization.of(context).translate("request_type"),style: TextStyle(fontWeight: FontWeight.bold),),
                        ],
                      ),
                      SizedBox(height: 10,),
                      DropdownMenu<int>(
                        width: Get.width-20,

                        initialSelection: addRequestController.types.first.rtId,
                        onSelected: (int? value) {
                          // This is called when the user selects an item.
                          if(value != null){
                            addRequestController.request_type_id = value;
                          }
                        },
                        dropdownMenuEntries: addRequestController.types.map<DropdownMenuEntry<int>>((RequestType value) {
                          return DropdownMenuEntry<int>(value: value.rtId, label: value.name);
                        }).toList(),
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
                            border: Border.all(color:
                                addRequestController.validation.value && addRequestController.note.text.isEmpty
                                ?Colors.red
                                :App.primary
                            )
                        ),
                        child: TextField(
                          controller: addRequestController.note,
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
                          addRequestController.save(context);
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
