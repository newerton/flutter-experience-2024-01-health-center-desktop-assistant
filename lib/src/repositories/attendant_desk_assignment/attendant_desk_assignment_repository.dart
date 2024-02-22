import 'package:health_center_core/health_center_core.dart';

abstract interface class AttendantDeskAssignmentRepository {
  Future<Either<RepositoryException, Unit>> startService(int deskId);
  Future<Either<RepositoryException, int>> getDeskAssignment();
}
