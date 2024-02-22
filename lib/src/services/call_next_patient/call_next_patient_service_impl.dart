import 'dart:developer';

import 'package:flutter_experience_health_center_desk_assistant/src/models/patient_information_form_model.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/repositories/attendant_desk_assignment/attendant_desk_assignment_repository.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/repositories/panel/panel_repository.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/repositories/patient_information_form/patient_information_form_repository.dart';
import 'package:health_center_core/health_center_core.dart';

import './call_next_patient_service.dart';

class CallNextPatientServiceImpl implements CallNextPatientService {
  CallNextPatientServiceImpl(
      {required this.patientInformationFormRepository,
      required this.attendantDeskAssignmentRepository,
      required this.panelRepository});

  final PatientInformationFormRepository patientInformationFormRepository;
  final AttendantDeskAssignmentRepository attendantDeskAssignmentRepository;
  final PanelRepository panelRepository;

  @override
  Future<Either<RepositoryException, PatientInformationFormModel?>>
      execute() async {
    final result = await patientInformationFormRepository.callNextToCheckin();

    switch (result) {
      case Left(value: final exception):
        return Left(exception);
      case Right(value: final form?):
        return updatePanel(form);
      case Right():
        return Right(null);
    }
  }

  @override
  Future<Either<RepositoryException, PatientInformationFormModel?>> updatePanel(
      PatientInformationFormModel form) async {
    final result = await attendantDeskAssignmentRepository.getDeskAssignment();

    switch (result) {
      case Left(value: final exception):
        return Left(exception);
      case Right(value: final deskNumber):
        return await _callOnPanel(form, deskNumber);
    }
  }

  Future<Either<RepositoryException, PatientInformationFormModel?>>
      _callOnPanel(PatientInformationFormModel form, int deskNumber) async {
    final result = await panelRepository.callOnPanel(form.password, deskNumber);

    switch (result) {
      case Left(value: final exception):
        log('Error calling on panel',
            error: exception,
            stackTrace: StackTrace.fromString('Error calling on panel'));
        return Right(form);
      case Right():
        return Right(form);
    }
  }
}
