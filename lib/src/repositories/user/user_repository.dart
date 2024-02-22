import 'package:health_center_core/health_center_core.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login(String email, String password);
}
