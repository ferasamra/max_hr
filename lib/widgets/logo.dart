import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Logo extends StatelessWidget {
  final double size;

  Logo(this.size);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/logo.png"),fit: BoxFit.cover)
      ),
    );
  }
}
