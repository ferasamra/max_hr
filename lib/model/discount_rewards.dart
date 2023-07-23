// To parse this JSON data, do
//
//     final discountRewardsDecoder = discountRewardsDecoderFromJson(jsonString);

import 'dart:convert';

DiscountRewardsDecoder discountRewardsDecoderFromJson(String str) => DiscountRewardsDecoder.fromJson(json.decode(str));

String discountRewardsDecoderToJson(DiscountRewardsDecoder data) => json.encode(data.toJson());

class DiscountRewardsDecoder {
  List<DiscountReward> discountRewards;

  DiscountRewardsDecoder({
    required this.discountRewards,
  });

  factory DiscountRewardsDecoder.fromJson(Map<String, dynamic> json) => DiscountRewardsDecoder(
    discountRewards: List<DiscountReward>.from(json["discount_rewards"].map((x) => DiscountReward.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "discount_rewards": List<dynamic>.from(discountRewards.map((x) => x.toJson())),
  };
}

class DiscountReward {
  int drId;
  int eId;
  String note;
  int amount;
  int state;
  DateTime date;

  DiscountReward({
    required this.drId,
    required this.eId,
    required this.note,
    required this.amount,
    required this.state,
    required this.date,
  });

  factory DiscountReward.fromJson(Map<String, dynamic> json) => DiscountReward(
    drId: json["dr_id"],
    eId: json["e_id"],
    note: json["note"],
    amount: json["amount"],
    state: json["state"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "dr_id": drId,
    "e_id": eId,
    "note": note,
    "amount": amount,
    "state": state,
    "date": date.toIso8601String(),
  };
}
