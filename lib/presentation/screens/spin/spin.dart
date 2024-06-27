import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:quastions_game/constants/colors.dart';
import 'package:quastions_game/data/models/point_user.dart';

import '../../../data/api/api.dart';
import '../../../data/models/point.dart';
import '../../utilities/my_toast.dart';

class SpinScreen extends StatefulWidget {
  SpinScreen({super.key});

  @override
  State<SpinScreen> createState() => _SpinScreenState();
}

class _SpinScreenState extends State<SpinScreen> {
  StreamController<int> controller = StreamController<int>();

  late Future<List<Point>> _futurePoints;

  final _api = API();
  Timer? _timer;
  int _randomIndex = 0;

  @override
  void initState() {
    super.initState();
    _futurePoints = _api.fetchPoints();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<List<Point>>(
      future: _futurePoints,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
              child: Text(
            'خطأ في الاتصال بالإنترنت',
            style: TextStyle(
              color: Colors.black,
              fontSize: size.width * 0.05,
              fontFamily: 'Kohinoor Arabic',
            ),
          ));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No points available'));
        } else {
          List<Point> points = snapshot.data!;
          _randomIndex = Random().nextInt(points.length);
          _timer = Timer(Duration(milliseconds: 1000), () {
            controller.add(_randomIndex);
          });
          return Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: FortuneWheel(
                selected: controller.stream,
                onAnimationEnd: () {
                  _showDialog(points[_randomIndex].point.toString());
                  sendPoint(points[_randomIndex].id);
                },
                indicators: <FortuneIndicator>[
                  FortuneIndicator(
                    alignment: Alignment.topCenter,
                    child: TriangleIndicator(
                      color: scundryColor,
                      width: 40.0,
                      height: 40.0,
                      elevation: 0,
                    ),
                  ),
                ],
                items: points.map((point) {
                  return FortuneItem(
                    child: Text(point.point.toString()),
                  );
                }).toList(),
              ),
            ),
          );
        }
      },
    );
  }

  void _showDialog(String selectedPoint) {
    Size size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            'لقد حصلت على $selectedPoint نقطة ',
            style: TextStyle(
              color: Colors.black,
              fontSize: size.width * 0.06,
              fontFamily: 'Kohinoor Arabic',
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void sendPoint(int pointId) async {
    try {
      print('Sending point request for pointId: $pointId');
      SuccessResponse response = await _api.postPointUser(pointId: pointId);
      showToast(response.message);
      print('ppppppppp $pointId');
      print(response.message);
    } catch (e) {
      print('خطأ: $e');
      showToast('خطأ: $e', error: true);
    }
  }}
