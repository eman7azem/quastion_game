import 'package:flutter/material.dart';
import 'package:quastions_game/presentation/screens/forget_password/new_password/component/body.dart';

class NewPassword extends StatelessWidget {
  static const String routeName='new';
  const NewPassword({super.key,});

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Body(),
        ));
  }
}
