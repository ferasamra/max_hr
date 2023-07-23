import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:max_hr/helper/api.dart';
import 'package:max_hr/helper/global.dart';
import 'package:max_hr/model/discount_rewards.dart';
import 'package:max_hr/model/lateness.dart';

class DiscountRewardController extends GetxController{

  RxBool loading = false.obs;
  List<DiscountReward> discountRewardList = <DiscountReward>[];
  ScrollController scrollController = ScrollController();
  initPage(int state)async{
    loading(true);
    await Api.hasInternet();
    discountRewardList = await Api.getDiscountRewards(state);
    loading(false);
    await Future.delayed(Duration(milliseconds: 100));
    scrollController.animateTo(scrollController.position.maxScrollExtent,  curve: Curves.easeOut,
      duration: const Duration(milliseconds: 800),);
  }

}