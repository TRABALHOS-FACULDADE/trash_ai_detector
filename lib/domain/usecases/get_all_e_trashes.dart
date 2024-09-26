import 'package:dartz/dartz.dart';

import '../models/e_trash.dart';
import '../repositories/e_trash_repository.dart';

abstract class GetAllETrashes {
  Future<Either<Exception, ETrashFetch>> call();
}

class GetAllETrashesImpl implements GetAllETrashes {
  final ETrashRepository repository;

  GetAllETrashesImpl(this.repository);

  @override
  Future<Either<Exception, ETrashFetch>> call() async {
    try {
      return Right(
        await repository.getAllETrashes(),
      );
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
