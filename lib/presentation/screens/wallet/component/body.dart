import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constants/colors.dart';
import '../../../../data/api/api.dart';
import '../../../../data/models/total_point.dart';
import '../../../widgets/button.dart';
import 'bottom_sheet_withdraw.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  double currentValue = 0.0;
  bool progress = false;

  final _api = API();

  void _showWithdrawBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30))),
      builder: (context) {
        return BottomSheetWithdraw();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<List<TotalPointsData>>(
        future: _api.getTotalPointsData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            print('Error: ${snapshot.error}');

            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final totalPointsDataList = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
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
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.12),
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                '1000.00 \$',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 0.09,
                                  fontFamily: 'Kohinoor Arabic',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Text(
                                'الرصيد المتوفر',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 0.05,
                                  fontFamily: 'Kohinoor Arabic',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height * 0.03),
                        GestureDetector(
                          onTap: () {
                            _showWithdrawBottomSheet();
                          },
                          child: Center(
                            child: Button(
                              width: size.width * 0.4,
                              text: 'سحب',
                              inProgress: progress,
                              colorPrimary: kPrimaryColor,
                              colorDark: kPrimaryDark,
                              colorProgress: kPrimaryColor,
                              fontSize: 20.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 40.h),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              vertical: 20.h, horizontal: 15.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 5,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'عدد النقاط ', // Minimum withdrawal hint
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.sp,
                                  fontFamily: 'Kohinoor Arabic',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              for (int i = 0;
                                  i < totalPointsDataList.length;
                                  i++)
                                Text(
                                  '${totalPointsDataList[i].total}  نقطة',
                                  // Transaction fee hint
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.sp,
                                    fontFamily: 'Kohinoor Arabic',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(height: 50.h),
                        Text(
                          'اخر المعاملات', // Withdraw text
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontFamily: 'Kohinoor Arabic',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 25.h),
                        Container(
                          height: size.height * 0.27,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              vertical: 20.h, horizontal: 15.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 5,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: ListView.separated(
                                padding: EdgeInsets.zero,
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: size.height * 0.02,
                                  );
                                },
                                shrinkWrap: true,
                                itemCount: 4,
                                itemBuilder: (context, index) {
                                  return Text(
                                    'تم سحب 70 ', // Minimum withdrawal hint
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.sp,
                                      fontFamily: 'Kohinoor Arabic',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  );
                                }),
                          ),
                        ),
                        SizedBox(height: 25.h),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }
}
