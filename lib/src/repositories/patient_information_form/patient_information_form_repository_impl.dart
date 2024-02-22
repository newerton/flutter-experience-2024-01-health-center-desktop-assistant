import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/models/patient_information_form_model.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/models/patient_model.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/repositories/patient_information_form/patient_information_form_repository.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/repositories/patients/patient_repository.dart';
import 'package:health_center_core/health_center_core.dart';

class PatientInformationFormRepositoryImpl
    implements PatientInformationFormRepository {
  PatientInformationFormRepositoryImpl(
      {required this.restClient, required this.patientRepository});

  final RestClient restClient;
  final PatientRepository patientRepository;

  @override
  Future<Either<RepositoryException, PatientInformationFormModel?>>
      callNextToCheckin() async {
    try {
      final Response(:List data) = await restClient.auth
          .get('/patientInformationForm', queryParameters: {
        'status': PatientInformationFormStatus.waiting.id,
        "page": 1,
        "limit": 1
      });

      if (data.isEmpty) {
        return Right(null);
      }

      final formData = data.first;
      final updateStatusResult = await updateStatus(
          formData['id'], PatientInformationFormStatus.waiting);

      switch (updateStatusResult) {
        case Left(value: final exception):
          return Left(exception);
        case Right():
          formData['status'] = PatientInformationFormStatus.checkIn.id;
          final patientResult = await _getPatientData(formData['patient_id']);
          formData['patient'] = patientResult;
      }
      return Right(PatientInformationFormModel.fromJson(formData));
    } on DioException catch (e, s) {
      log('Error on findPatientByDocument', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }

  @override
  Future<Either<RepositoryException, Unit>> updateStatus(
      String id, PatientInformationFormStatus status) async {
    try {
      await restClient.auth.put('/patientInformationForm/$id', data: {
        'status': status.id,
      });
      return Right(unit);
    } on DioException catch (e, s) {
      log('Error on updateStatus', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }

  Future<Map<String, dynamic>> _getPatientData(String id) async {
    final result = await patientRepository.findPatientById(id);

    final Map<String, dynamic> patientJson;
    final Map<String, dynamic> addressJson;

    switch (result) {
      case Right(value: PatientModel model?):
        patientJson = model.toJson();
        addressJson = model.address.toJson();
        patientJson['address'] = addressJson;
        return patientJson;
      case Right(value: _):
        return {};
      case Left():
        return {};
    }
  }
}
