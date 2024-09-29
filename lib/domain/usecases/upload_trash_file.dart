import 'dart:io';

import 'package:dartz/dartz.dart';

import '../repositories/e_trash_repository.dart';

abstract class UploadTrashFile {
  Future<Either<Exception, String?>> call({
    required String path,
    required File trashFile,
  });
}

class UploadTrashFileImpl implements UploadTrashFile {
  final ETrashRepository repository;

  UploadTrashFileImpl(this.repository);

  @override
  Future<Either<Exception, String?>> call({
    required String path,
    required File trashFile,
  }) async {
    try {
      return Right(
        await repository.uploadTrashFile(
          path: path,
          trashFile: trashFile,
        ),
      );
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
