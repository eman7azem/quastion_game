import 'package:flutter/material.dart';
import 'package:quastions_game/presentation/screens/home/component/app_bar_home.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quastions_game/presentation/screens/home/component/categories.dart';

import '../../../../constants/colors.dart';
import '../../../widgets/app_bar.dart';

class Body extends StatelessWidget {
  const Body({Key? key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarHome(),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  'اختر الفئات',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontFamily: 'Kohinoor Arabic',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Categories(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
