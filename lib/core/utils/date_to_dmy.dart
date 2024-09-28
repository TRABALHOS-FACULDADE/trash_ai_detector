extension DateToDmy on DateTime {
  String get toDMY =>
      '${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year';
}
