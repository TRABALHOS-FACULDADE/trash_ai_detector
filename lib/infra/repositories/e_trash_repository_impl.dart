import 'package:trash_ai/domain/models/e_trash.dart';

import '../../domain/repositories/e_trash_repository.dart';
import '../datasources/e_trash_datasource.dart';

class ETrashRepositoryImpl implements ETrashRepository {
  final ETrashDatasource datasource;

  ETrashRepositoryImpl(this.datasource);

  @override
  Future<ETrashFetch> getAllETrashes() async => datasource.getAllETrashes();
}
