import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trash_ai/domain/models/e_trash.dart';
import 'package:trash_ai/domain/models/new_e_trash.dart';

import '../../infra/datasources/e_trash_datasource.dart';

class ETrashDatasourceImpl implements ETrashDatasource {
  final Supabase supabase;

  ETrashDatasourceImpl(this.supabase);

  @override
  Future<ETrashFetch> getAllETrashes() async {
    final client = supabase.client;

    final response = await client.from('lixo_descartado').select();

    return ETrashFetch.fromMap(response);
  }

  @override
  Future<ETrash> insertNewETrash(NewETrash eTrash) async {
    final client = supabase.client;

    final response = await client.from('lixo_descartado').insert(
          eTrash.toMap(),
        );

    return ETrash.fromMap(response as Map<String, dynamic>);
  }
}
