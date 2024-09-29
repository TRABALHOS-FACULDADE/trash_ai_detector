import 'package:flutter/material.dart';
import 'package:trash_ai/core/utils/date_to_dmy.dart';

import '../../domain/models/e_trash.dart';
import '../widgets/trash_monitoring_progress_widget.dart';

class ETrashMonitoringPage extends StatefulWidget {
  final ETrash eTrash;

  const ETrashMonitoringPage({
    super.key,
    required this.eTrash,
  });

  @override
  State<ETrashMonitoringPage> createState() => _ETrashMonitoringPageState();
}

class _ETrashMonitoringPageState extends State<ETrashMonitoringPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.eTrash.id),
      ),
      body: Column(
        children: [
          if (widget.eTrash.fileUrl != null) ...{
            const SizedBox(height: 20),
            Image.network(
              widget.eTrash.fileUrl!,
              height: 300,
              width: 300,
            ),
          },
          const SizedBox(height: 10),
          Text(
            widget.eTrash.trashType.name,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          TrashMonitoringProgressWidget(
            status: widget.eTrash.status,
          ),
          const SizedBox(height: 10),
          Text(
            widget.eTrash.status.name,
            style: TextStyle(
              color: widget.eTrash.status.textColor,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              shrinkWrap: true,
              itemCount: widget.eTrash.timestamps
                  .where(
                    (t) => t.time != null,
                  )
                  .length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, index) {
                final stamp = widget.eTrash.timestamps
                    .where(
                      (t) => t.time != null,
                    )
                    .toList()[index];

                return Row(
                  children: [
                    const Icon(
                      Icons.access_time_outlined,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '${stamp.text}${stamp.time!.toDMY_HHMM}',
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
