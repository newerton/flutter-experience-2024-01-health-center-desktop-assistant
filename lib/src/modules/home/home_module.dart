import 'package:flutter/material.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/modules/home/home_controller.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/modules/home/home_route.dart';

import 'package:flutter_getit/flutter_getit.dart';

class HomeModule extends FlutterGetItModule {
  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton((i) => HomeController(
            attendantDeskAssignmentRepository: i(),
            callNextPatientService: i())),
      ];

  @override
  String get moduleRouteName => '/home';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/': (_) => const HomeRouter(),
      };
}
