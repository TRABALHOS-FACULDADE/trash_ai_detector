import 'dart:convert';

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
        'type': trashType.apiKey,
        'status': status.apiKey,
      };

  String toJson() => jsonEncode(toMap());
}
