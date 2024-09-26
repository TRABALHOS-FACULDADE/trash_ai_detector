import 'package:dartz/dartz.dart';

import '../models/e_trash.dart';
import '../models/new_e_trash.dart';
import '../repositories/e_trash_repository.dart';

abstract class InsertNewETrash {
  Future<Either<Exception, ETrash>> call(NewETrash newETrash);
}

class InsertNewETrashImpl implements InsertNewETrash {
  final ETrashRepository repository;

  InsertNewETrashImpl(this.repository);

  @override
  Future<Either<Exception, ETrash>> call(
    NewETrash newETrash,
  ) async {
    try {
      return Right(
        await repository.insertNewETrash(newETrash),
      );
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
