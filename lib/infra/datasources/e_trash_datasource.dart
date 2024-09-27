import '../../domain/models/e_trash.dart';
import '../../domain/models/new_e_trash.dart';

abstract class ETrashDatasource {
  Future<ETrashFetch> getAllETrashes();

  Future<ETrash> insertNewETrash(NewETrash eTrash);

  Future<void> deleteETrash(String eTrashId);
}
