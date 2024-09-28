enum ETrashType {
  nintendoDS(
    apiKey: 'NINTENDO_DS',
    name: 'Nintendo DS/3DS',
  ),
  pcb(
    apiKey: 'PCB',
    name: 'Placa eletrônica',
  ),
  mouse(
    apiKey: 'MOUSE',
    name: 'Mouse',
  ),
  phone(
    apiKey: 'PHONE',
    name: 'Aparelho celular',
  ),
  none(
    apiKey: 'NONE',
    name: 'Não identificado',
  );

  final String apiKey;
  final String name;

  const ETrashType({
    required this.apiKey,
    required this.name,
  });
}
