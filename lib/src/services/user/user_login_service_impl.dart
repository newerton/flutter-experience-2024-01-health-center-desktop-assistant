import 'package:flutter_experience_health_center_desk_assistant/src/repositories/user/user_repository.dart';
import 'package:flutter_experience_health_center_desk_assistant/src/services/user/user_login_service.dart';
import 'package:health_center_core/health_center_core.dart';

import 'package:shared_preferences/shared_preferences.dart';

class UserLoginServiceImpl implements UserLoginService {
  UserLoginServiceImpl({required this.userRepository});

  final UserRepository userRepository;

  @override
  Future<Either<ServiceException, Unit>> execute(
      String email, String password) async {
    final loginResult = await userRepository.login(email, password);

    switch (loginResult) {
      case Left(value: AuthError()):
        return Left(ServiceException(message: 'Login error'));
      case Left(value: AuthUnauthorizedException()):
        return Left(ServiceException(message: 'Unauthorized'));
      case Right(value: final accessToken):
        final sp = await SharedPreferences.getInstance();
        sp.setString(LocalStorageConstants.accessToken, accessToken);
        return Right(unit);
    }
  }
}
