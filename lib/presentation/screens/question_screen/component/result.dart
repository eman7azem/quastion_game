import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quastions_game/constants/navigator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constants/colors.dart';
import '../../../widgets/button.dart';
import '../../spin/spin.dart';
import '../../wallet/wallet_screen.dart';

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  double currentValue = 0.0; // Track slider value
  bool progress = false;
  StreamController<int> controller = StreamController<int>();

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          height: size.height * 0.9,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                child: Image.asset(
                  'assets/images/bg1.png',
                  height: size.height * 0.3,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: size.height * 0.08,
                left: size.width * 0.05,
                child: Container(
                  height: size.height * 0.8,
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                    border: Border.all(color: Colors.transparent),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * 0.1,
                      ),
                      SpinScreen(),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      // Container(
                      //   width: double.infinity,
                      //   padding: EdgeInsets.symmetric(
                      //       vertical: 20.h, horizontal: 15.w),
                      //   margin: EdgeInsets.symmetric(
                      //       vertical: 20.h, horizontal: 15.w),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(15.r),
                      //     color: Colors.white,
                      //     boxShadow: [
                      //       BoxShadow(
                      //         color: Colors.grey.withOpacity(0.3),
                      //         spreadRadius: 5,
                      //         blurRadius: 4,
                      //         offset: Offset(0, 2),
                      //       ),
                      //     ],
                      //   ),
                      //   child: Text(
                      //     'لقد حصلت على 100 نقطة',
                      //     style: TextStyle(
                      //       color: Colors.black,
                      //       fontSize: 16.sp,
                      //       fontFamily: 'Kohinoor Arabic',
                      //       fontWeight: FontWeight.w600,
                      //     ),
                      //   ),
                      // ),
                      Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                navigateTo(context, WalletScreen());
                              },
                              child: Button(
                                width: size.width * 0.6,
                                text: 'الذهاب إلى المحفظه',
                                inProgress: progress,
                                colorPrimary: kPrimaryColor,
                                colorDark: kPrimaryDark,
                                colorProgress: kPrimaryColor,
                                fontSize: 20.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.1,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
