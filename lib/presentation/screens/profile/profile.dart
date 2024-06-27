import 'package:flutter/material.dart';
import 'package:quastions_game/presentation/widgets/app_bar.dart';

import '../profile/component/body.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Body(),
      ),
    );
  }
}
