import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:max_hr/app_localization.dart';
import 'package:max_hr/contoller/personal_info_controller.dart';
import 'package:max_hr/helper/api.dart';
import 'package:max_hr/helper/app.dart';
import 'package:max_hr/helper/global.dart';
import 'package:max_hr/view/add_document.dart';
import 'package:max_hr/widgets/header.dart';
import 'package:max_hr/widgets/header_with_back.dart';

class PersonalInfo extends StatelessWidget {
  PersonalInfoController personalInfoController = Get.put(PersonalInfoController());
  PersonalInfo(){
    personalInfoController.initPage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.white,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
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
                      SizedBox(height: 10,),
                      HeaderBack(),
                      SizedBox(height: 10,),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(height: 30,),
                      card(App_Localization.of(context).translate("name"),Global.employee!.name),
                      card(App_Localization.of(context).translate("email"),Global.employee!.email),
                      card(App_Localization.of(context).translate("username"),Global.employee!.username),
                      card(App_Localization.of(context).translate("employee_duration"),Global.employee!.duration.toString()),
                      Global.employee!.isFlixable == 1?Center():
                      card("In Time",Global.employee!.inTime.toString()),
                      Global.employee!.isFlixable == 1?Center():
                      card("Out Time",Global.employee!.outTime.toString()),
                      card(App_Localization.of(context).translate("nationality"),Global.employee!.nationality),
                      card(App_Localization.of(context).translate("date_of_birth"),Global.employee!.dateOfBirth == null ?null:Global.employee!.dateOfBirth.toString()),
                      card(App_Localization.of(context).translate("passport_number"),Global.employee!.passportNumber),
                      card(App_Localization.of(context).translate("personal_phone_number"),Global.employee!.personalPhoneNumber),
                      card(App_Localization.of(context).translate("country_of_residence"),Global.employee!.countryOfResidence),
                      card(App_Localization.of(context).translate("emirate"),Global.employee!.emirate),
                      card(App_Localization.of(context).translate("home_address"),Global.employee!.homeAddress),
                      card(App_Localization.of(context).translate("educational_level"),Global.employee!.educationalLevel),
                      card(App_Localization.of(context).translate("academic_major"),Global.employee!.academicMajor),
                      card(App_Localization.of(context).translate("experience_year"),Global.employee!.experienceYear == null?null:Global.employee!.experienceYear.toString()),
                      card(App_Localization.of(context).translate("experience_year_related"),Global.employee!.experienceYearRelated == null?null:Global.employee!.experienceYearRelated.toString()),
                      card(App_Localization.of(context).translate("experience_year_related"),Global.employee!.experienceYearRelated == null?null:Global.employee!.experienceYearRelated.toString()),
                      card(App_Localization.of(context).translate("joining_date"),Global.employee!.joiningDate == null?null:Global.employee!.joiningDate.toString()),
                      card(App_Localization.of(context).translate("office_name"),Global.employee!.officeName),
                      card(App_Localization.of(context).translate("visa_under"),Global.employee!.visaUnder),
                      card(App_Localization.of(context).translate("business_email"),Global.employee!.businessEmail),
                      card(App_Localization.of(context).translate("business_number"),Global.employee!.businessNumber),
                      card(App_Localization.of(context).translate("internet_and_call_pakage"),Global.employee!.internetAndCallPakage),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(App_Localization.of(context).translate("documents"),style: TextStyle(color: App.darkBlue,fontWeight: FontWeight.bold,fontSize: 23),)
                  ],
                ),
                SizedBox(height: 10,),
                Obx(() => personalInfoController.loading.value?App.loading(context):
                  Column(
                    children: personalInfoController.docs.map((e) => Container(
                      child: Container(
                        width: Get.width,
                        margin: EdgeInsets.symmetric(vertical: 8,horizontal: 15),
                        padding: EdgeInsets.symmetric(vertical: 8,horizontal: 15),
                        decoration: BoxDecoration(
                          color: App.bgGrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(e.name,style: TextStyle(color: App.darkBlue,fontWeight: FontWeight.bold,fontSize: 16),),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                                  decoration: BoxDecoration(
                                    color: e.documentCount > 0?App.primary:App.red,
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Text(
                                    e.documentCount > 0
                                        ?App_Localization.of(context).translate("done")
                                        :App_Localization.of(context).translate("missed"),
                                    style: TextStyle(color: Colors.white,fontSize: 10),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text(App_Localization.of(context).translate("expired_at"),style: TextStyle(color: App.darkBlue,fontWeight: FontWeight.bold),),
                                SizedBox(width: 8,),
                                Text(
                                  e.hasExpiredDate == 0
                                      ?App_Localization.of(context).translate("no_expiration_date")
                                      :e.expiredDate == null
                                      ?App_Localization.of(context).translate("Not-Set")
                                      :e.expiredDate!.toIso8601String().split("T")[0]
                                  ,style: TextStyle(color: App.grey3),
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Text(App_Localization.of(context).translate("required"),style: TextStyle(color: App.darkBlue,fontWeight: FontWeight.bold),),
                                    SizedBox(width: 8,),
                                    e.isRequired == 1 ?SvgPicture.asset("assets/icons/check.svg",width: 10,height: 10,)
                                        :SvgPicture.asset("assets/icons/dash.svg",width: 10,height: 2,)
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 10,),
                            e.document == null?
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Get.to(()=>AddDocument(e.deId,e.docId,e.hasExpiredDate));
                                  },
                                  child: Container(
                                    width: Get.width* 0.3,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: App.primary,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Text(App_Localization.of(context).translate("add_new"),style: TextStyle(color: Colors.white),),
                                    ),
                                  ),
                                )
                              ],
                            ):Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Get.to(()=>AddDocument(e.deId,e.docId,e.hasExpiredDate));
                                  },
                                  child: Container(
                                    width: Get.width* 0.25,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: App.primary,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Text(App_Localization.of(context).translate("edit"),style: TextStyle(color: Colors.white),),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    personalInfoController.deleteDocument(context,e.deId);
                                  },
                                  child: Container(
                                    width: Get.width* 0.25,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: App.red,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Text(App_Localization.of(context).translate("delete"),style: TextStyle(color: Colors.white),),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    if(e.document != null){
                                      App.myLaunchUrl(Api.media_url+e.document!);
                                    }
                                  },
                                  child: Container(
                                    width: Get.width* 0.25,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: App.grey3,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Text(App_Localization.of(context).translate("show"),style: TextStyle(color: Colors.white),),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )).toList(),
                  )
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

  card(String title , String? content){
    return (content==null || content.isEmpty)?Center():Column(
      children: [
        Row(
          children: [
            Text(title,style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(width: 20,),
            Text(content,),
          ],
        ),
        SizedBox(height: 20,),
      ],
    );
  }
}
