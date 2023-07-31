import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:max_hr/app_localization.dart';
import 'package:max_hr/contoller/add_document_controller.dart';
import 'package:max_hr/helper/app.dart';
import 'package:max_hr/widgets/header_with_back.dart';

class AddDocument extends StatelessWidget {

  AddDocumentController addDocumentController = Get.put(AddDocumentController());

  AddDocument(int? de_id,int doc_id,int hasExpiredDate){
    addDocumentController.de_id = de_id;
    addDocumentController.doc_id = doc_id;
    addDocumentController.hasExpiredDate = hasExpiredDate;
    addDocumentController.initPage();
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
                    addDocumentController.fake.value?Center():Center(),
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
                      addDocumentController.successfully.value
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
                      addDocumentController.loading.value
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
                              Text(App_Localization.of(context).translate("documents"),style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)
                            ],
                          ),
                        addDocumentController.hasExpiredDate == 0?Center():
                          Column(
                            children: [
                              SizedBox(height: 30,),
                              Row(
                                children: [
                                  Text(App_Localization.of(context).translate("expired_at"),style: TextStyle(fontWeight: FontWeight.bold),),
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
                                      addDocumentController.expiredDate = pickedDate;
                                      addDocumentController.refreshPage();
                                    },
                                    child: Container(
                                      height: 50,
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                          color: App.bgGrey,
                                          border: Border.all(color:
                                          addDocumentController.expiredDate == null &&
                                              addDocumentController.validation.value
                                              ?App.red
                                              :App.primary
                                          ),
                                          borderRadius: BorderRadius.circular(15)
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            addDocumentController.expiredDate == null
                                                ?"yyyy-mm-dd"
                                                :getDate(addDocumentController.expiredDate!)
                                            ,style: TextStyle(color: App.grey2),),
                                          Icon(Icons.date_range,color: App.grey2,),
                                        ],
                                      ),
                                    ),
                                  ),),

                                ],
                              ),
                            ],
                          ),

                          SizedBox(height: 10,),



                        GestureDetector(
                          onTap: (){
                            addDocumentController.showImagePicker(true);
                          },
                          child: Container(
                            width: Get.width,
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color:
                              addDocumentController.image == null && addDocumentController.validation.value
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
                                addDocumentController.image != null
                                    ?Icon(Icons.check,color: App.primary,)
                                    :Icon(Icons.file_copy_outlined,color: App.grey2,),

                              ],
                            ),
                          ),
                        ),
                          SizedBox(height: 10,),
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
                              controller: addDocumentController.note,
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
                              addDocumentController.save(context);
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
          addDocumentController.showImagePicker.value?
          GestureDetector(
            onTap: (){
              addDocumentController.showImagePicker(false);
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
                          addDocumentController.pickCamera();
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
                          addDocumentController.pickGallary();
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
}
