import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:shimmer/shimmer.dart';

class QuestionShimmer extends StatelessWidget {
  const QuestionShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: size.height * 0.46,
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
                  top: size.height * 0.18,
                  left: size.width * 0.1,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[200]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.03),
                      width: size.width * 0.8,
                      height: size.height * 0.2,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.0),
                          border:
                              Border.all(color: Color(0xABC5C5C5), width: 2)),
                    ),
                  ),
                ),
                Positioned(
                    top: size.height * 0.102,
                    left: size.width * 0.432,
                    child: Image.asset(
                      'assets/images/Time.png',
                      height: size.width * 0.17,
                    )),
                Positioned(
                  top: size.height * 0.116,
                  left: size.width * 0.405,
                  child: Container(
                    width: size.width * 0.22, // Set width
                    height: size.width * 0.115, // Set height
                    decoration: BoxDecoration(
                      color: Colors.white, // Set container color
                      shape: BoxShape.circle, // Set shape to circle
                    ),
                  ),
                ),

              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
            child: Column(
              children: [
                for (int i = 0; i < 4; i++)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                    // Add vertical space
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[200]!,
                      highlightColor: Colors.grey[200]!,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.03),
                        width: size.width,
                        height: size.height * 0.085,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(
                              color: const Color(0xABC5C5C5), width: 2),
                        ),
                      ),
                    ),
                  ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                FadeInUp(
                  duration: const Duration(milliseconds: 1600),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[200]!,
                    highlightColor: Colors.grey[200]!,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.03),
                      width: size.width * 0.4,
                      height: size.height * 0.085,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(
                              color: const Color(0xABC5C5C5), width: 2)),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
