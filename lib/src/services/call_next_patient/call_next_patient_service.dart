import 'package:flutter_experience_health_center_desk_assistant/src/models/patient_information_form_model.dart';
import 'package:health_center_core/health_center_core.dart';

abstract interface class CallNextPatientService {
  Future<Either<RepositoryException, PatientInformationFormModel?>> execute();
  Future<Either<RepositoryException, PatientInformationFormModel?>> updatePanel(
      PatientInformationFormModel form);
}
