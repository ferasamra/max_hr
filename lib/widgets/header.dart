import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max_hr/app_localization.dart';
import 'package:max_hr/helper/api.dart';
import 'package:max_hr/helper/global.dart';
import 'package:max_hr/view/notification.dart';
import 'package:max_hr/view/tickets_replay.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Row(
        children: [
          SizedBox(width: 15,),
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey,),
                image: Global.employee!.image.isEmpty?null:DecorationImage(image: NetworkImage(Api.media_url+Global.employee!.image,),fit: BoxFit.contain)
            ),
            child: Global.employee!.image.isEmpty?Icon(Icons.person):null,
          ),
          SizedBox(width: 10,),
          Text(Global.employee!.name,style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
          Spacer(),
          // GestureDetector(
          //   onTap: (){
          //     Get.to(()=>TicketsReplay(5));
          //   },
          //   child: Icon(Icons.chat_outlined,color: Colors.black,),
          // ),
          // SizedBox(width: 10,),
          GestureDetector(
            onTap: (){
              Get.to(()=>MyNotification());
            },
            child: Icon(Icons.notifications_none,color: Colors.black,),
          ),
          SizedBox(width: 20,),
        ],
      ),
    );
  }
}
