import 'package:collection/collection.dart';

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

  factory ETrashType.fromString(String key) =>
      ETrashType.values.singleWhereOrNull(
        (type) => type.apiKey == key.replaceAll(' ', '').trim(),
      ) ??
      none;

  const ETrashType({
    required this.apiKey,
    required this.name,
  });
}
