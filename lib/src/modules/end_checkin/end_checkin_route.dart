import 'package:flutter/material.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/modules/end_checkin/end_checkin_page.dart';

import 'package:flutter_getit/flutter_getit.dart';

class EndCheckInRouter extends FlutterGetItModulePageRouter {
  const EndCheckInRouter({super.key});

  @override
  WidgetBuilder get view => (_) => const EndCheckInPage();
}
