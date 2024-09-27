import 'package:flutter/material.dart';

import '../../domain/models/e_trash.dart';

class ETrashCard extends StatelessWidget {
  final ETrash eTrash;

  const ETrashCard({
    super.key,
    required this.eTrash,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.electric_bolt,
          ),
          const SizedBox(width: 8),
          Column(
            children: [
              Text(eTrash.id),
              const SizedBox(height: 2),
              Text(eTrash.trashType.name),
              const SizedBox(height: 2),
              Text(eTrash.status.name),
              const SizedBox(height: 2),
              Text(eTrash.createdAt.toIso8601String()),
            ],
          ),
        ],
      ),
    );
  }
}
