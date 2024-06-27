import 'package:flutter/material.dart';
import 'package:quastions_game/presentation/widgets/app_bar.dart';

import '../home/component/body.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
