import 'dart:convert';
import 'dart:io';

import 'package:uuid/uuid.dart';

import 'enums/e_trash_type.dart';
import 'enums/trash_status.dart';

class NewETrash {
  final ETrashType trashType;
  final TrashStatus status;

  String? trashPath;
  File? trashFile;

  bool get hasFileToUpload => trashPath != null && trashFile != null;

  String? fileUrl;

  NewETrash({
    required this.trashType,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    final id = const Uuid().v4();

    return {
      'id': id,
      'created_at': DateTime.now().toIso8601String(),
      'trash_type': trashType.apiKey,
      'status': status.apiKey,
      'fileUrl': fileUrl,
      'filePath': trashPath,
    };
  }

  String toJson() => jsonEncode(toMap());
}
