import 'enums/e_trash_type.dart';
import 'enums/trash_status.dart';

class ETrashFetch {
  List<ETrash> trashes = [];

  ETrashFetch(List<ETrash> content) {
    trashes = content;
  }

  factory ETrashFetch.fromMap(List<Map<String, dynamic>> list) => ETrashFetch(
        list.map(ETrash.fromMap).toList(),
      );
}

class ETrash {
  final String id;
  final DateTime createdAt;
  final ETrashType trashType;
  final TrashStatus status;

  ETrash({
    required this.id,
    required this.createdAt,
    required this.trashType,
    required this.status,
  });

  factory ETrash.fromMap(Map<String, dynamic> map) => ETrash(
      id: map['id'],
      createdAt: DateTime.parse(map['created_at']),
      trashType: ETrashType.values.singleWhere(
        (type) => type.apiKey == map['trash_type'],
      ),
      status: TrashStatus.values.singleWhere(
        (type) => type.apiKey == map['status'],
      ));
}
