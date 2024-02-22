import 'package:flutter_experience_health_center_desk_assistant/src/models/patient_information_form_model.dart';
import 'package:health_center_core/health_center_core.dart';

abstract interface class PatientInformationFormRepository {
  Future<Either<RepositoryException, PatientInformationFormModel?>>
      callNextToCheckin();
  Future<Either<RepositoryException, Unit>> updateStatus(
      String id, PatientInformationFormStatus status);
}
