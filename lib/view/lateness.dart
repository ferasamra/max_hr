import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:max_hr/app_localization.dart';
import 'package:max_hr/contoller/lateness_controller.dart';
import 'package:max_hr/helper/app.dart';
import 'package:max_hr/helper/global.dart';
import 'package:max_hr/view/main.dart';
import 'package:max_hr/widgets/header.dart';
import 'package:max_hr/widgets/header_with_back.dart';
import 'package:max_hr/widgets/month_card.dart';

class Lateness extends StatelessWidget {
  LatenessController latenessController = Get.put(LatenessController());

  Lateness(){
    latenessController.initPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => SafeArea(
        child: Container(
          child:Column(
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
                            controller: latenessController.scrollController,
                              itemCount: latenessController.months.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context ,index){
                                return Padding(padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: MonthCard(onPressed: (){
                                    latenessController.refreshData(latenessController.months[index].number, latenessController.months[index].year);
                                  }, color: latenessController.months[index].selected.value?App.primary:Colors.grey,
                                      text:latenessController.months[index].year.toString()+"/"+latenessController.months[index].shortName+"("+latenessController.months[index].number.toString()+")" ),
                                );
                              }),
                        ),
                        SizedBox(height: 15,),
                      ],
                    ),
                  ),
                  Expanded(child: latenessController.loading.value?
                  App.loading(context)
                      :SingleChildScrollView(child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/icons/lateness.svg",width: 30,height: 30,),
                          SizedBox(width: 10,),
                          Text(App_Localization.of(context).translate("lateness"),style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: App.darkBlue),)

                        ],
                      ),
                      SizedBox(height: 30,),
                      GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 4/2
                          ),
                          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                          itemCount: latenessController.latenessList.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context , index){
                            return Container(
                              decoration: BoxDecoration(
                                  color: App.bgGrey,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(latenessController.latenessList[index].formatedDate,style: TextStyle(color: App.primary,fontWeight: FontWeight.bold),),
                                  Text(App.getTextFromMinutes(latenessController.latenessList[index].minutes)),
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
}
