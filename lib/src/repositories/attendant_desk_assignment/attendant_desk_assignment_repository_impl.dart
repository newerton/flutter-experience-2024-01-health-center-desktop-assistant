import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:health_center_core/health_center_core.dart';
import './attendant_desk_assignment_repository.dart';

class AttendantDeskAssignmentRepositoryImpl
    implements AttendantDeskAssignmentRepository {
  AttendantDeskAssignmentRepositoryImpl({required this.restClient});

  final RestClient restClient;

  @override
  Future<Either<RepositoryException, Unit>> startService(int deskId) async {
    final result = await _clearDeskByUser();

    switch (result) {
      case Left(value: final exception):
        return Left(exception);
      case Right():
        await _registerUserOnDesk(deskId);
        return Right(unit);
    }
  }

  Future<Either<RepositoryException, Unit>> _clearDeskByUser() async {
    try {
      final desk = await _getDeskByUser();

      if (desk != null) {
        await restClient.auth.delete('/attendantDeskAssignment/${desk.id}');
      }

      return Right(unit);
    } on DioException catch (e, s) {
      log('Error on clear desk by user', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }

  Future<({String id, int deskNumber})?> _getDeskByUser() async {
    final Response(:List data) = await restClient.auth.get(
        '/attendantDeskAssignment',
        queryParameters: {"user_id": "#userAuthRef"});

    if (data
        case List(
          isNotEmpty: true,
          first: {
            "id": String id,
            "desk_number": int deskNumber,
          }
        )) {
      return (
        id: id,
        deskNumber: deskNumber,
      );
    }

    return null;
  }

  Future<Either<RepositoryException, Unit>> _registerUserOnDesk(
      int deskId) async {
    try {
      await restClient.auth.post('/attendantDeskAssignment', data: {
        "user_id": "#userAuthRef",
        "desk_number": deskId,
        "date_created": DateTime.now().toIso8601String(),
        "status": "Available"
      });

      return Right(unit);
    } on DioException catch (e, s) {
      log('Error on register user on desk', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }

  @override
  Future<Either<RepositoryException, int>> getDeskAssignment() async {
    try {
      final Response(data: List(first: data)) =
          await restClient.auth.get('/attendantDeskAssignment', data: {
        "user_id": "#userAuthRef",
      });

      return Right(data['desk_number'] as int);
    } on DioException catch (e, s) {
      log('Error on get desk assignment', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }
}
