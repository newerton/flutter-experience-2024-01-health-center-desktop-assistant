import 'package:asyncstate/asyncstate.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/services/user/user_login_service.dart';
import 'package:health_center_core/health_center_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

class LoginController with MessageStateMixin {
  LoginController({
    required UserLoginService loginService,
  }) : _loginService = loginService;

  final UserLoginService _loginService;

  final _obscurePassword = signal(true);
  final _logged = signal(false);

  bool get obscurePassword => _obscurePassword();
  bool get logged => _logged();

  void passwordToggle() => _obscurePassword.value = !_obscurePassword.value;

  Future<void> login(String email, String password) async {
    final loginResult =
        await _loginService.execute(email, password).asyncLoader();

    switch (loginResult) {
      case Left(value: ServiceException(:final message)):
        showError(message);
      case Right(value: _):
        _logged.value = true;
    }
  }
}
