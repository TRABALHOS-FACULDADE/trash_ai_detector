import 'package:flutter/material.dart';

enum TrashStatus {
  discarded(
    apiKey: 'DISCARDED',
    name: 'Descartado',
    textColor: Colors.white,
  ),
  beingCollected(
    apiKey: 'BEING_COLLECTED',
    name: 'Em processo de coleta',
    textColor: Colors.red,
  ),
  transporting(
    apiKey: 'TRANSPORTING',
    name: 'Em transporte',
    textColor: Colors.orange,
  ),
  recycling(
    apiKey: 'RECYCLING',
    name: 'Reciclando',
    textColor: Colors.greenAccent,
  ),
  done(
    apiKey: 'DONE',
    name: 'Reciclado',
    textColor: Colors.green,
  );

  final String apiKey;
  final String name;
  final Color textColor;

  const TrashStatus({
    required this.apiKey,
    required this.name,
    required this.textColor,
  });
}
