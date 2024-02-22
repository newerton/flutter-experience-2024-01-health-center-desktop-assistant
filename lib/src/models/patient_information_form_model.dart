import 'package:flutter_experience_health_center_desk_assistant/src/models/patient_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'patient_information_form_model.g.dart';

@JsonEnum(valueField: 'id')
enum PatientInformationFormStatus {
  waiting('Waiting'),
  checkIn('Checked In'),
  beingAttended('Being Attended');

  final String id;
  const PatientInformationFormStatus(this.id);
}

@JsonSerializable()
class PatientInformationFormModel {
  PatientInformationFormModel({
    required this.id,
    required this.patient,
    required this.healthInsuranceCard,
    required this.medicalOrders,
    required this.password,
    required this.dateCreated,
    required this.status,
  });

  final String id;
  final PatientModel patient;
  @JsonKey(name: 'health_insurence_card')
  final String healthInsuranceCard;
  @JsonKey(name: 'medical_order')
  final List<String> medicalOrders;
  final String password;
  @JsonKey(name: 'date_created')
  final DateTime dateCreated;
  final PatientInformationFormStatus status;

  factory PatientInformationFormModel.fromJson(Map<String, dynamic> json) =>
      _$PatientInformationFormModelFromJson(json);

  Map<String, dynamic> toJson() => _$PatientInformationFormModelToJson(this);

  PatientInformationFormModel copyWith({
    String? id,
    PatientModel? patient,
    String? healthInsuranceCard,
    List<String>? medicalOrders,
    String? password,
    DateTime? dateCreated,
    PatientInformationFormStatus? status,
  }) {
    return PatientInformationFormModel(
      id: id ?? this.id,
      patient: patient ?? this.patient,
      healthInsuranceCard: healthInsuranceCard ?? this.healthInsuranceCard,
      medicalOrders: medicalOrders ?? this.medicalOrders,
      password: password ?? this.password,
      dateCreated: dateCreated ?? this.dateCreated,
      status: status ?? this.status,
    );
  }
}
