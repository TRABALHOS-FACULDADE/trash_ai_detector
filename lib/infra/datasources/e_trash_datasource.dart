import '../../domain/models/e_trash.dart';

abstract class ETrashDatasource {
  Future<ETrashFetch> getAllETrashes();
}
