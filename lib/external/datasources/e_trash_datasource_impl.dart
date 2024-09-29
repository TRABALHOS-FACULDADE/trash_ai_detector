import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trash_ai/domain/models/e_trash.dart';
import 'package:trash_ai/domain/models/new_e_trash.dart';

import '../../infra/datasources/e_trash_datasource.dart';

class ETrashDatasourceImpl implements ETrashDatasource {
  static const _TRASHES_BUCKET = 'trashes';

  @override
  Future<ETrashFetch> getAllETrashes() async {
    final client = Supabase.instance.client;

    final response = await client.from('lixo_descartado').select();

    return ETrashFetch.fromMap(response);
  }

  @override
  Future<ETrash> insertNewETrash(NewETrash eTrash) async {
    final client = Supabase.instance.client;

    final response = await client
        .from('lixo_descartado')
        .insert(
          eTrash.toMap(),
        )
        .select();

    final insertedValue = response.single;

    return ETrash.fromMap(insertedValue);
  }

  @override
  Future<void> deleteETrash(String eTrashId) async {
    final client = Supabase.instance.client;

    await client.from('lixo_descartado').delete().eq(
          'id',
          eTrashId,
        );
  }

  @override
  Future<String?> uploadTrashFile({
    required String path,
    required File trashFile,
  }) async {
    final storage = Supabase.instance.client.storage;

    try {
      final filePath = await storage.from(_TRASHES_BUCKET).upload(
            path,
            trashFile,
          );

      final fileUrl = storage.from(_TRASHES_BUCKET).getPublicUrl(filePath);

      return fileUrl.replaceFirst('/$_TRASHES_BUCKET', '');
    } catch (e) {
      if (kDebugMode) {
        print('ERROR_MESSAGE ${e.toString()}');
      }
      return null;
    }
  }
}
