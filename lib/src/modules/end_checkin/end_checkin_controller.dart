import 'package:flutter_experience_health_center_desk_assistant/src/models/patient_information_form_model.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/services/call_next_patient/call_next_patient_service.dart';
import 'package:health_center_core/health_center_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

class EndCheckInController with MessageStateMixin {
  EndCheckInController({
    required CallNextPatientService callNextPatientService,
  }) : _callNextPatientService = callNextPatientService;

  final CallNextPatientService _callNextPatientService;

  final patientInformationForm = signal<PatientInformationFormModel?>(null);

  Future<void> callNextPatient() async {
    final result = await _callNextPatientService.execute();

    switch (result) {
      case Left():
        showError('Error on call next patient');
      case Right():
        final resultNextPatient = await _callNextPatientService.execute();
        switch (resultNextPatient) {
          case Left():
            showError('Error on call next patient');
          case Right(value: final form?):
            patientInformationForm.value = form;
          case _:
            showInfo('No patient to call');
        }
    }
  }
}
