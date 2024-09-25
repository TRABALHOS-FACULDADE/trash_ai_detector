enum TrashStatus {
  discarded(
    apiKey: 'DISCARDED',
    name: 'Descartado',
  ),
  beingCollected(
    apiKey: 'BEING_COLLECTED',
    name: 'Em processo de coleta',
  ),
  transporting(
    apiKey: 'TRANSPORTING',
    name: 'Em transporte',
  ),
  recycling(
    apiKey: 'RECYCLING',
    name: 'Em processo de reciclagem',
  ),
  done(
    apiKey: 'DONE',
    name: 'Reciclado e redistribuído para reutilização',
  );

  final String apiKey;
  final String name;

  const TrashStatus({
    required this.apiKey,
    required this.name,
  });
}
