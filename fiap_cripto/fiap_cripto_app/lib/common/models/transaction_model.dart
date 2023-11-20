class TransactionModel {
  final String coin;
  final double price;
  final double quantity;
  final double value;
  final bool status;
  final int date;
  String? id;
  TransactionModel({
    required this.coin,
    required this.price,
    required this.quantity,
    required this.date,
    required this.status,
    required this.value,
    this.id,
  });

    factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      price: double.tryParse(map['price'].toString()) ?? 0,
      quantity: double.tryParse(map['quantity'].toString()) ?? 0,
      coin: map['coin'] as String,
      value: double.tryParse(map['value'].toString()) ?? 0,
      date: DateTime.parse(map['date'] as String).millisecondsSinceEpoch,
      status: map['status'] as bool,
      id: map['id'] as String?,
    );
  }
}
