import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max_hr/app_localization.dart';
import 'package:max_hr/helper/app.dart';
import 'package:max_hr/helper/global.dart';
import 'package:max_hr/widgets/header.dart';
import 'package:max_hr/widgets/header_with_back.dart';

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(

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


            ],
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
