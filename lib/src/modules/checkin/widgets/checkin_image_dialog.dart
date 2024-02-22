import 'package:flutter/material.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/core/env.dart';

class CheckinImageDialog extends AlertDialog {
  CheckinImageDialog(BuildContext context,
      {super.key, required String imagePath})
      : super(
            content: Image.network('${Env.backendBaseUrl}/$imagePath',
                fit: BoxFit.cover),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ]);
}
