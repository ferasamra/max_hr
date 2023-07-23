import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max_hr/app_localization.dart';
import 'package:max_hr/helper/app.dart';

class MyTextField extends StatefulWidget {
  final double width;
  final double height;
  final TextEditingController controller;
  final RxBool validate;
  final String label;
  final void Function(String) onChanged;
  final TextInputType keyboardType;
  final bool isPassword;
  final String? errText;
  final RxBool? hidden ;
  final Widget? prefix;


  MyTextField({
    required this.width,
    required this.height,
    required this.controller,
    required this.validate,
    required this.label,
    required this.onChanged,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.errText = null,
    this.prefix = null,
    this.hidden
  });
  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: App.grey1,
            borderRadius: BorderRadius.circular(5)
          ),
          child: Obx(() => TextField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            onChanged: widget.onChanged,
            obscureText: widget.isPassword?widget.hidden!.value:false,
            style: widget.isPassword?TextStyle(color: App.grey1,fontSize: 12):TextStyle(color: App.grey1,fontSize: 12,height: 1),
            decoration: InputDecoration(
              suffix: widget.isPassword?IconButton(onPressed: (){
                widget.hidden!(!widget.hidden!.value);
                print(widget.hidden!.value);
              },icon: Icon(widget.hidden!.value?Icons.visibility_off_outlined:Icons.visibility_outlined,color: App.grey1,),):null,
              prefixIcon: widget.prefix,
              enabledBorder: widget.validate.value
                  ?OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(5)
              )
                  :OutlineInputBorder(
                  borderSide: BorderSide(color: App.grey1),
                  borderRadius: BorderRadius.circular(5)
              ),

              focusedBorder:  widget.validate.value
                  ?OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(5)
              )
                  :OutlineInputBorder(
                  borderSide: BorderSide(color: App.primary),
                  borderRadius: BorderRadius.circular(5),
              ),
              label: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: Text(App_Localization.of(context).translate(widget.label),style: TextStyle(color: App.grey1),),
              ),
              labelStyle: TextStyle(color: App.grey1),
            ),
          )),
        ),
        widget.errText!=null?
            Container(
              width: widget.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      SizedBox(width: 15,),
                      Text(App_Localization.of(context).translate(widget.errText!),style: TextStyle(color: Colors.red,fontSize: 12),)
                    ],
                  )
                ],
              ),
            )
            :Center()
      ],
    );
  }
}
