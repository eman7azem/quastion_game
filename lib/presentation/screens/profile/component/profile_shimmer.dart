import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../widgets/button.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Image.asset(
          'assets/images/bg1.png',
          height: size.height * 0.9,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: size.height * 0.2,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
              height: size.height * 0.7,
              width: size.width,
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.13,
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[200]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.03),
                      width: size.width,
                      height: size.height * 0.085,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(color: Color(0xABC5C5C5), width: 2)),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[200]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: size.width * 0.03),
                      width: size.width,
                      height: size.height * 0.085,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(color: Color(0xABC5C5C5), width: 2)),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[200]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: size.width * 0.03),
                      width: size.width,
                      height: size.height * 0.085,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(color: Color(0xABC5C5C5), width: 2)),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[200]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: size.width * 0.03),
                      width: size.width,
                      height: size.height * 0.085,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(color: Color(0xABC5C5C5), width: 2)),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: size.height * 0.14,
          left: size.width * 0.36,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.grey[100]!,
            child: Center(
              child: Container(
                width: size.width * 0.3,
                height: size.width * 0.3,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: scundryColor,
                    // Choose your desired border color
                    width: 2.0,
                  ),
                ),
                child: ClipOval(),
              ),
            ),
          ),
        ),
        Positioned(
          top: size.height * 0.23,
          left: size.width * 0.54,
          child: Container(
              width: size.width * 0.2,
              height: size.width * 0.1,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.edit,
                color: Colors.white,
                size: 30.r,
              )),
        ),
      ],
    );
  }
}
