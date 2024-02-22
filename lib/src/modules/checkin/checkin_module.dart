import 'package:flutter/material.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/modules/checkin/checkin_controller.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/modules/checkin/checkin_route.dart';

import 'package:flutter_getit/flutter_getit.dart';

class CheckInModule extends FlutterGetItModule {
  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton(
            (i) => CheckInController(patientInformationFormRepository: i()))
      ];

  @override
  String get moduleRouteName => '/checkin';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/': (_) => const CheckInRouter(),
      };
}
