import 'dart:io';

import 'package:dio/dio.dart';
import 'package:submission_intermediate/common/constants.dart';
import 'package:submission_intermediate/data/api/dio_config.dart';
import 'package:submission_intermediate/data/model/add_new_story.dart';
import 'package:submission_intermediate/data/model/detail_story_response.dart';
import 'package:submission_intermediate/data/model/login_response.dart';
import 'package:submission_intermediate/data/model/register_response.dart';
import 'package:submission_intermediate/data/model/stories_response.dart';

import '../model/error_response.dart';

class ApiService {
  /// [POST] Register User
  Future<dynamic> register(
    String name,
    String email,
    String password,
  ) async {
    final dioConfig = DioConfig();
    try {
      final response = await dioConfig.request(
        'register',
        DioMethod.post,
        param: {
          'name': name,
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 201) {
        return RegisterResponse.fromJson(response.data);
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw SocketException(Constants.messageConnectionError);
      } else if (e.type == DioExceptionType.badResponse) {
        return ErrorResponse.fromJson(e.response!.data);
      } else {
        throw Exception(Constants.messageDioError);
      }
    } catch (e) {
      throw Exception(Constants.messageElseError + e.toString());
    }
  }

  /// [POST] Login User
  Future<dynamic> login(
    String email,
    String password,
  ) async {
    final dioConfig = DioConfig();
    try {
      final response = await dioConfig.request(
        'login',
        DioMethod.post,
        param: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        return LoginResponse.fromJson(response.data);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw SocketException(Constants.messageConnectionError);
      } else if (e.type == DioExceptionType.badResponse) {
        return ErrorResponse.fromJson(e.response!.data);
      } else {
        throw Exception(Constants.messageDioError);
      }
    } catch (e) {
      throw Exception(Constants.messageElseError + e.toString());
    }
  }

  /// [GET] Get All Stories
  Future<StoriesResponse> getAllStory(String? authToken) async {
    final dioConfig = DioConfig();

    try {
      final response = await dioConfig.request(
        'stories',
        DioMethod.get,
        authToken: authToken,
      );
      if (response.statusCode == 200) {
        return StoriesResponse.fromJson(response.data);
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw SocketException(Constants.messageConnectionError);
      } else {
        throw Exception(Constants.messageDioError);
      }
    } catch (e) {
      throw Exception(Constants.messageElseError + e.toString());
    }
  }

  /// [GET] get detail story
  Future<DetailStoryResponse> getDetailResponse(
    String id,
    String? authToken,
  ) async {
    final dioConfig = DioConfig();

    try {
      final response = await dioConfig.request(
        'stories/$id',
        DioMethod.get,
        authToken: authToken,
      );
      if (response.statusCode == 200) {
        return DetailStoryResponse.fromJson(response.data);
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw SocketException(Constants.messageConnectionError);
      } else {
        throw Exception(Constants.messageDioError);
      }
    } catch (e) {
      throw Exception(Constants.messageElseError + e.toString());
    }
  }

  /// [POST] Add new story
  Future<dynamic> addNewStory(
    String? authToken,
    String fileName,
    String description,
    List<int> bytes,
  ) async {
    final dioConfig = DioConfig();

    try {
      final formData = FormData.fromMap({
        'description': description,
        'photo': MultipartFile.fromBytes(
          bytes,
          filename: fileName,
        ),
      });
      final response = await dioConfig.request(
        'stories',
        DioMethod.post,
        contentType: Headers.multipartFormDataContentType,
        formData: formData,
        authToken: authToken,
      );
      if (response.statusCode == 201) {
        return AddNewStoryResponse.fromJson(response.data);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw SocketException(Constants.messageConnectionError);
      } else if (e.type == DioExceptionType.badResponse) {
        return ErrorResponse.fromJson(e.response!.data);
      } else {
        throw Exception(Constants.messageDioError);
      }
    } catch (e) {
      throw Exception(Constants.messageElseError + e.toString());
    }
  }
}
