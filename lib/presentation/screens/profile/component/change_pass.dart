import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quastions_game/bottom_bar/bottom_bar.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/navigator.dart';
import '../../../../data/api/api.dart';
import '../../../utilities/my_toast.dart';
import '../../../widgets/button.dart';
import '../profile.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChangePass extends StatefulWidget {
  ChangePass({Key? key}) : super(key: key);

  @override
  State<ChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  bool progress = false;
  bool showPass = true;
  bool showNewPass = true;
  bool showConPass = true;
  final _api = API();

  final _formKey = GlobalKey<FormState>();
  String? currantPassword, newPassword, passwordConfirmation;

  final FocusNode _currentPassFocus = FocusNode();
  final FocusNode _newPassFocus = FocusNode();
  final FocusNode _confirmPassFocus = FocusNode();

  @override
  void dispose() {
    _currentPassFocus.dispose();
    _newPassFocus.dispose();
    _confirmPassFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Material(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/bg1.png',
              height: size.height * 0.9,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: size.height * 0.24,
              child: SingleChildScrollView(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.04),
                    height: size.height * 0.68,
                    width: size.width,
                    color: Colors.white,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: size.height * 0.07),
                          Text(
                            '  تغيير كلمة السر',
                            style: TextStyle(
                              color: kPrimaryDark,
                              fontSize: size.width * 0.047,
                              fontFamily: 'Kohinoor Arabic',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: size.height * 0.04),
                          TextFormField(
                            obscureText: showPass,
                            focusNode: _currentPassFocus,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_newPassFocus);
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
                              hintText: 'كلمة السر الحالية',
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
                              currantPassword = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'أدخل كلمة السر الحالية';
                              }
                            },
                          ),
                          SizedBox(height: size.height * 0.013),
                          TextFormField(
                            obscureText: showNewPass,
                            focusNode: _newPassFocus,
                            onChanged: (value) {
                              newPassword = value;
                            },
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_confirmPassFocus);
                            },
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  showNewPass
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: kPrimaryColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    showNewPass = !showNewPass;
                                  });
                                },
                              ),
                              hintText: ' كلمة السر الجديدة',
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'أدخل كلمة السر الجديدة';
                              }
                            },
                          ),
                          SizedBox(height: size.height * 0.013),
                          TextFormField(
                            obscureText: showConPass,
                            focusNode: _confirmPassFocus,
                            onChanged: (value) {
                              passwordConfirmation = value;
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
                              hintText: ' إعادة كتابة كلمة السر الجديدة',
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'إعادة كتابة كلمة السر الجديدة';
                              }
                            },
                          ),
                          SizedBox(height: size.height * 0.07),
                          Center(
                            child: GestureDetector(
                              onTap: () => changePassword(),
                              child: Button(
                                width: size.width * 0.6,
                                text: ' حفظ التغييرات',
                                inProgress: progress,
                                colorPrimary: kPrimaryColor,
                                colorDark: kPrimaryDark,
                                colorProgress: Colors.white,
                                fontSize: 20.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void changePassword() async {
    setState(() {
      progress = true;
    });
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic>? response = await _api.changePassword(
        currentPassword: currantPassword!,
        newPassword: newPassword!,
        confirmPassword: passwordConfirmation!,
      );
      if (response != null) {
        if (response['success'] == true) {
          showToast(response['message']);
          navigateTo(
            context,
            BottomNavBar(page: 0),
          );
        } else {
          if (response['message'] != null) {
            if (response['message']['current_password'] != null) {
              showToast(response['message']['current_password'][0],
                  error: true);
            } else if (response['message']['confrim_password'] != null) {
              showToast(response['message']['confrim_password'][0],
                  error: true);
            } else if (response['message'] is String) {
              showToast(response['message'], error: true);
            } else {
              showToast("حدث خطأ ما", error: true);
            }
          } else {
            showToast("حدث خطأ ما", error: true);
          }
        }
      } else {
        if (context.mounted) showToast("خطأ في الاتصال بالإنترنت", error: true);
      }
    }
    setState(() {
      progress = false;
    });
  }
}
