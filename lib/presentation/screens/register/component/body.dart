import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../bottom_bar/bottom_bar.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/navigator.dart';
import '../../../../data/api/api.dart';
import '../../../utilities/my_toast.dart';
import '../../../utilities/shared_pref.dart';
import '../../../widgets/button.dart';
import '../../../widgets/custom_form_field.dart';
import '../../../widgets/phone.dart';
import '../../login/signin.dart';
import 'package:animate_do/animate_do.dart';

class Body extends StatefulWidget {
  Body({Key? key,});


  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  String? name, nickName, email, phoneNumber, password, conPassword;
  bool showPass = true;
  bool showConPass = true;
  bool isChecked = false;
  bool progress = false;
  final _formKey = GlobalKey<FormState>();
  final focus = FocusNode();
  TextEditingController _controller = TextEditingController();
  late AnimationController _animationController;
  final _api = API();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100.h,
              ),
              FadeInUp(
                duration: Duration(milliseconds: 1000),
                child: Center(
                  child: Text(
                    'سجل حساباً',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 30.sp,
                      fontFamily: 'Kohinoor Arabic',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              FadeInUp(
                duration: Duration(milliseconds: 1600),
                child: TextFormField(
                  onChanged: (newValue) {
                    name = newValue;
                  },
                  // Set text color to grey
                  decoration: InputDecoration(
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 22.h, horizontal: 15.w),
                    hintText: 'الإسم ',
                    hintStyle: TextStyle(
                      color: const Color(0xFF999999),
                      fontSize: 16.sp,
                      fontFamily: 'Kohinoor Arabic',
                      fontWeight: FontWeight.w600,
                    ),
                    filled: true,
                    // Fill the background
                    fillColor: const Color(0xFFEEEEEE),
                    // Set label color to grey
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red,
                      ),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    enabledBorder: OutlineInputBorder(
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
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFFEEEEEE),
                      ),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'أدخل الإسم الأول';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              FadeInUp(
                duration: Duration(milliseconds: 1700),
                child: TextFormField(
                  onChanged: (newValue) {
                    nickName = newValue;
                  },
                  // Set text color to grey
                  decoration: InputDecoration(
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 22.h, horizontal: 15.w),
                    hintText: 'اسم المستخدم',
                    hintStyle: TextStyle(
                      color: const Color(0xFF999999),
                      fontSize: 16.sp,
                      fontFamily: 'Kohinoor Arabic',
                      fontWeight: FontWeight.w600,
                    ),
                    filled: true,
                    // Fill the background
                    fillColor: const Color(0xFFEEEEEE),
                    // Set label color to grey
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red,
                      ),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    enabledBorder: OutlineInputBorder(
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
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFFEEEEEE),
                      ),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'أدخل اسم المستخدم';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              FadeInUp(
                duration: Duration(milliseconds: 1800),
                child: Phone(
                  onChanged: (phone) {
                    phoneNumber = phone.countryCode + phone.number;
                    print('pppppppp${phoneNumber}');
                  },
                ),
              ),
              FadeInUp(
                duration: Duration(milliseconds: 2000),
                child: CustomFormField(
                  validator: (value) {
                    if (phoneNumber == null) {
                      return 'أدخل رقم الهاتف';
                    }
                    return null;
                  },
                ),
              ),
              // Wrap TextFormField with FadeInUp for other form fields as well
              FadeInUp(
                duration: Duration(milliseconds: 2200),
                child: TextFormField(
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
                        return 'أدخل بريد إلكتروني صحيح';
                      }
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              FadeInUp(
                duration: Duration(milliseconds: 2400),
                child: TextFormField(
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  controller: _controller,
                  cursorColor: kPrimaryColor,
                  obscureText: showPass,
                  onChanged: (value) {
                    password = value;
                  },
                  onTap: () {
                    if (_controller.selection ==
                        TextSelection.fromPosition(
                            TextPosition(offset: _controller.text.length)));
                  },
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
                    hintText: 'كلمة السر',
                    hintStyle: TextStyle(
                      color: const Color(0xFFA3A3A3),
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'أدخل كلمة السر';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              FadeInUp(
                duration: Duration(milliseconds: 2600),
                child: TextFormField(
                  obscureText: showConPass,
                  onChanged: (value) {
                    conPassword = value;
                  },
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
                    hintText: 'أعد كتابة كلمة السر',
                    hintStyle: TextStyle(
                      color: const Color(0xFFA3A3A3),
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
                        // Set focused border color here
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
                        color:
                        Colors.red, // Set focused error border color here
                      ),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'أعد كتابة كلمة السر';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              FadeInUp(
                duration: Duration(milliseconds: 3000),
                child: GestureDetector(
                  onTap: () => register(),
                  child: Center(
                    child: Button(
                      width: size.width * 0.6,
                      text: 'تسجيل',
                      inProgress: progress,
                      colorPrimary: kPrimaryColor,
                      colorDark: kPrimaryDark,
                      colorProgress: Colors.white,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              FadeInUp(
                duration: Duration(milliseconds: 3000),
                child: Row(
                  children: [
                    Text(
                      'لديك حساب بالفعل؟ ',
                      style: TextStyle(
                        color: const Color(0xFF414141),
                        fontSize: 16.sp,
                        fontFamily: 'Kohinoor Arabic',
                        fontWeight: FontWeight.w500,
                        height: 0.10,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        navigateTo(context,  Login());
                      },
                      child: Text(
                        'سجل الدخول',
                        style: TextStyle(
                          color: scundryColor,
                          fontSize: 17.sp,
                          fontFamily: 'Kohinoor Arabic',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void register() async {
    setState(() {
      progress = true;
    });
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic>? response = await _api.register(
          name: name!,
          nickName: nickName!,
          email: email!,
          phone: phoneNumber!,
          password: password!,
          conPassword: conPassword!
      );
      if (response != null) {
        if (response['success'] == true) {
          if (response['message'] != null) {
            showToast(response['message']);
          }
          if (response['token'] != null) {
            String token = response['token'];
            await saveData('token', str: token);
          }
          navigateWithoutHistory(context, BottomNavBar());

        } else {
          if (response['message'] != null) {
            showToast(response['message'], error: true);
          }
        }
      } else {
        showToast("خطأ في الاتصال بالإنترنت", error: true);
      }
    }
    setState(() {
      progress = false;
    });
  }}
