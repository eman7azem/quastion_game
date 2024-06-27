import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class AnswerCard extends StatelessWidget {
  const AnswerCard({
    super.key,
    required this.question,
    required this.isSelected,
    required this.currentIndex,
    required this.correctAnswerIndex,
    required this.selectedAnswerIndex,
  });

  final String question;
  final bool isSelected;
  final int? correctAnswerIndex;
  final int? selectedAnswerIndex;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    bool isCorrectAnswer = currentIndex == correctAnswerIndex;
    bool isWrongAnswer = !isCorrectAnswer && isSelected;
    return FadeInUp(
      duration: Duration(milliseconds: 1000),

      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
        width: size.width,
        height: size.height * 0.085,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(
            color: isSelected
                ? isCorrectAnswer
                ? Colors.green
                : Colors.red
                : currentIndex == correctAnswerIndex
                ? Colors.green
                : Colors.grey,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              question,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Kohinoor Arabic',
                fontWeight: FontWeight.w600,
              ),
            ),
            if (isSelected || currentIndex == correctAnswerIndex)
              isCorrectAnswer
                  ? buildCorrectIcon()
                  : isWrongAnswer
                  ? buildWrongIcon()
                  : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Widget buildCorrectIcon() => const CircleAvatar(
    radius: 15,
    backgroundColor: Colors.green,
    child: Icon(
      Icons.check,
      color: Colors.white,
    ),
  );

  Widget buildWrongIcon() => const CircleAvatar(
    radius: 15,
    backgroundColor: Colors.red,
    child: Icon(
      Icons.close,
      color: Colors.white,
    ),
  );
}
