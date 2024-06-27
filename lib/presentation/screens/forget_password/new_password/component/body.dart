import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quastions_game/constants/colors.dart';
import 'package:quastions_game/constants/navigator.dart';
import 'package:quastions_game/presentation/screens/login/signin.dart';
import 'package:quastions_game/presentation/widgets/button.dart';

import '../../../../../data/api/api.dart';
import '../../../../utilities/my_toast.dart';

class Body extends StatefulWidget {
  const Body({
    super.key,
  });

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool progress = false;
  final _formKey = GlobalKey<FormState>();
  final _api = API();
  String? password, confirmPassword;
  bool showPass = true;
  bool showConPass = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 270.h,
              ),
              Text(
                'إعادة ضبط كلمة المرور',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 30.sp,
                  fontFamily: 'Kohinoor Arabic',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 40.h,
              ),

              TextFormField(
                  obscureText: showPass,

                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        showPass
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: kPrimaryColor,
                      ),
                      onPressed: () {
                        setState(() {
                          showPass = !showPass;
                        });
                      },
                    ),

                    hintText: 'كلمة المرور الجديدة',
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
                        color: Colors.red,
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
                    password = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'أدخل كلمة المرور الجديدة';

                      return null;
                    }
                  }),
              SizedBox(
                height: 15.h,
              ),
              TextFormField(
                  obscureText: showConPass,

                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        showConPass
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: kPrimaryColor,
                      ),
                      onPressed: () {
                        setState(() {
                          showConPass = !showConPass;
                        });
                      },
                    ),

                    hintText: 'أعد كتابة كلمة المرور الجديدة',
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
                        color: Colors.red,
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
                    confirmPassword = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'أعد كتابة كلمة المرور الجديدة';
                    }
                  }),
              SizedBox(
                height: 40.h,
              ),
              GestureDetector(
                onTap: () => resetPassword(),
                child: Button(
                  text: 'إرسال',
                  width: size.width * 0.6,
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


  void resetPassword() async {
    setState(() {
      progress = true;
    });

    if (_formKey.currentState!.validate()) {
      Map<String, dynamic>? response = await _api.resetPassword(
        password: password!,
        passwordConfirm: confirmPassword!,
      );

      if (response != null) {
        if (response['success'] == true) {
          showToast(response['message']);
          navigateWithoutHistory(context, Login());
        } else {
          showToast(response['message'], error: true);
        }
      } else {
        showToast('خطأ في الاتصال بالإنترنت', error: true);
      }
    }

    setState(() {
      progress = false;
    });
  }
}
