import 'package:flutter/material.dart';

import '../../../data/models/quastion.dart';
import '../question_screen/component/body.dart';

class Questions extends StatelessWidget {
  const Questions({super.key, required this.id,});
  final int id;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Body(id: id,),
      ),
    );
  }
}
