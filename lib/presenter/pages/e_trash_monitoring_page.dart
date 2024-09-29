import 'package:flutter/material.dart';
import 'package:trash_ai/core/utils/date_to_dmy.dart';

import '../../domain/models/e_trash.dart';
import '../widgets/trash_monitoring_progress_widget.dart';

class ETrashMonitoringPage extends StatelessWidget {
  final ETrash eTrash;

  const ETrashMonitoringPage({
    super.key,
    required this.eTrash,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(eTrash.id),
      ),
      body: Column(
        children: [
          if (eTrash.fileUrl != null) ...{
            const SizedBox(height: 20),
            Image.network(
              eTrash.fileUrl!,
              height: 300,
              width: 300,
            ),
          },
          const SizedBox(height: 10),
          Text(
            eTrash.trashType.name,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          TrashMonitoringProgressWidget(
            status: eTrash.status,
          ),
          const SizedBox(height: 10),
          Text(
            eTrash.status.name,
            style: TextStyle(
              color: eTrash.status.textColor,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              shrinkWrap: true,
              itemCount: eTrash.timestamps
                  .where(
                    (t) => t.time != null,
                  )
                  .length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, index) {
                final stamps = eTrash.timestamps
                    .where(
                      (t) => t.time != null,
                    )
                    .toList();
                final stamp = stamps[index];

                final isLast = index == stamps.length - 1;

                return Container(
                  padding: isLast
                      ? const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 8,
                        )
                      : null,
                  decoration: BoxDecoration(
                    color: isLast ? Colors.grey[300] : null,
                    borderRadius: isLast ? BorderRadius.circular(6) : null,
                    border: isLast
                        ? const Border(
                            left: BorderSide(
                              color: Colors.blue,
                              width: 5,
                            ),
                          )
                        : null,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isLast
                            ? Icons.access_time_outlined
                            : Icons.check_circle,
                        color: isLast ? Colors.blue : Colors.green,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${stamp.text}${stamp.time!.toDMY_HHMM}',
                        style: TextStyle(
                          color: isLast ? Colors.blue : null,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
