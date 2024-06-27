import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:quastions_game/constants/colors.dart';
import 'package:quastions_game/constants/navigator.dart';
import 'package:quastions_game/presentation/screens/forget_password/new_password/new_password.dart';
import 'package:quastions_game/presentation/widgets/button.dart';
import 'package:quastions_game/presentation/widgets/custom_form_field.dart';

import '../../../../../data/api/api.dart';
import '../../../../utilities/my_toast.dart';

class Body extends StatefulWidget {
  const Body({super.key, required this.email});

  final String email;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool progress = false;
  final _api = API();

  final _formKey = GlobalKey<FormState>();

  final defaultPinTheme = PinTheme(
    margin: EdgeInsets.only(
      bottom: 15.h,
    ),
    width: 57.w,
    height: 57.h,
    textStyle: TextStyle(
        fontSize: 20.sp, color: kPrimaryColor, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: Colors.black.withOpacity(0.2),
      ),
      borderRadius: BorderRadius.circular(10.r),
    ),
  );

  String? otp;

  int _secondsRemaining = 60;

  late Timer _timer;

  //
  @override
  void initState() {
    super.initState();
    messageTimer();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'نسيت كلمة المرور',
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 30.sp,
                fontFamily: 'Kohinoor Arabic',
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Text(
              'أدخل الكود المكون من 4 أرقام',
              style: TextStyle(
                color: Colors.black.withOpacity(0.5),
                fontSize: 14.sp,
                fontFamily: 'Kohinoor Arabic',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Pinput(
                length: 4,
                defaultPinTheme: defaultPinTheme,
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onChanged: (pin) {
                  otp = pin;
                },
              ),
            ),
            SizedBox(height: 10.h),
            Center(
              child: CustomFormField(
                validator: (value) {
                  if (otp == null || otp!.length < 4) {
                    return 'من فضلك ادخل الكود ';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 26.h,
            ),
            GestureDetector(
              onTap: () => checkOtp(),
              child: Button(
                width: size.width * 0.6,
                inProgress: progress,
                text: 'إرسال',
                colorPrimary: kPrimaryColor,
                colorDark: kPrimaryDark,
                colorProgress: Colors.white,
                fontSize: 20.sp,
              ),
            ),
            SizedBox(
              height: 34.h,
            ),
            if (_secondsRemaining == 0)
              //Can Send Again
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'لم يتم ارسال الكود الى البريد الالكتروني  ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontFamily: 'Kohinoor Arabic',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  InkWell(
                    onTap: () => resend(),
                    child: Text(
                      'أرسل مجددا',
                      style: TextStyle(
                        color: scundryColor,
                        fontSize: 14.sp,
                        fontFamily: 'Kohinoor Arabic',
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              )
            else
              Text(
                'إعادة الإرسال مرة أخرى $_secondsRemaining ثانية ',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15.sp,
                  fontFamily: 'Kohinoor Arabic',
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void messageTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  void checkOtp() async {
    setState(() {
      progress = true;
    });
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic>? response =
          await _api.checkOtp(email: widget.email, otp: otp!);
      if (response != null) {
        if (response['success'] == true) {
          showToast(response['message']);
          navigateWithoutHistory(
              context,
              NewPassword(
              ));
        }
        else {
          showToast(response['message'], error: true);
        }
      }
      else {
        showToast(' خطأ في الاتصال بالإنترنت', error: true);
      }
    }
    setState(() {
      progress = false;
    });
  }

  void resend() async {
    setState(() {
      _secondsRemaining = 60;
    });
    messageTimer();
    Map<String, dynamic>? response =
        await _api.forgetPassword(email: widget.email);
    if (response != null) {
      if (response['status'] == true) {
        showToast(response['message']);
      } else {
        showToast(response['message'], error: true);
      }
    } else {
      showToast(' خطأ في الاتصال بالإنترنت', error: true);
    }
  }
}
