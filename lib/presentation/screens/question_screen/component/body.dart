import 'package:flutter/material.dart';
import 'dart:async'; // Import the async package for Timer

import 'package:quastions_game/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quastions_game/constants/navigator.dart';
import 'package:quastions_game/presentation/screens/question_screen/component/quation_shimmer.dart';
import 'package:quastions_game/presentation/screens/question_screen/component/result.dart';
import 'package:animate_do/animate_do.dart';
import '../../../../data/api/api.dart';
import '../../../../data/models/quastion.dart';
import '../../../widgets/button.dart';
import 'answer_card.dart';

class Body extends StatefulWidget {
  Body({super.key, required this.id});

  final int id;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _api = API();

  bool progress = false; // Initialize progress to true
  late Future<List<QuestionModel>> _questionsFuture;
  PageController? _controller;

  int? selectedAnswerIndex;
  int? correctAnswerIndex;
  int questionIndex = 0;
  int correctAnswers = 0;
  int incorrectAnswers = 0;
  int _remainingTime = 60; // Initial remaining time in seconds
  Timer? _timer; // Timer for the countdown

  void pickAnswer(int value, List<QuestionModel> questions) {
    setState(() {
      selectedAnswerIndex = value;
      correctAnswerIndex = int.parse(questions[questionIndex].correctAns);
      if (selectedAnswerIndex == correctAnswerIndex) {
        correctAnswers++;
      } else {
        incorrectAnswers++;
      }
    });
  }

  void goToNextQuestion() {
    setState(() {
      selectedAnswerIndex = null;
      correctAnswerIndex = null;
      questionIndex++;
      _controller?.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  void startTimer(int questionTime) {
    _timer?.cancel();
    _remainingTime = questionTime; // Set remaining time to question time
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        timer.cancel();
        goToNextQuestion();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _questionsFuture = _api.fetchQuestions(id: widget.id);
    _controller = PageController(initialPage: 0);
    _questionsFuture.then((questions) {
      if (questions.isNotEmpty) {
        startTimer(60);
        // startTimer(questions[0].time );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder<List<QuestionModel>>(
      future: _questionsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return QuestionShimmer();
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'خطأ في الاتصال بالإنترنت',
              style: TextStyle(
                color: Colors.black,
                fontSize: size.width * 0.05,
                fontFamily: 'Kohinoor Arabic',
              ),
            ),
          );
        } else if (snapshot.hasData) {
          List<QuestionModel> questions = snapshot.data!;
          return PageView.builder(
            controller: _controller,
            itemCount: questions.length,
            itemBuilder: (context, index) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: size.height * 0.45,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40),
                            ),
                            child: Image.asset(
                              'assets/images/bg1.png',
                              height: size.height * 0.3,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: size.height * 0.15,
                            left: size.width * 0.1,
                            child: Container(
                              width: size.width * 0.8,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(40),
                                ),
                                border: Border.all(color: Colors.transparent),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.02),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: size.width * 0.12,
                                              height: size.height * 0.014,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Color(0xffD05A04),
                                              ),
                                            ),
                                            SizedBox(
                                              width: size.width * 0.02,
                                            ),
                                            Text(
                                              '$incorrectAnswers',
                                              style: TextStyle(
                                                color: Color(0xffD05A04),
                                                fontSize: 24,
                                                fontFamily: 'Kohinoor Arabic',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: size.width * 0.12,
                                              height: size.height * 0.014,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Color(0xff1F8435),
                                              ),
                                            ),
                                            SizedBox(
                                              width: size.width * 0.02,
                                            ),
                                            Text(
                                              '$correctAnswers',
                                              style: TextStyle(
                                                color: Color(0xff1F8435),
                                                fontSize: 24,
                                                fontFamily: 'Kohinoor Arabic',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                  Text(
                                    'السؤال ${questionIndex + 1} / ${questions.length}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 20,
                                      fontFamily: 'Kohinoor Arabic',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.05,
                                        vertical: size.height * 0.025),
                                    child: Text(
                                      questions[questionIndex].question,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'Kohinoor Arabic',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: size.height * 0.102,
                            left: size.width * 0.432,
                            child: Image.asset(
                              'assets/images/Time.png',
                              height: size.width * 0.17,
                            ),
                          ),
                          Positioned(
                            top: size.height * 0.116,
                            left: size.width * 0.405,
                            child: Container(
                              width: size.width * 0.22, // Set width
                              height: size.width * 0.115, // Set height
                              decoration: BoxDecoration(
                                color: Colors.white, // Set container color
                                shape: BoxShape.circle, // Set shape to circle
                              ),
                            ),
                          ),
                          Positioned(
                            top: size.height * 0.13,
                            left: size.width * 0.485,
                            child: Center(
                              // Center widget
                              child: Container(
                                alignment: Alignment.center,
                                // Alignment to center
                                width: size.width * 0.06,
                                // Set width
                                height: size.width * 0.06,
                                // Set height
                                child: Text(
                                  '$_remainingTime',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: size.width * 0.05,
                                    fontFamily: 'Kohinoor Arabic',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.03),
                      child: Column(
                        children: [
                          Column(
                            children: List.generate(
                              4,
                              (index) => GestureDetector(
                                onTap: selectedAnswerIndex == null
                                    ? () => pickAnswer(index, questions)
                                    : null,
                                child: AnswerCard(
                                  currentIndex: index,
                                  question: index == 0
                                      ? questions[questionIndex].option1
                                      : index == 1
                                          ? questions[questionIndex].option2
                                          : index == 2
                                              ? questions[questionIndex].option3
                                              : questions[questionIndex]
                                                  .option4,
                                  isSelected: selectedAnswerIndex == index,
                                  selectedAnswerIndex: selectedAnswerIndex,
                                  correctAnswerIndex: correctAnswerIndex,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          FadeInUp(
                            duration: Duration(milliseconds: 1600),
                            child: GestureDetector(
                              onTap: selectedAnswerIndex != null
                                  ? () {
                                      if (questionIndex < 4) {
                                        goToNextQuestion();
                                      } else {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (_) => Result()));
                                      }
                                    }
                                  : null,
                              child: Button(
                                width: size.width * 0.6,
                                text: questionIndex < 4 ? 'التالي' : 'إنهاء',
                                inProgress: progress,
                                colorPrimary: kPrimaryColor,
                                colorDark: scundryColorDark,
                                colorProgress: kPrimaryColor,
                                fontSize: 24.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return Center(child: Text('لا توجد أسئلة متاحة'));
        }
      },
    );
  }
}
