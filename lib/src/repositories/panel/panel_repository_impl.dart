import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:health_center_core/health_center_core.dart';

import './panel_repository.dart';

class PanelRepositoryImpl implements PanelRepository {
  PanelRepositoryImpl({required this.restClient});

  final RestClient restClient;

  @override
  Future<Either<RepositoryException, String?>> callOnPanel(
      String password, int attendantDeskNumber) async {
    try {
      final Response(data: {"id": id}) =
          await restClient.auth.post('/painelCheckin', data: {
        "password": password,
        "time_called": DateTime.now().toIso8601String(),
        "attendant_desk": attendantDeskNumber,
      });

      return Right(id);
    } on DioException catch (e, s) {
      log('Error calling on panel', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }
}
