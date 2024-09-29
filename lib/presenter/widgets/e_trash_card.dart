import 'package:flutter/material.dart';
import 'package:trash_ai/core/utils/date_to_dmy.dart';

import '../../domain/models/e_trash.dart';

class ETrashCard extends StatelessWidget {
  final ETrash eTrash;
  final VoidCallback onDeleteTap;

  const ETrashCard({
    super.key,
    required this.eTrash,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.blue[100]!.withOpacity(.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          if (eTrash.fileUrl != null)
            Image.network(
              eTrash.fileUrl!,
              height: 60,
              width: 60,
            ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey.withOpacity(.4),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  eTrash.id,
                  style: const TextStyle(
                    fontSize: 10,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Tipo: ${eTrash.trashType.name}',
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                'Status: ${eTrash.status.name}',
                style: TextStyle(
                  color: eTrash.status.textColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  const Icon(Icons.calendar_month_outlined),
                  const SizedBox(width: 3),
                  Text(eTrash.createdAt.toDMY_HHMM),
                ],
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: onDeleteTap,
            icon: Icon(
              Icons.delete_outline,
              color: Colors.red[900],
            ),
          ),
        ],
      ),
    );
  }
}
