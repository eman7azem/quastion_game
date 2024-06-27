import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'progress.dart';

class Button extends StatelessWidget {
  final String text;
  final bool inProgress;
  final Color colorPrimary;
  final Color colorDark;
  final Color colorProgress;
  final double width;
  final double fontSize;

  const Button(
      {super.key,
      required this.text,
      this.inProgress = false,
      required this.colorPrimary,
      required this.colorDark,
      required this.colorProgress,
      required this.width, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: width,
      height: 70.h,
      decoration: ShapeDecoration(
        color: inProgress ? colorDark : colorPrimary,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
      ),
      child: Center(
        child:
            inProgress ? CircularProgressIndicator(color: colorProgress,) :
            Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontFamily: 'Kohinoor Arabic',
            fontWeight: FontWeight.w600,
            height: 0.08,
          ),
        ),
      ),
    );
  }
}
