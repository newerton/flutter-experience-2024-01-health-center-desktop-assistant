import 'package:flutter_experience_health_center_desk_assistant/src/models/patient_information_form_model.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/repositories/patient_information_form/patient_information_form_repository.dart';
import 'package:health_center_core/health_center_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

class CheckInController with MessageStateMixin {
  CheckInController({
    required PatientInformationFormRepository patientInformationFormRepository,
  }) : _patientInformationFormRepository = patientInformationFormRepository;

  final patientInformationForm = signal<PatientInformationFormModel?>(null);
  // PatientInformationFormModel? get patientInformationForm =>
  //     _patientInformationForm();

  final PatientInformationFormRepository _patientInformationFormRepository;
  final endProcess = signal(false);

  Future<void> finishCheckin() async {
    if (patientInformationForm() != null) {
      final result = await _patientInformationFormRepository.updateStatus(
          patientInformationForm.value!.id,
          PatientInformationFormStatus.beingAttended);

      switch (result) {
        case Left():
          showError('Error finishing checkin');
        case Right():
          endProcess.value = true;
      }
    } else {
      showError('No patient to finish checkin');
    }
  }
}
