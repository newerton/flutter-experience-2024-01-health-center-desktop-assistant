import 'package:flutter/material.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/modules/checkin/widgets/checkin_image_dialog.dart';
import 'package:health_center_core/health_center_core.dart';

class CheckinImageLink extends StatelessWidget {
  const CheckinImageLink({
    super.key,
    required this.label,
    required this.image,
  });

  final String label;
  final String image;

  void showImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CheckinImageDialog(context, imagePath: image);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showImageDialog(context),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          label,
          style: const TextStyle(
              color: HealthCenterTheme.blueColor, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
