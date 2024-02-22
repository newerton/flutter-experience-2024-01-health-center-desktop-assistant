import 'package:flutter/material.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/modules/auth/login/login_controller.dart';
import 'package:health_center_core/health_center_core.dart';

import 'package:flutter_getit/flutter_getit.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with MessagesViewMixin {
  final controller = Injector.get<LoginController>();

  final formKey = GlobalKey<FormState>();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void initState() {
    messageListener(controller);
    effect(() {
      if (controller.logged) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(minHeight: sizeOf.height),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background_login.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: sizeOf.width * 0.4),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.all(40),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const Text('Login', style: HealthCenterTheme.titleStyle),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: emailEC,
                      keyboardType: TextInputType.emailAddress,
                      validator: Validatorless.multiple([
                        Validatorless.required('Field required'),
                        Validatorless.email('Invalid e-mail format'),
                      ]),
                      decoration: const InputDecoration(label: Text('E-mail')),
                    ),
                    const SizedBox(height: 24),
                    Watch(
                      (_) {
                        return TextFormField(
                          controller: passwordEC,
                          obscureText: controller.obscurePassword,
                          validator: Validatorless.required('Field required'),
                          decoration: InputDecoration(
                              label: const Text('Password'),
                              suffixIcon: IconButton(
                                  onPressed: () => controller.passwordToggle(),
                                  icon: controller.obscurePassword
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off))),
                        );
                      },
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: sizeOf.width * 0.8,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          final valid =
                              formKey.currentState?.validate() ?? false;
                          if (valid) {
                            controller.login(emailEC.text, passwordEC.text);
                          }
                        },
                        child: const Text('Login'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
