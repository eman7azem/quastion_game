import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:quastions_game/data/models/quastion.dart';

import '../../presentation/utilities/shared_pref.dart';
import '../models/category.dart';
import '../models/login_model.dart';
import '../models/point.dart';
import '../models/point_user.dart';
import '../models/register.dart';
import '../models/total_point.dart';
import '../models/user_data.dart';
import 'package:http_parser/http_parser.dart';

class API {
  final String baseUrl = 'https://binhizam-sa.com/api';

  API();

  Future<Map<String, dynamic>?> register({
    required String name,
    required String nickName,
    required String email,
    required String phone,
    required String password,
    required String conPassword,
  }) async {
    final url = '$baseUrl/register';
    Map<String, dynamic>? data;
    try {
      final dio = Dio();

      FormData formData = FormData.fromMap({
        'name': name,
        'nickname': nickName,
        'email': email,
        'phone': phone,
        'password': password,
        'confrim_password': conPassword,
      });

      final response = await dio.post(url, data: formData);

      print('Register request response: ${response.data}');

      if (response.statusCode == 200) {
        data = response.data;
      } else {
        // Handle other status codes here
        print('Unexpected status code: ${response.statusCode}');
      }
    } catch (error, stackTrace) {
      print('Register request Error: $error');
      print('Register request $stackTrace');
      if (error is DioError) {
        print('Register DioError: ${error.response?.statusCode}');
        print('Register DioError response: ${error.response?.data}');
      } else {
        // Handle other types of errors here
        print('Unexpected error: $error');
      }
    }
    return data;
  }

  Future<LoginResponse?> login(
      {required String email,
      required String password,
      required String deviceToken}) async {
    final String url = '$baseUrl/login';

    try {
      final dio = Dio();

      FormData formData = FormData.fromMap(
          {'email': email, 'password': password, 'device_token': deviceToken});

      final response = await dio.post(url, data: formData);

      print('login request response ${response.data}');

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        return LoginResponse.fromJson(data);
      }
    } catch (e, stackTrace) {
      print("Error in login $e");
      print("Error in login stackTrace $stackTrace");
      if (e is DioException) {
        print('Login DioError: ${e.response?.statusCode}');
        print('Login DioError response: ${e.response?.data}');
      }
    }
    return null;
  }

  Future<Map<String, dynamic>?> forgetPassword({required String email}) async {
    final url = '$baseUrl/forget-password-email';
    Map<String, dynamic>? data;
    try {
      final dio = Dio();

      FormData formData = FormData.fromMap({
        'email': email,
      });

      final response = await dio.post(url, data: formData);
      print('forget password request response ${response.data}');

      if (response.statusCode == 200) {
        data = response.data;
      }
    } catch (e, stackTrace) {
      print("Error in forget password $e");
      print("Error in forget password stackTrace $stackTrace");
    }
    return data;
  }

  Future<Map<String, dynamic>?> checkOtp({
    required String email,
    required String otp,
  }) async {
    final url = '$baseUrl/verify-otp-email';
    Map<String, dynamic>? data;
    try {
      final dio = Dio();
      FormData formData = FormData.fromMap({
        'email': email,
        'otp': otp,
      });
      final response = await dio.post(url, data: formData);

      print('checkOtp request response ${response.data}');

      if (response.statusCode == 200) {
        data = response.data;
      }
    } catch (e, stackTrace) {
      print("Error in checkOtp $e");
      print("Error in checkOtp stackTrace $stackTrace");
    }
    return data;
  }

  Future<Map<String, dynamic>?> resetPassword({
    required String password,
    required String passwordConfirm,
  }) async {
    final url = '$baseUrl/change-forget-password';
    Map<String, dynamic>? data;

    try {
      final dio = Dio();
      final token = await getString('token');

      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }

      FormData formData = FormData.fromMap({
        'password': password,
        'confrim_password': passwordConfirm,
      });

      final response = await dio.post(
        url,
        data: formData,
      );

      print('resetPassword request response ${response.data}');

      if (response.statusCode == 200) {
        data = response.data;
      } else {
        print('Failed to reset password. Status code: ${response.statusCode}');
        print('Response data: ${response.data}');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('DioError status code: ${e.response!.statusCode}');
        print('DioError response data: ${e.response!.data}');
        print('Rrrrrrrrrrrrrrrrrrrrr: ${e.response!.statusMessage}');
      } else {
        print('Error message: ${e.message}');
      }
    } catch (e, stackTrace) {
      print('Error: $e');
      print('StackTrace: $stackTrace');
    }

    return data;
  }

  Future<UserData?> getDataProfile({String? lang}) async {
    UserData? userData;
    final url = '$baseUrl/get-date-user';
    try {
      final dio = Dio();
      final token = await getString('token');

      if (token != null) {
        dio.options.headers['Authorization'] =
            'Bearer $token'; // Correctly set the authorization header
      }

      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final responseData = response.data;
        print("getDataProfile response $responseData");
        userData = UserData.fromJson(responseData['data']);
      } else {
        throw Exception(
            "Failed to get profile data. Status code: ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      print("profile data request error $e");
      print("profile data request stackTrace $stackTrace");
      throw Exception("Failed to get profile data: $e");
    }
    return userData;
  }

  Future<Map<String, dynamic>?> editProfile({
    String? name,
    String? email,
    String? phone,
    File? image,
  }) async {
    final url = '$baseUrl/update-profile-user';
    // print("URL $url");
    Map<String, dynamic>? data;

    try {
      final dio = Dio();
      final token = await getString('token');
      if (token != null) {
        dio.options.headers['Authorization'] =
            'Bearer $token'; // Correctly set the authorization header
      }

      FormData formData = FormData();

      if (image != null) {
        formData.files.add(MapEntry(
          'image',
          await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
            contentType: MediaType('image', 'jpeg'),
          ),
        ));
      }

      if (name != null) formData.fields.add(MapEntry('name', name));
      if (email != null) formData.fields.add(MapEntry('email', email));
      if (phone != null) formData.fields.add(MapEntry('phone', phone));

      final response = await dio.post(
        url,
        data: formData,
      );

      print("editProfile response ${response.data}");

      if (response.statusCode == 200) {
        data = response.data;
      } else {
        print('Failed to edit profile. Status code: ${response.statusCode}');
      }
    } on DioError catch (e) {
      print('Dio error: ${e.message}');
      if (e.response != null) {
        print('Dio error response: ${e.response}');
      }
    } catch (e, stackTrace) {
      print('Error: $e');
      print(stackTrace);
    }

    return data;
  }

  Future<Map<String, dynamic>?> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final url = '$baseUrl/update-password';
    print("URL $url");
    Map<String, dynamic>? data;
    try {
      final dio = Dio();

      final token = await getString('token');
      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }

      FormData formData = FormData();
      formData.fields.add(MapEntry('current_password', currentPassword));
      formData.fields.add(MapEntry('password', newPassword));
      formData.fields.add(MapEntry('confrim_password', confirmPassword));

      final response = await dio.post(url, data: formData);
      print("change password response ${response.data}");

      if (response.statusCode == 200) {
        data = response.data;
      } else {
        print('Failed to change password. Status code: ${response.statusCode}');
      }
    } on DioError catch (e) {
      print('Dio error: ${e.message}');
      if (e.response != null) {
        print('Dio error response: ${e.response}');
      }
    } catch (e, stackTrace) {
      print('Error: $e');
      print(stackTrace);
    }
    return data;
  }

  Future<CategoriesResponse?> getCategories() async {
    final url = '$baseUrl/category';
    try {
      final dio = Dio();
      final token = await getString('token');

      if (token != null) {
        dio.options.headers['Authorization'] =
            'Bearer $token'; // Correctly set the authorization header
      }
      print(token);
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        return CategoriesResponse.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to load categories. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching categories: $e');
      return null;
    }
  }

  Future<List<QuestionModel>> fetchQuestions({required int id}) async {
    final url = '$baseUrl/question/$id';

    try {
      final dio = Dio();
      final token = await getString('token');

      if (token != null) {
        dio.options.headers['Authorization'] =
            'Bearer $token'; // Correctly set the authorization header
      }
      final Response response = await dio.get(url);
      if (response.statusCode == 200) {
        print('qqqqqqqqqqqq');
        List<QuestionModel> questions = (response.data['data'] as List)
            .map((questionData) => QuestionModel.fromJson(questionData))
            .toList();
        return questions;
      } else {
        print(
            'Failed to load questions: ${response.statusCode} ${response.statusMessage}');
        throw Exception('Failed to load questions');
      }
    } catch (e, stacktrace) {
      if (e is DioException && e.response?.statusCode == 404) {
        print('Error 404: The requested resource was not found');
      } else {
        print('Exception occurred: $e');
        print('Stacktrace: $stacktrace');
      }
      throw Exception('Failed to load questions: $e');
    }
  }

  // Future<QuestionResponse> fetchQuestions({required int id}) async {
  //   final url = '$baseUrl/question/$id';
  //
  //   try {
  //     final dio = Dio();
  //     final token = await getString('token');
  //
  //     if (token != null) {
  //       dio.options.headers['Authorization'] = 'Bearer $token'; // Correctly set the authorization header
  //     }
  //     final Response response = await dio.get(url);
  //     if (response.statusCode == 200) {
  //       print('qqqqqqqqqqqq');
  //       QuestionResponse questionResponse = QuestionResponse.fromJson(response.data);
  //       return questionResponse;
  //     } else {
  //       print('Failed to load questions: ${response.statusCode} ${response.statusMessage}');
  //       throw Exception('Failed to load questions');
  //     }
  //   } catch (e, stacktrace) {
  //     if (e is DioException && e.response?.statusCode == 404) {
  //       print('Error 404: The requested resource was not found');
  //     } else {
  //       print('Exception occurred: $e');
  //       print('Stacktrace: $stacktrace');
  //     }
  //     throw Exception('Failed to load questions: $e');
  //   }
  // }

  Future<void> logout() async {
    final url = '$baseUrl/logout';
    try {
      final dio = Dio();
      final token = await getString('token');

      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }

      final response = await dio.get(url);
      print('logout request response $response');
    } catch (error, stackTrace) {
      print('logout request Error: $error');
      print('logout request $stackTrace');
      if (error is DioError) {
        print('logout DioError: ${error.response?.statusCode}');
        print('logout DioError response: ${error.response?.data}');
      }
    }
  }

  Future<List<Point>> fetchPoints() async {
    final url = '$baseUrl/all-point';

    try {
      final dio = Dio();
      final token = await getString('token');

      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }

      final response = await dio.get(url);
      if (response.statusCode == 200) {
        List<Point> points = (response.data['data'] as List)
            .map((pointJson) => Point.fromJson(pointJson))
            .toList();
        return points;
      } else {
        throw Exception('Failed to load points');
      }
    } catch (e) {
      throw Exception('Failed to load points: $e');
    }
  }

  Future<SuccessResponse> postPointUser({required int pointId}) async {
    final url = '$baseUrl/point-user';
    try {
      final dio = Dio();
      final token = await getString('token');

      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }

      FormData formData = FormData.fromMap({
        'point_id': pointId,
      });

      final response = await dio.post(url, data: formData);

      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;

        final success = responseData['success'] ?? false;

        if (success) {
          final data = PointUser.fromJson(responseData['data']);
          final message = responseData['message'] ?? 'Unknown message';
          return SuccessResponse(
              success: success, data: data, message: message);
        } else {
          final errorMessage = responseData['message'] ?? 'Unknown error';
          throw Exception(errorMessage);
        }
      } else if (response.statusCode == 500) {
        throw Exception('Server error: ${response.statusCode}');
      } else {
        throw Exception('Failed to post point user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }

  Future<List<TotalPointsData>> getTotalPointsData() async {
    final url = '$baseUrl/amount-user';
    try {
      final dio = Dio();
      final token = await getString('token');

      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }
      final response = await dio.get(
        url,
      );

      if (response.statusCode == 200) {
        final jsonData = response.data['data'];
        if (jsonData != null) {
          List<TotalPointsData> totalPointsDataList = jsonData
              .map<TotalPointsData>((json) => TotalPointsData.fromJson(json))
              .toList();
          return totalPointsDataList;
        } else {
          throw Exception('Failed to load data');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
