import 'package:dartz/dartz.dart';

import '../repositories/e_trash_repository.dart';
import 'delete_trash_file.dart';

abstract class DeleteETrash {
  Future<Either<Exception, void>> call({
    required String eTrashId,
    required String path,
  });
}

class DeleteETrashImpl implements DeleteETrash {
  final ETrashRepository repository;
  final DeleteTrashFile deleteTrashFile;

  DeleteETrashImpl(
    this.repository,
    this.deleteTrashFile,
  );

  @override
  Future<Either<Exception, void>> call({
    required String eTrashId,
    required String path,
  }) async {
    try {
      final completed = await Future.wait(
        [
          repository.deleteETrash(eTrashId),
          deleteTrashFile(path),
        ],
      ).then(
        (l) => l[0],
      );

      return Right(completed);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
