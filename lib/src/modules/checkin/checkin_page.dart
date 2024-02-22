import 'package:flutter/material.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/models/patient_information_form_model.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/modules/checkin/checkin_controller.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/modules/checkin/widgets/checkin_image_link.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/shared/data_item.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:health_center_core/health_center_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

class CheckInPage extends StatefulWidget {
  const CheckInPage({super.key});

  @override
  State<CheckInPage> createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> with MessagesViewMixin {
  final controller = Injector.get<CheckInController>();

  @override
  void initState() {
    messageListener(controller);
    effect(() {
      if (controller.endProcess()) {
        Navigator.of(context).pushReplacementNamed('/end-checkin');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    final PatientInformationFormModel(
      :password,
      :patient,
      :healthInsuranceCard,
      :medicalOrders
    ) = controller.patientInformationForm.watch(context)!;

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
      body: LayoutBuilder(builder: (_, constrains) {
        return SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(minHeight: constrains.maxHeight),
            padding: const EdgeInsets.all(40),
            child: Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: sizeOf.width * 0.5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: HealthCenterTheme.orangeColor)),
                padding: const EdgeInsets.all(40),
                width: MediaQuery.sizeOf(context).width * 0.8,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/images/patient_avatar.png'),
                    const SizedBox(height: 16),
                    const Text('The password called was',
                        style: HealthCenterTheme.titleStyle),
                    const SizedBox(height: 16),
                    Container(
                      width: sizeOf.width * 0.3,
                      height: 48,
                      decoration: BoxDecoration(
                        color: HealthCenterTheme.orangeColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          password,
                          style: HealthCenterTheme.subTitleSmallStyle.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: HealthCenterTheme.lightOrangeColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        'Patient information',
                        style: HealthCenterTheme.subTitleSmallStyle.copyWith(
                            color: HealthCenterTheme.orangeColor,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    const SizedBox(height: 24),
                    DataItem(
                      label: 'Name',
                      value: patient.name,
                      padding: const EdgeInsets.only(bottom: 24),
                    ),
                    DataItem(
                      label: 'E-mail',
                      value: patient.email,
                      padding: const EdgeInsets.only(bottom: 24),
                    ),
                    DataItem(
                      label: 'Phone number',
                      value: patient.phoneNumber,
                      padding: const EdgeInsets.only(bottom: 24),
                    ),
                    DataItem(
                      label: 'Document',
                      value: patient.document,
                      padding: const EdgeInsets.only(bottom: 24),
                    ),
                    DataItem(
                      label: 'ZipCode',
                      value: patient.address.cep,
                      padding: const EdgeInsets.only(bottom: 24),
                    ),
                    DataItem(
                      label: 'Address',
                      value:
                          "${patient.address.streetAddress}, ${patient.address.number}, "
                          "${patient.address.district} - ${patient.address.city} - "
                          "${patient.address.state}",
                      padding: const EdgeInsets.only(bottom: 24),
                    ),
                    DataItem(
                      label: 'Responsible',
                      value: patient.guardian,
                      padding: const EdgeInsets.only(bottom: 24),
                    ),
                    DataItem(
                      label: 'Document of responsible',
                      value: patient.guardianIdNumber,
                    ),
                    const SizedBox(height: 32),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: HealthCenterTheme.lightOrangeColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        'Document validation',
                        style: HealthCenterTheme.subTitleSmallStyle.copyWith(
                            color: HealthCenterTheme.orangeColor,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CheckinImageLink(
                            label: 'Insurance Card',
                            image: healthInsuranceCard),
                        Column(
                          children: [
                            for (final (index, medicalOrder)
                                in medicalOrders.indexed)
                              CheckinImageLink(
                                  label: 'Order medical #${index + 1}',
                                  image: medicalOrder)
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 48),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size.fromHeight(40)),
                          onPressed: () {
                            controller.finishCheckin();
                          },
                          child: const Text('Finish Checkin')),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
