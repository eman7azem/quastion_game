import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;

  // final String? hintText;
  final Function(String)? onChanged;

  const CustomTextField({
    Key? key,
    required this.controller,
    // this.hintText,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFEEEEEE),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide: BorderSide(color: Color(0xABC5C5C5), width: 2)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide: BorderSide(color: Color(0xABC5C5C5), width: 2)
// No border
            ),
        // hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey.shade700,
          fontSize: 18.sp,
          fontFamily: 'Neo Sans W23',
          fontWeight: FontWeight.w400,
        ),
      ),
      onChanged: onChanged,
    );
  }
}
