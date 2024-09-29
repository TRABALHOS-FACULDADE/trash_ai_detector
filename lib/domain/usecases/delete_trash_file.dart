import 'package:dartz/dartz.dart';

import '../repositories/e_trash_repository.dart';

abstract class DeleteTrashFile {
  Future<Either<Exception, void>> call(String path);
}

class DeleteTrashFileImpl implements DeleteTrashFile {
  final ETrashRepository repository;

  DeleteTrashFileImpl(this.repository);

  @override
  Future<Either<Exception, void>> call(String path) async {
    try {
      return Right(
        await repository.deleteTrashFile(path),
      );
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
