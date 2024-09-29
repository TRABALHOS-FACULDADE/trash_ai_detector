import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../domain/models/enums/trash_status.dart';

class TrashMonitoringProgressWidget extends StatelessWidget {
  final TrashStatus status;

  const TrashMonitoringProgressWidget({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: TrashStatus.values.mapIndexed((index, trashStatus) {
        final progress = TrashStatus.progress[status] ?? 0;

        return Container(
          height: 10,
          width: 50,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: progress > index ? trashStatus.textColor : Colors.grey[300],
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              color: Colors.black,
            ),
          ),
        );
      }).toList(),
    );
  }
}
