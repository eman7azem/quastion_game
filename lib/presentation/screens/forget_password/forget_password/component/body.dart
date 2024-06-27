import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quastions_game/constants/colors.dart';
import 'package:quastions_game/constants/navigator.dart';
import 'package:quastions_game/presentation/screens/forget_password/new_password/new_password.dart';
import 'package:quastions_game/presentation/screens/forget_password/otp/otp.dart';
import 'package:quastions_game/presentation/widgets/button.dart';

import '../../../../../data/api/api.dart';
import '../../../../utilities/my_toast.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool progress = false;
  final _formKey = GlobalKey<FormState>();
  final _api = API();
  String? email;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 250.h,),
              Text(
                'نسيت كلمة المرور',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 28.sp,
                  fontFamily: 'Kohinoor Arabic',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  'أدخل البريد الإلكتروني الخاص بك وسنرسل لك رمز التحقق لإعادة تعيين كلمة المرور الخاصة بك',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF8D8D8D),
                    fontSize: 14.sp,
                    fontFamily: 'Kohinoor Arabic',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              TextFormField(
                  decoration: InputDecoration(
                    hintText: 'البريد الإلكتروني',
                    hintStyle: TextStyle(
                      color: const Color(0xFF999999),
                      fontSize: 16.sp,
                      fontFamily: 'Kohinoor Arabic',
                      fontWeight: FontWeight.w600,
                    ),
                    filled: true,
                    fillColor: const Color(0xFFEEEEEE),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFFEEEEEE),
                      ),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFFEEEEEE),
                      ),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFFEEEEEE),
                      ),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFFEEEEEE),
                      ),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  onChanged: (value) {
                    email = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'أدخل البريد الإلكتروني';
                    } else {
                      bool isValidEmail = RegExp(
                              r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
                          .hasMatch(value);

                      if (!isValidEmail) {
                        return 'أدخل البريد الإلكتروني';
                      }
                      return null;
                    }
                  }),
              SizedBox(
                height: 60.h,
              ),
              GestureDetector(
                onTap: () => forgetPassword(),

                child: Button(
                  width: size.width*0.6,
                  text: 'إرسال',
                  inProgress: progress,
                  colorPrimary: kPrimaryColor,
                  colorDark: kPrimaryDark,
                  colorProgress: Colors.white,
                  fontSize: 20.sp,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  void forgetPassword() async {
    setState(() {
      progress = true;
    });
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic>? response = await _api.forgetPassword(
          email: email!);
      if (response != null) {
        if (response['success'] == true) {
          showToast(response['message']);
          navigateTo(context, Otp(email: email!,));
        } else {
          showToast(response['message'], error: true);
        }
      } else {
        showToast("خطأ في الاتصال بالإنترنت", error: true);
      }
    }
    setState(() {
      progress = false;
    });
  }

}
