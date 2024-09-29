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
  final String? fileUrl;
  final String? filePath;
  final DateTime createdAt;
  final ETrashType trashType;
  final TrashStatus status;
  final DateTime? collectedAt;
  final DateTime? transportedAt;
  final DateTime? beingRecycledAt;
  final DateTime? recycledAt;

  ETrash({
    required this.id,
    this.fileUrl,
    this.filePath,
    required this.createdAt,
    required this.trashType,
    required this.status,
    this.collectedAt,
    this.transportedAt,
    this.beingRecycledAt,
    this.recycledAt,
  });

  List<({String text, DateTime? time})> get timestamps => [
        (
          text: 'Descartado em ',
          time: createdAt,
        ),
        (
          text: 'Coletado em ',
          time: collectedAt,
        ),
        (
          text: 'Transportado em ',
          time: transportedAt,
        ),
        (
          text: 'Início da reciclagem em ',
          time: beingRecycledAt,
        ),
        (
          text: 'Reciclado em ',
          time: recycledAt,
        ),
      ];

  factory ETrash.fromMap(Map<String, dynamic> map) => ETrash(
        id: map['id'],
        fileUrl: map['fileUrl'],
        filePath: map['filePath'],
        createdAt: DateTime.parse(map['created_at']),
        trashType: ETrashType.fromString(map['trash_type']),
        status: TrashStatus.fromString(map['status']),
        collectedAt: map['collected_at'] == null
            ? null
            : DateTime.parse(map['collected_at']),
        transportedAt: map['transported_at'] == null
            ? null
            : DateTime.parse(map['transported_at']),
        beingRecycledAt: map['being_recycled_at'] == null
            ? null
            : DateTime.parse(map['being_recycled_at']),
        recycledAt: map['recycled_at'] == null
            ? null
            : DateTime.parse(map['recycled_at']),
      );
}
