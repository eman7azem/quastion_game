import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/colors.dart';

class Phone extends StatefulWidget {
  Phone({this.onChanged});

  final void Function(PhoneNumber)? onChanged;

  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  bool isPhoneNumberValid = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: IntlPhoneField(
          // showDropdownIcon: true,
          dropdownIconPosition: IconPosition.trailing,
          dropdownIcon: Icon(
            Icons.arrow_drop_down,
            color: kPrimaryColor,
            size: 40,
          ),
          initialCountryCode: 'EG',
          // languageCode: 'ar',
          // textAlign: TextAlign.start,
          flagsButtonMargin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
          disableLengthCheck: false,
          decoration: InputDecoration(
            hintText: 'رقم الهاتف',
            hintStyle: TextStyle(
              color: Color(0xFFA3A3A3),
              fontSize: 16.sp,
              fontFamily: 'Kohinoor Arabic',
              fontWeight: FontWeight.w600,
            ),
            border: InputBorder.none,
            filled: true,
            fillColor: Color(0xFFEEEEEE),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFEEEEEE),
              ),
              borderRadius: BorderRadius.circular(30.r),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
              borderRadius: BorderRadius.circular(30.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFEEEEEE),
              ),
              borderRadius: BorderRadius.circular(30.r),
            ),
          ),

          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
