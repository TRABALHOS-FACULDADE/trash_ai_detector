import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trash_ai/domain/models/e_trash.dart';
import 'package:trash_ai/domain/models/new_e_trash.dart';

import '../../infra/datasources/e_trash_datasource.dart';

class ETrashDatasourceImpl implements ETrashDatasource {
  @override
  Future<ETrashFetch> getAllETrashes() async {
    final client = Supabase.instance.client;

    final response = await client.from('lixo_descartado').select();

    return ETrashFetch.fromMap(response);
  }

  @override
  Future<ETrash> insertNewETrash(NewETrash eTrash) async {
    final client = Supabase.instance.client;

    print(eTrash.toMap());

    final response = await client
        .from('lixo_descartado')
        .insert(
          eTrash.toMap(),
        )
        .select();

    final insertedValue = response.single;

    return ETrash.fromMap(insertedValue);
  }
}
