import 'farm_entity.dart';

enum StockCategory {
  seeds,
  fertilizer,
  feed,
  medicine,
  equipment,
  harvest,
  other,
}

class StockItem implements FarmEntity {
  const StockItem({
    this.id,
    required this.name,
    this.category = StockCategory.other,
    this.quantity = 0,
    this.unit = '',
    this.minQuantity = 0,
    this.notes = '',
  });

  @override
  final String? id;
  final String name;
  final StockCategory category;
  final double quantity;
  final String unit;

  /// Below or at this level the item is flagged as low stock (0 = no alert).
  final double minQuantity;
  final String notes;

  bool get isLow => minQuantity > 0 && quantity <= minQuantity;

  factory StockItem.fromMap(String id, Map<String, dynamic> data) => StockItem(
    id: id,
    name: data['name'] as String? ?? '',
    category: enumFromName(
      StockCategory.values,
      data['category'],
      StockCategory.other,
    ),
    quantity: doubleFromFirestore(data['quantity']),
    unit: data['unit'] as String? ?? '',
    minQuantity: doubleFromFirestore(data['minQuantity']),
    notes: data['notes'] as String? ?? '',
  );

  @override
  Map<String, dynamic> toMap() => {
    'name': name,
    'category': category.name,
    'quantity': quantity,
    'unit': unit,
    'minQuantity': minQuantity,
    'notes': notes,
  };
}
