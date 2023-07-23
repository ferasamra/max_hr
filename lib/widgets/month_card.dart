import 'package:flutter/material.dart';
import 'package:max_hr/helper/app.dart';

class MonthCard extends StatefulWidget {

  final VoidCallback onPressed;
  final Color color;
  final String text;

  MonthCard({
    required this.onPressed,required this.color,required this.text
});

  @override
  State<MonthCard> createState() => _MonthCardState();
}

class _MonthCardState extends State<MonthCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        width: 100,
        height: 32,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: widget.color),
        ),
        child: Center(
          child: Text(widget.text,style: TextStyle(color: widget.color,fontSize: 14,fontWeight: FontWeight.w500),),
        ),
      ),
    );
  }
}

