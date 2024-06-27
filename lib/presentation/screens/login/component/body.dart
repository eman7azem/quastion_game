import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quastions_game/constants/colors.dart';
import 'package:quastions_game/constants/navigator.dart';
import 'package:quastions_game/presentation/screens/forget_password/forget_password/forget_password.dart';
import 'package:quastions_game/presentation/screens/register/sign_up.dart';
import 'package:quastions_game/presentation/widgets/button.dart';
import 'package:animate_do/animate_do.dart';
import '../../../../bottom_bar/bottom_bar.dart';
import '../../../../data/api/api.dart';
import '../../../../data/models/login_model.dart';
import '../../../../notification/notification.dart';
import '../../../../router.dart';
import '../../../utilities/my_toast.dart';
import '../../../utilities/shared_pref.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final NotificationManager _notificationManager = NotificationManager();

  bool _showPassword = true;
  bool _inProgress = false;
  String? _email, _password;
  final API _api = API();

  @override
  void initState() {
    super.initState();
    _notificationManager.initialize();
    _notificationManager.setupFirebaseMessagingListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30.h),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100.h),
                FadeInUp(
                  duration: Duration(milliseconds: 1000),
                  child: Center(
                    child: Text(
                      'مرحبا بعودتك',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 26.sp,
                        fontFamily: 'Kohinoor Arabic',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 60.h),
                buildEmailFormField(),
                SizedBox(height: 20.h),
                buildPasswordFormField(),
                SizedBox(height: 60.h),
                buildLoginButton(),
                SizedBox(height: 20.h),
                buildForgetPasswordText(),
                SizedBox(height: 30.h),
                buildSignUpText(),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEmailFormField() {
    return FadeInUp(
      duration: Duration(milliseconds: 1400),
      child: TextFormField(
        onChanged: (value) => _email = value,
        decoration: InputDecoration(
          hintText: 'البريد الإلكتروني',
          hintStyle: TextStyle(
            color: const Color(0xFFA3A3A3),
            fontSize: 16.sp,
            fontFamily: 'Kohinoor Arabic',
            fontWeight: FontWeight.w600,
          ),
          filled: true,
          fillColor: const Color(0xFFEEEEEE),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
            borderRadius: BorderRadius.circular(30.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
            borderRadius: BorderRadius.circular(30.r),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(30.r),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
            borderRadius: BorderRadius.circular(30.r),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'أدخل البريد الإلكتروني';
          } else {
            bool isValidEmail =
                RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
                    .hasMatch(value);
            if (!isValidEmail) {
              return 'أدخل بريد إلكتروني صحيح';
            }
            return null;
          }
        },
      ),
    );
  }

  Widget buildPasswordFormField() {
    return FadeInUp(
      duration: Duration(milliseconds: 1600),
      child: TextFormField(
        obscureText: _showPassword,
        onChanged: (value) => _password = value,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(
              _showPassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: kPrimaryColor,
            ),
            onPressed: () {
              setState(() {
                _showPassword = !_showPassword;
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
            borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
            borderRadius: BorderRadius.circular(30.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
            borderRadius: BorderRadius.circular(30.r),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(30.r),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
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
    );
  }

  Widget buildLoginButton() {
    final Size size = MediaQuery.of(context).size;
    return FadeInUp(
      duration: Duration(milliseconds: 1800),
      child: GestureDetector(
        onTap: _inProgress ? null : login,
        child: Center(
          child: Button(
            width: size.width * 0.6,
            text: 'تسجيل الدخول',
            inProgress: _inProgress,
            colorPrimary: kPrimaryColor,
            colorDark: kPrimaryDark,
            colorProgress: Colors.white,
            fontSize: 20.sp,
          ),
        ),
      ),
    );
  }

  Widget buildForgetPasswordText() {
    return FadeInUp(
      duration: Duration(milliseconds: 2000),
      child: GestureDetector(
        onTap: () {
          navigateTo(context, const ForgetPassword());
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'نسيت كلمة المرور؟ ',
              style: TextStyle(
                color: const Color(0xFF242424),
                fontSize: 16.sp,
                fontFamily: 'Kohinoor Arabic',
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(
              Icons.arrow_right_alt_outlined,
              size: 40.r,
              color: kPrimaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSignUpText() {
    final Size size = MediaQuery.of(context).size;
    return FadeInUp(
      duration: Duration(milliseconds: 2000),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'ليس لديك حساب؟ ',
            style: TextStyle(
              color: const Color(0xFF414141),
              fontSize: 16.sp,
              fontFamily: 'Kohinoor Arabic',
              fontWeight: FontWeight.w500,
            ),
          ),
          GestureDetector(
            onTap: () {
              navigateTo(context, const SignUp());
            },
            child: Text(
              'أنشئ حسابا',
              style: TextStyle(
                color: scundryColor,
                fontSize: 15.sp,
                fontFamily: 'Kohinoor Arabic',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void login() async {
    setState(() {
      _inProgress = true;
    });

    if (_formKey.currentState!.validate()) {
      String? deviceToken = await FirebaseMessaging.instance.getToken();
      if (deviceToken == null) {
        throw Exception('Failed to get FCM token');
      }
      print('deviceToken  $deviceToken');
      LoginResponse? response = await _api.login(
          email: _email!, password: _password!, deviceToken: deviceToken);

      if (response != null) {
        if (response.success) {
          showToast(response.message);
          String token = response.data.token;
          print('Token: $token');
          await saveData('token', str: token);
          if (context.mounted) {
            MyRouter router = MyRouter(context: context, api: _api);
            router.route();
          }
        } else {
          showToast(response.message, error: true);
        }
      } else {
        showToast('خطأ في الاتصال بالإنترنت', error: true);
      }
    }

    setState(() {
      _inProgress = false;
    });
  }
}
