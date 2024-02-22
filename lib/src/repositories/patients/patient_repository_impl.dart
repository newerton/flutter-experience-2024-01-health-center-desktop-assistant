import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/models/patient_model.dart';
import 'package:health_center_core/health_center_core.dart';

import './patient_repository.dart';

class PatientRepositoryImpl implements PatientRepository {
  PatientRepositoryImpl({required this.restClient});

  final RestClient restClient;

  @override
  Future<Either<RepositoryException, PatientModel?>> findPatientByDocument(
      String document) async {
    try {
      final Response(:List data) =
          await restClient.auth.get('/patients', queryParameters: {
        'document': document,
      });

      if (data.isEmpty) {
        return Right(null);
      }

      return Right(PatientModel.fromJson(data.first));
    } on DioException catch (e, s) {
      log('Error on findPatientByDocument', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }

  @override
  Future<Either<RepositoryException, PatientModel>> create(
      RegisterPatientModel patient) async {
    try {
      final Response(:data) = await restClient.auth.post('/patients', data: {
        "name": patient.name,
        "email": patient.email,
        "phone_number": patient.phoneNumber,
        "document": patient.document,
        "guardian": patient.guardian,
        "guardian_identification_number": patient.guardianIdNumber,
        "address": {
          "cep": patient.address.zipCode,
          "street_address": patient.address.street,
          "number": patient.address.number,
          "address_complement": patient.address.complement,
          "district": patient.address.neighborhood,
          "city": patient.address.city,
          "state": patient.address.state,
        }
      });

      return Right(PatientModel.fromJson(data));
    } on DioException catch (e, s) {
      log('Error on create patient', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }

  @override
  Future<Either<RepositoryException, Unit>> update(PatientModel patient) async {
    try {
      await restClient.auth
          .put('/patients/${patient.id}', data: patient.toJson());
      return Right(unit);
    } on DioException catch (e, s) {
      log('Error on update patient', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }

  @override
  Future<Either<RepositoryException, PatientModel?>> findPatientById(
      String id) async {
    try {
      final Response(:data) = await restClient.auth.get('/patients/$id');

      if (data == null || data.isEmpty) {
        return Right(null);
      }

      return Right(PatientModel.fromJson(data));
    } on DioException catch (e, s) {
      log('Error on findPatientById', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }
}
