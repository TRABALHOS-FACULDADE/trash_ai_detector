import '../models/e_trash.dart';
import '../models/new_e_trash.dart';

abstract class ETrashRepository {
  Future<ETrashFetch> getAllETrashes();

  Future<ETrash> insertNewETrash(NewETrash eTrash);
}
