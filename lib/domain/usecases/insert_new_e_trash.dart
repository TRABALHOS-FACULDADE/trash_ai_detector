import 'package:dartz/dartz.dart';

import '../models/e_trash.dart';
import '../models/new_e_trash.dart';
import '../repositories/e_trash_repository.dart';
import 'upload_trash_file.dart';

abstract class InsertNewETrash {
  Future<Either<Exception, ETrash>> call(NewETrash newETrash);
}

class InsertNewETrashImpl implements InsertNewETrash {
  final ETrashRepository repository;
  final UploadTrashFile uploadTrashFile;

  InsertNewETrashImpl(
    this.repository,
    this.uploadTrashFile,
  );

  @override
  Future<Either<Exception, ETrash>> call(
    NewETrash newETrash,
  ) async {
    try {
      if (newETrash.hasFileToUpload) {
        (await uploadTrashFile.call(
          path: newETrash.trashPath!,
          trashFile: newETrash.trashFile!,
        ))
            .fold(
          Left.new,
          (url) {
            newETrash.fileUrl = url;
          },
        );
      }

      return Right(
        await repository.insertNewETrash(newETrash),
      );
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
