import 'package:dartz/dartz.dart';

import '../repositories/e_trash_repository.dart';

abstract class DeleteETrash {
  Future<Either<Exception, void>> call(String eTrashId);
}

class DeleteETrashImpl implements DeleteETrash {
  final ETrashRepository repository;

  DeleteETrashImpl(this.repository);

  @override
  Future<Either<Exception, void>> call(String eTrashId) async {
    try {
      return Right(
        await repository.deleteETrash(eTrashId),
      );
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
