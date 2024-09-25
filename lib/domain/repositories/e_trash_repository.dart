import '../models/e_trash.dart';

abstract class ETrashRepository {
  Future<ETrashFetch> getAllETrashes();
}
