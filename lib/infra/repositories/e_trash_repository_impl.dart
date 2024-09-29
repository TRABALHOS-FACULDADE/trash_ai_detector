import 'dart:io';

import 'package:trash_ai/domain/models/e_trash.dart';
import 'package:trash_ai/domain/models/new_e_trash.dart';

import '../../domain/repositories/e_trash_repository.dart';
import '../datasources/e_trash_datasource.dart';

class ETrashRepositoryImpl implements ETrashRepository {
  final ETrashDatasource datasource;

  ETrashRepositoryImpl(this.datasource);

  @override
  Future<ETrashFetch> getAllETrashes() async => datasource.getAllETrashes();

  @override
  Future<ETrash> insertNewETrash(NewETrash eTrash) async =>
      datasource.insertNewETrash(
        eTrash,
      );

  @override
  Future<void> deleteETrash(String eTrashId) async => datasource.deleteETrash(
        eTrashId,
      );

  @override
  Future<String?> uploadTrashFile({
    required String path,
    required File trashFile,
  }) async =>
      datasource.uploadTrashFile(
        path: path,
        trashFile: trashFile,
      );

  @override
  Future<void> deleteTrashFile(String path) async => datasource.deleteTrashFile(
        path,
      );
}
