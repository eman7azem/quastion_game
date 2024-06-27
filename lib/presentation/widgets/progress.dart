// import 'package:flutter/material.dart';
// import 'package:step_progress_indicator/step_progress_indicator.dart';
// import 'dart:math' as math;
//
// import '../../constants/colors.dart';
//
//
// class MyProgress extends StatefulWidget {
//   const MyProgress({Key? key, required this.color}) : super(key: key);
// final Color color;
//   @override
//   State<MyProgress> createState() => _MyProgressState();
// }
//
// class _MyProgressState extends State<MyProgress> with TickerProviderStateMixin {
//
//   late Animation<double> animation;
//   late AnimationController _controller;
//   int i = 0;
//
//   @override
//   void initState() {
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 1300), vsync: this,
//     );
//     animation = Tween<double>(begin: 0, end: 12).animate(_controller)..addListener(() {
//       setState(() {
//         i = animation.value.toInt();
//       });
//     })..addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         _controller.repeat(reverse: false);
//       }
//     });
//     _controller.forward();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return CircularStepProgressIndicator(
//       currentStep: i,
//       totalSteps: 12,
//       stepSize: 9,
//       padding: math.pi / 11,
//       width: 40,
//       height: 40,
//       unselectedColor: Colors.white,
//       selectedColor: i < 12 ? widget.color : Colors.white,
//     );
//   }
// }
