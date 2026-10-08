import 'farm_entity.dart';

enum TransactionType { income, expense }

enum TransactionCategory {
  sales,
  seeds,
  fertilizer,
  feed,
  labor,
  equipment,
  veterinary,
  transport,
  other,
}

class FarmTransaction implements FarmEntity {
  const FarmTransaction({
    this.id,
    required this.type,
    this.category = TransactionCategory.other,
    required this.amount,
    required this.date,
    this.description = '',
  });

  @override
  final String? id;
  final TransactionType type;
  final TransactionCategory category;

  /// Always positive; the sign comes from [type].
  final double amount;
  final DateTime date;
  final String description;

  double get signedAmount => type == TransactionType.income ? amount : -amount;

  factory FarmTransaction.fromMap(String id, Map<String, dynamic> data) =>
      FarmTransaction(
        id: id,
        type: enumFromName(
          TransactionType.values,
          data['type'],
          TransactionType.expense,
        ),
        category: enumFromName(
          TransactionCategory.values,
          data['category'],
          TransactionCategory.other,
        ),
        amount: doubleFromFirestore(data['amount']),
        date: dateFromFirestore(data['date']) ?? DateTime(2000),
        description: data['description'] as String? ?? '',
      );

  @override
  Map<String, dynamic> toMap() => {
    'type': type.name,
    'category': category.name,
    'amount': amount,
    'date': dateToFirestore(date),
    'description': description,
  };
}
