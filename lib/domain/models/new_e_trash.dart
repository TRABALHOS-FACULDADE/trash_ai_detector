import 'dart:convert';

import 'package:uuid/uuid.dart';

import 'enums/e_trash_type.dart';
import 'enums/trash_status.dart';

class NewETrash {
  final ETrashType trashType;
  final TrashStatus status;

  NewETrash({
    required this.trashType,
    required this.status,
  });

  Map<String, dynamic> toMap() => {
        'id': const Uuid().v4(),
        'created_at': DateTime.now().toIso8601String(),
        'trash_type': trashType.apiKey,
        'status': status.apiKey,
      };

  String toJson() => jsonEncode(toMap());
}
