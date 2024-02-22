import 'package:health_center_core/health_center_core.dart';

abstract interface class PanelRepository {
  Future<Either<RepositoryException, String?>> callOnPanel(
      String password, int attendantDeskNumber);
}
