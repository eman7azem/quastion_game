import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';

class AppBarHome extends StatelessWidget {
  const AppBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height*0.46,
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
            top: size.height * 0.15,
            left: size.width * 0.1,
            child: Container(
              height: size.height*0.3,
              width: size.width * 0.8 ,
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
            ),
          )
        ],
      ),
    );
  }
}
