import 'package:flutter/material.dart';
import 'package:quastions_game/presentation/screens/forget_password/otp/component/body.dart';

class Otp extends StatelessWidget {
  const Otp({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return  Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          body: Body(
        email: email,
      )),
    );
  }
}
