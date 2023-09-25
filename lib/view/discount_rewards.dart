import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:max_hr/app_localization.dart';
import 'package:max_hr/contoller/disount_reward_controller.dart';
import 'package:max_hr/contoller/overtime_controller.dart';
import 'package:get/get.dart';
import 'package:max_hr/helper/app.dart';
import 'package:max_hr/widgets/header_with_back.dart';
import 'package:max_hr/widgets/month_card.dart';

class DiscountReward extends StatelessWidget {
  DiscountRewardController discountRewardController = Get.put(DiscountRewardController());
  int state;
  DiscountReward(this.state){
    discountRewardController.initPage(this.state);
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
              Expanded(child: discountRewardController.loading.value?
              App.loading(context)
                  :SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    this.state == -1
                        ?Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/icons/discount.svg",width: 30,height: 30,),
                        SizedBox(width: 10,),
                        Text(App_Localization.of(context).translate("Discounts"),style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: App.darkBlue),)
                      ],
                    )
                    :Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/icons/rewards.svg",width: 30,height: 30,),
                        SizedBox(width: 10,),
                        Text(App_Localization.of(context).translate("Rewards"),style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: App.darkBlue),)
                      ],
                    ),
                    // SizedBox(height: 10,),
                    ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                        itemCount: discountRewardController.discountRewardList.length,
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
                                    Text(App_Localization.of(context).translate("day"),style: TextStyle(fontWeight: FontWeight.bold,color: App.darkBlue,fontSize: 13),),
                                    Text(App.getDayFromDateTZ(discountRewardController.discountRewardList[index].date.toIso8601String()),style: TextStyle(color: App.grey2,fontSize: 13),),

                                    Text(App_Localization.of(context).translate("date"),style: TextStyle(fontWeight: FontWeight.bold,color: App.darkBlue,fontSize: 13),),
                                    Text(App.formatDateFromTZ(discountRewardController.discountRewardList[index].date.toIso8601String()),style: TextStyle(color: App.grey2,fontSize: 13),),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                SizedBox(
                                  width: Get.width,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      this.state == 1?Text(App_Localization.of(context).translate("reward"),style: TextStyle(color: App.darkBlue,fontWeight: FontWeight.bold),)
                                          :Text(App_Localization.of(context).translate("discount"),style: TextStyle(color: App.darkBlue,fontWeight: FontWeight.bold),),
                                      Text(discountRewardController.discountRewardList[index].note,style: TextStyle(color: this.state == 1?App.primary:App.red),)
                                    ],
                                  ),
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

}
