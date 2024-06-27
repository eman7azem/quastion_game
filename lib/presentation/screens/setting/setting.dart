import 'package:flutter/material.dart';

import '../../widgets/app_bar.dart';
import '../setting/component/body.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

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
