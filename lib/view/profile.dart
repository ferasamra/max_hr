import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:max_hr/app_localization.dart';
import 'package:max_hr/contoller/profile_controller.dart';
import 'package:max_hr/helper/api.dart';
import 'package:max_hr/helper/app.dart';
import 'package:max_hr/helper/global.dart';
import 'package:max_hr/helper/store.dart';
import 'package:max_hr/view/change_password.dart';
import 'package:max_hr/view/login.dart';
import 'package:max_hr/view/personal_info.dart';
import 'package:max_hr/widgets/header.dart';

class Profile extends StatelessWidget {
  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => Stack(
        children: [
          SafeArea(
            child: Container(

              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: Get.width,
                      // height: Get.width * 0.6,
                      decoration: BoxDecoration(
                          color: App.bgGrey,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 25,
                                spreadRadius: 2,
                                offset: const Offset(0, 3)
                            )
                          ]
                      ),

                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                              // width: Get.width * 0.6,
                              // height: Get.width * 0.6,
                              // color: Colors.red,
                              child: Column(
                                children: [
                                  const SizedBox(height: 20,),
                                  Stack(
                                    children: [
                                      Container(
                                        width: Get.width * 0.35,
                                        height: Get.width * 0.35,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(color: Colors.grey,),
                                            image: Global.employee!.image.isEmpty?null:DecorationImage(image: NetworkImage(Api.media_url+Global.employee!.image,),fit: BoxFit.contain)
                                        ),
                                        child: Global.employee!.image.isEmpty?Icon(Icons.person,size: Get.width * 0.35 -20 ,color: App.grey2 ,):null,
                                      ),
                                      Positioned(
                                          bottom: 5,
                                          left: Get.width * 0.35 / 2 - 14,
                                          child: GestureDetector(
                                            onTap: (){
                                              profileController.showImagePicker(true);
                                            },
                                            child:const CircleAvatar(
                                              radius: 14,
                                              backgroundColor: Colors.white,
                                              child: Icon(Icons.edit,color: App.primary,size: 18,),
                                            ),
                                          ))
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  Text(Global.employee!.name,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                  const SizedBox(height: 20,),
                                ],
                              ),
                            ),
                          ),
                          const Positioned(
                            right: 10,
                            top: 20,
                            child: Icon(Icons.notifications_none,color: Colors.black,),)
                        ],
                      ),
                    ),
                    const SizedBox(height: 30,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Get.to(()=>const PersonalInfo());
                                },
                                child: profileCard(
                                    context,
                                    "personal_info",const Icon(Icons.person,color: App.primary,size: 32,),
                                    Global.employee!.email
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  profileController.changeLanguage(context);
                                },
                                child: profileCard(
                                    context,
                                    "language",SvgPicture.asset("assets/icons/language.svg",height: 28,width: 28,),
                                    Global.locale == "en"?"English":"العربية"
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Get.to(()=>ChangePassword());
                                },
                                child: profileCard(
                                    context,
                                    "change_password",SvgPicture.asset("assets/icons/change_password.svg",height: 28,width: 28,),
                                    "*****************"
                                ),
                              ),
                              // GestureDetector(
                              //   onTap: (){
                              //     profileController.changeLanguage(context);
                              //   },
                              //   child: profileCard(
                              //       context,
                              //       "language",SvgPicture.asset("assets/icons/language.svg",height: 28,width: 28,),
                              //       Global.locale == "en"?"English":"العربية"
                              //   ),
                              // ),
                            ],
                          ),
                          const SizedBox(height: 20,),
                          GestureDetector(
                            onTap: (){
                              Store.logout();
                              Get.offAll(()=>Login());
                            },
                            child: Container(
                              width: Get.width,
                              height: 50,
                              decoration: BoxDecoration(
                                color: App.primary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(App_Localization.of(context).translate("sign_out"),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                              ),
                            ),
                          )
                        ],
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),
          profileController.showImagePicker.value?
          GestureDetector(
            onTap: (){
              profileController.showImagePicker(false);
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
                          profileController.pickCamera(context);
                        },
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: App.primary
                          ),
                          child: const Icon(Icons.camera,color: Colors.white,size: 55),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          profileController.pickGallery(context);
                        },
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: App.primary
                          ),
                          child: const Icon(Icons.photo,color: Colors.white,size: 55),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ):const Center(),
          profileController.loading.value?
          Container(
            width: Get.width,
            height: Get.height,
            color: Colors.grey.withOpacity(0.6),
            child: Center(
              child: App.loading(context),
            ),
          ):const Center()
        ],
      )),
    );
  }

  profileCard(BuildContext context,String title,Widget icon,String subTitle){
    return Container(
      width: Get.width * 0.5 - 20,
      height: (Get.width * 0.5 - 20) * 80 / 100,
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(App_Localization.of(context).translate(title),style: const TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
          const SizedBox(height: 10,),
          Expanded(child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: App.bgGrey,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(Icons.edit,size: 15,color: App.grey2,),
                  ],
                ),
                icon,
                Text(subTitle,style: const TextStyle(fontSize: 11,color: App.grey2,),maxLines: 1,)
              ],
            ),
          ))
        ],
      ),
    );
  }
}
