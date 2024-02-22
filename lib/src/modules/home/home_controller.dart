import 'package:asyncstate/asyncstate.dart' as asyncstate;
import 'package:flutter_experience_health_center_desk_assistant/src/models/patient_information_form_model.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/repositories/attendant_desk_assignment/attendant_desk_assignment_repository.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/services/call_next_patient/call_next_patient_service.dart';
import 'package:health_center_core/health_center_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

class HomeController with MessageStateMixin {
  HomeController({
    required AttendantDeskAssignmentRepository
        attendantDeskAssignmentRepository,
    required CallNextPatientService callNextPatientService,
  })  : _attendantDeskAssignmentRepository = attendantDeskAssignmentRepository,
        _callNextPatientService = callNextPatientService;

  final AttendantDeskAssignmentRepository _attendantDeskAssignmentRepository;
  final CallNextPatientService _callNextPatientService;

  final _patientInformationForm = signal<PatientInformationFormModel?>(null);
  PatientInformationFormModel? get patientInformationForm =>
      _patientInformationForm();

  Future<void> startService(int deskId) async {
    asyncstate.AsyncState.show();
    final result =
        await _attendantDeskAssignmentRepository.startService(deskId);

    switch (result) {
      case Left():
        asyncstate.AsyncState.hide();
        showError('Error on start service');
      case Right():
        final resultNextPatient = await _callNextPatientService.execute();
        switch (resultNextPatient) {
          case Left():
            asyncstate.AsyncState.hide();
            showError('Error on call next patient');
          case Right(value: final form?):
            asyncstate.AsyncState.hide();
            _patientInformationForm.value = form;
          case Right(value: null):
            asyncstate.AsyncState.hide();
            showInfo('No patient to call');
        }
    }
  }
}
