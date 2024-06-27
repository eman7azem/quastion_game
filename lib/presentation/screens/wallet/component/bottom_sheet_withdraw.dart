import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants/colors.dart';
import '../../../widgets/button.dart';

class BottomSheetWithdraw extends StatefulWidget {
  const BottomSheetWithdraw({super.key});

  @override
  State<BottomSheetWithdraw> createState() => _BottomSheetWithdrawState();
}

class _BottomSheetWithdrawState extends State<BottomSheetWithdraw> {
  bool progress = false;

  TextEditingController _amountController =
  TextEditingController();
 // Controller for the amount
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'الكمية', // Minimum withdrawal hint
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontFamily: 'Kohinoor Arabic',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  width: 200.w,
                  child: TextFormField(
                      onChanged: (value) {},
                      keyboardType: TextInputType.number,
                      controller: _amountController,
                      // Assign the controller
                      decoration: InputDecoration(
                        hintText: 'الكمية',

                        hintStyle: TextStyle(
                          color: const Color(0xFFA3A3A3),
                          fontSize: 16.sp,
                          fontFamily: 'Kohinoor Arabic',
                          fontWeight: FontWeight.w600,
                        ),
                        filled: true,
                        // Fill the background
                        fillColor: const Color(0xFFEEEEEE),
                        // Set label color to grey
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
                      }),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Text(
            //   'Are you sure you want to withdraw ${currentValue
            //       .toStringAsFixed(2)} points?',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     fontSize: 18,
            //   ),
            // ),
            // SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'الحد الأدنى للسحب: 50 نقطة', // Minimum withdrawal hint
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.sp,
                    fontFamily: 'Kohinoor Arabic',
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Text(
                  'رسوم العملية: 5%', // Transaction fee hint
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.sp,
                    fontFamily: 'Kohinoor Arabic',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Button(
                width: 200.w,
                text: 'تاكيد',
                inProgress: progress,
                colorPrimary: kPrimaryColor,
                colorDark: kPrimaryDark,
                colorProgress: kPrimaryColor,
                fontSize: 20.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
