import 'package:flutter/material.dart';
import 'package:quastions_game/presentation/screens/forget_password/forget_password/component/body.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return const Directionality(textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Body(),
        ));
  }
}
