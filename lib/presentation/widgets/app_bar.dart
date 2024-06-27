import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class AppBarApp extends StatelessWidget implements PreferredSizeWidget {
  const AppBarApp({super.key});

  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return PreferredSize(
        preferredSize: const Size.fromHeight(95.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: AppBar(
            shape: const OutlineInputBorder(
              borderSide: BorderSide.none,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40))),
            backgroundColor: kPrimaryColor,
            toolbarHeight: size.height * 0.2,
            leadingWidth: size.width * 0.18,
            // leading: Container(width: 0,),
            leading: Padding(
              padding:  EdgeInsets.only(bottom: size.height*0.05,right: size.width*0.04),
              child: const CircleAvatar(radius: 20),
            ),

          ),
        ));
  }
}
