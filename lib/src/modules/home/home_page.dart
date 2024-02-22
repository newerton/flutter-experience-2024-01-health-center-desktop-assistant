import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/modules/home/home_controller.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:health_center_core/health_center_core.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:validatorless/validatorless.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with MessagesViewMixin {
  final controller = Injector.get<HomeController>();

  final formKey = GlobalKey<FormState>();
  final numberEC = TextEditingController();

  @override
  void initState() {
    messageListener(controller);
    effect(() {
      if (controller.patientInformationForm != null) {
        Navigator.of(context).pushNamed('/pre-checkin',
            arguments: controller.patientInformationForm);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    numberEC.dispose();
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
            const Text('Welcome!', style: HealthCenterTheme.titleStyle),
            const SizedBox(height: 16),
            const Text(
              'Fill in the number of the counter you are working at',
              textAlign: TextAlign.center,
              style: HealthCenterTheme.subTitleSmallStyle,
            ),
            const SizedBox(height: 32),
            Form(
              key: formKey,
              child: TextFormField(
                controller: numberEC,
                keyboardType: TextInputType.number,
                validator: Validatorless.multiple([
                  Validatorless.required('Field required'),
                  Validatorless.number('Invalid number')
                ]),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration:
                    const InputDecoration(label: Text('Number of the counter')),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: sizeOf.width * 0.8,
              height: 48,
              child: ElevatedButton(
                  onPressed: () {
                    final valid = formKey.currentState?.validate() ?? false;
                    if (valid) {
                      controller.startService(int.parse(numberEC.text));
                    }
                  },
                  child: const Text('Call next patient')),
            )
          ],
        ),
      )),
    );
  }
}
