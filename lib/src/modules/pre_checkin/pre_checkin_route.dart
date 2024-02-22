import 'package:flutter/material.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/models/patient_information_form_model.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/modules/pre_checkin/pre_checkin_controller.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/modules/pre_checkin/pre_checkin_page.dart';

import 'package:flutter_getit/flutter_getit.dart';

class PreCheckInRouter extends FlutterGetItModulePageRouter {
  const PreCheckInRouter({super.key});

  @override
  WidgetBuilder get view => (context) {
        final form = ModalRoute.of(context)!.settings.arguments
            as PatientInformationFormModel;

        context.get<PreCheckInController>().patientInformationForm.value = form;

        return const PreCheckInPage();
      };
}
