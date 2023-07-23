import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max_hr/contoller/intro_controller.dart';
import 'package:max_hr/widgets/logo.dart';

class Intro extends StatelessWidget {

  IntroController introController = Get.put(IntroController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/background.png"),fit: BoxFit.cover)
        ),
        child: Center(
          child: Logo(150),
        ),
      ),
    );
  }
}
