import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:max_hr/app_localization.dart';
import 'package:max_hr/helper/app.dart';
import 'package:max_hr/view/discount_rewards.dart';
import 'package:max_hr/view/lateness.dart';
import 'package:max_hr/view/overtime.dart';
import 'package:max_hr/view/vacations.dart';
import 'package:max_hr/widgets/header.dart';

class Services extends StatelessWidget {
  const Services({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  width: Get.width,
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
                      SizedBox(height: 20,),
                      Header(),
                      SizedBox(height: 20,),
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                GridView(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  childAspectRatio: 2/1,
                  mainAxisSpacing: 15
                ),
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.to(()=>Lateness());
                      },
                      child: card(context,"assets/icons/lateness.svg", "lateness"),
                    ),
                    GestureDetector(
                        onTap: (){
                          Get.to(()=>OverTime());
                        },
                        child: card(context,"assets/icons/overtime.svg", "OverTimeSchedule"),
                    ),
                    GestureDetector(
                        onTap: (){
                          //todo go to page
                        },
                        child: card(context,"assets/icons/evaluation.svg", "AnnualEvaluation"),
                    ),
                    GestureDetector(
                        onTap: (){
                          Get.to(()=>Vacations());
                        },
                        child: card(context,"assets/icons/vacation.svg", "Vacations"),
                    ),
                    GestureDetector(
                        onTap: (){
                          Get.to(()=>DiscountReward(1));
                        },
                        child: card(context,"assets/icons/rewards.svg", "Rewards"),
                    ),
                    GestureDetector(
                      onTap: (){
                        Get.to(()=>DiscountReward(-1));
                      },
                      child: card(context,"assets/icons/discount.svg", "Discounts"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  card(BuildContext context,String image , String title){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: App.bgGrey,
        borderRadius: BorderRadius.circular(5)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(image,width: 30,height: 30,),
          SizedBox(height: 5,),
          Text(App_Localization.of(context).translate(title),style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: App.darkBlue),)
        ],
      ),
    );
  }
}
