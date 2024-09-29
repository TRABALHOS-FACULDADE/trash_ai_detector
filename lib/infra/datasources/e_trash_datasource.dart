import 'dart:io';

import '../../domain/models/e_trash.dart';
import '../../domain/models/new_e_trash.dart';

abstract class ETrashDatasource {
  Future<ETrashFetch> getAllETrashes();

  Future<ETrash> insertNewETrash(NewETrash eTrash);

  Future<void> deleteETrash(String eTrashId);

  Future<String?> uploadTrashFile({
    required String path,
    required File trashFile,
  });

  Future<void> deleteTrashFile(String path);
}
