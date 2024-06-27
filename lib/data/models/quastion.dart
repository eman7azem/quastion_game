import 'category.dart';

class QuestionModel {
  int id;
  String question;
  String option1;
  String option2;
  String option3;
  String option4;
  String correctAns;
  String time;
  int categorieId;
  DateTime createdAt;
  DateTime updatedAt;
  Category category;

  QuestionModel({
    required this.id,
    required this.question,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
    required this.correctAns,
    required this.time,
    required this.categorieId,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    print('nnnnnnnnnnnn${json['question']}');
    return QuestionModel(
      id: json['id'],
      question: json['question'],
      option1: json['option1'],
      option2: json['option2'],
      option3: json['option3'],
      option4: json['option4'],
      correctAns: json['correct_ans'],
      time: json['time'],
      categorieId: json['categorie_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      category: Category.fromJson(json['category']),
    );
  }
}


class QuestionResponse {
  bool success;
  List<QuestionModel> data;
  String message;

  QuestionResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory QuestionResponse.fromJson(Map<String, dynamic> json) {
    return QuestionResponse(
      success: json['success'],
      data: (json['data'] as List).map((e) => QuestionModel.fromJson(e)).toList(),
      message: json['message'],
    );
  }
}