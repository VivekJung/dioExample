import 'dart:math';

import 'package:dio/dio.dart';
import 'package:dioapi/api/dio/dio_exception.dart';
import 'package:dioapi/api/app_endPoints.dart';
import 'package:dioapi/api/dio/auth_interceptor.dart';
import 'package:dioapi/api/dio/log_interceptor.dart';
import 'package:dioapi/model/user_model.dart';
import 'package:flutter/foundation.dart';

class DioClient {
  late final Dio _dio;
  DioClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: AppEndPoints.baseUrl,
            connectTimeout: 5000,
            receiveTimeout: 3000,
            responseType: ResponseType.json,
          ),
        )..interceptors
            .addAll([AuthorizationInterceptor(), LogerInterceptor()]);

  // HTTP requests begins

  //Gets User By ID and handles errors of network/server issues.
  Future<User?> getUserByID({required int id}) async {
    try {
      final response = await _dio.get('/users/$id');
      return User.fromJson(response.data);
    } on DioError catch (dioError) {
      final errorMessage = DioException.fromDioError(dioError).toString();
      throw errorMessage;
    } catch (e) {
      throw e.toString();
    }
  }

  //Creates new user (of modelType User)by passing access-token/apikeys as Bearer with Authorization header
  Future<User?> createUser({required User user}) async {
    try {
      final result = await _dio.post(
        '/users',
        data: user.toJson(),
        // we remove header here because our interceptor (Authorization interceptor will handle this)
      );
      return User.fromJson(result.data);
    } on DioError catch (dioError) {
      final errorMessage = DioException.fromDioError(dioError).toString();
      throw errorMessage;
    } catch (e) {
      throw e.toString();
    }
  }

  // Deletes a user having the provided `id`.
  // The access-token has been passed using [AuthorizationInterceptor].
  Future<void> deleteUser({required int id}) async {
    try {
      await _dio.delete('/users/$id');
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      if (kDebugMode) print(e);
      throw e.toString();
    }
  }
}
