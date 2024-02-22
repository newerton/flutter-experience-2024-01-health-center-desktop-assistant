import 'package:flutter/material.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/modules/end_checkin/end_checkin_controller.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:health_center_core/health_center_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

class EndCheckInPage extends StatefulWidget {
  const EndCheckInPage({super.key});

  @override
  State<EndCheckInPage> createState() => _EndCheckInPageState();
}

class _EndCheckInPageState extends State<EndCheckInPage>
    with MessagesViewMixin {
  final controller = Injector.get<EndCheckInController>();

  @override
  void initState() {
    messageListener(controller);
    effect(() {
      if (controller.patientInformationForm() != null) {
        Navigator.of(context).pushReplacementNamed('/pre-checkin',
            arguments: controller.patientInformationForm());
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: HealthCenterAppBar(
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton(
            child: const IconPopupMenuWidget(),
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 1,
                child: Text('Start Terminal'),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Text('Logout'),
              )
            ],
          )
        ],
      ),
      body: Center(
          child: Container(
        width: sizeOf.width * 0.5,
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: HealthCenterTheme.orangeColor)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/check_icon.png'),
            const SizedBox(height: 32),
            const Text('Service successfully complete!',
                style: HealthCenterTheme.titleStyle),
            const SizedBox(height: 48),
            SizedBox(
              width: sizeOf.width * 0.8,
              height: 48,
              child: ElevatedButton(
                  onPressed: () {
                    controller.callNextPatient();
                  },
                  child: const Text('Call next patient')),
            )
          ],
        ),
      )),
    );
  }
}
