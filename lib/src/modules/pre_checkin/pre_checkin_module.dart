import 'package:flutter/material.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/modules/pre_checkin/pre_checkin_controller.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/modules/pre_checkin/pre_checkin_route.dart';

import 'package:flutter_getit/flutter_getit.dart';

class PreCheckInModule extends FlutterGetItModule {
  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton(
            (i) => PreCheckInController(callNextPatientService: i()))
      ];

  @override
  String get moduleRouteName => '/pre-checkin';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/': (_) => const PreCheckInRouter(),
      };
}
