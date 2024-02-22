import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/binding/health_center_application_binding.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/modules/auth/auth_module.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/modules/checkin/checkin_module.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/modules/end_checkin/end_checkin_module.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/modules/pre_checkin/pre_checkin_module.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/modules/home/home_module.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/pages/splash_screen/page.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:health_center_core/health_center_core.dart';

void main() {
  runZonedGuarded(() async {
    runApp(const HealthCenterDesktopAssistantApp());
  }, (error, stackTrace) {
    log('runZonedGuardedError', error: error, stackTrace: stackTrace);
    throw error;
  });
}

class HealthCenterDesktopAssistantApp extends StatelessWidget {
  const HealthCenterDesktopAssistantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return HealthCenterAppCore(
      title: 'Health Center',
      bindings: HealthCenterApplicationBinding(),
      pagesBuilders: [
        FlutterGetItPageBuilder(page: (_) => const SplashPage(), path: '/')
      ],
      modules: [
        AuthModule(),
        HomeModule(),
        PreCheckInModule(),
        CheckInModule(),
        EndCheckInModule(),
      ],
    );
  }
}
