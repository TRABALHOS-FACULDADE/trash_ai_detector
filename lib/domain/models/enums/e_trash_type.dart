enum ETrashType {
  nintendoDS(
    apiKey: 'NINTENDO_DS',
    name: 'Nintendo DS/3DS',
  ),
  pcb(
    apiKey: 'PCB',
    name: 'Electronic Circuit',
  ),
  mouse(
    apiKey: 'MOUSE',
    name: 'Mouse',
  ),
  phone(
    apiKey: 'PHONE',
    name: 'Mobile phone',
  ),
  none(
    apiKey: 'NONE',
    name: 'Unidentified',
  );

  final String apiKey;
  final String name;

  const ETrashType({
    required this.apiKey,
    required this.name,
  });
}
