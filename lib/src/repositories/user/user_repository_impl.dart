import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/repositories/user/user_repository.dart';
import 'package:health_center_core/health_center_core.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({required this.restClient});

  final RestClient restClient;

  @override
  Future<Either<AuthException, String>> login(
      String email, String password) async {
    try {
      final Response(data: {'access_token': accessToken}) =
          await restClient.post(
        '/auth',
        data: {'email': email, 'password': password},
      );

      return Right(accessToken);
    } on DioException catch (e, s) {
      log('Login error', error: e, stackTrace: s);
      return switch (e) {
        DioException(response: Response(statusCode: HttpStatus.forbidden)?) =>
          Left(AuthUnauthorizedException()),
        _ => Left(AuthError(message: 'Login error. Please try again.')),
      };
    }
  }
}
