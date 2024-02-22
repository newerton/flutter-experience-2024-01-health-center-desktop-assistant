import 'package:flutter/material.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/modules/end_checkin/end_checkin_controller.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/modules/end_checkin/end_checkin_route.dart';

import 'package:flutter_getit/flutter_getit.dart';

class EndCheckInModule extends FlutterGetItModule {
  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton(
            (i) => EndCheckInController(callNextPatientService: i())),
      ];

  @override
  String get moduleRouteName => '/end-checkin';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/': (_) => const EndCheckInRouter(),
      };
}
