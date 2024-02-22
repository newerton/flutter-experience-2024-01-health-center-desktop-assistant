import 'package:flutter_experience_health_center_desk_assistant/src/core/env.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/repositories/attendant_desk_assignment/attendant_desk_assignment_repository.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/repositories/attendant_desk_assignment/attendant_desk_assignment_repository_impl.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/repositories/panel/panel_repository.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/repositories/panel/panel_repository_impl.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/repositories/patient_information_form/patient_information_form_repository.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/repositories/patient_information_form/patient_information_form_repository_impl.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/repositories/patients/patient_repository.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/repositories/patients/patient_repository_impl.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/services/call_next_patient/call_next_patient_service.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/services/call_next_patient/call_next_patient_service_impl.dart';
import 'package:health_center_core/health_center_core.dart';

import 'package:flutter_getit/flutter_getit.dart';

class HealthCenterApplicationBinding extends ApplicationBindings {
  @override
  List<Bind<Object>> bindings() => [
        Bind.lazySingleton<RestClient>((i) => RestClient(Env.backendBaseUrl)),
        Bind.lazySingleton<PatientInformationFormRepository>((i) =>
            PatientInformationFormRepositoryImpl(
                restClient: i(), patientRepository: i())),
        Bind.lazySingleton<AttendantDeskAssignmentRepository>(
            (i) => AttendantDeskAssignmentRepositoryImpl(restClient: i())),
        Bind.lazySingleton<PanelRepository>(
            (i) => PanelRepositoryImpl(restClient: i())),
        Bind.lazySingleton<PatientRepository>(
            (i) => PatientRepositoryImpl(restClient: i())),
        Bind.lazySingleton<CallNextPatientService>((i) =>
            CallNextPatientServiceImpl(
                patientInformationFormRepository: i(),
                attendantDeskAssignmentRepository: i(),
                panelRepository: i()))
      ];
}
