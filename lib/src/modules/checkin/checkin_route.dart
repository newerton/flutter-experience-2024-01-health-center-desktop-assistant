import 'package:flutter/material.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/models/patient_information_form_model.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/modules/checkin/checkin_controller.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/modules/checkin/checkin_page.dart';

import 'package:flutter_getit/flutter_getit.dart';

class CheckInRouter extends FlutterGetItModulePageRouter {
  const CheckInRouter({super.key});

  @override
  WidgetBuilder get view => (context) {
        final form = ModalRoute.of(context)!.settings.arguments
            as PatientInformationFormModel;

        context.get<CheckInController>().patientInformationForm.value = form;

        return const CheckInPage();
      };
}
