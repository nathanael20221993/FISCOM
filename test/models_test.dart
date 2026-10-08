import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ntjfarm/models/animal_batch.dart';
import 'package:ntjfarm/models/crop.dart';
import 'package:ntjfarm/models/farm_transaction.dart';
import 'package:ntjfarm/models/stock_item.dart';

void main() {
  test('Crop round-trips through a Firestore map', () {
    final crop = Crop(
      name: 'Maïs',
      variety: 'CMS 8704',
      plot: 'Parcelle Nord',
      areaHa: 1.5,
      plantingDate: DateTime(2026, 3, 15),
      expectedHarvestDate: DateTime(2026, 7, 1),
      status: CropStatus.planned,
    );
    final map = crop.toMap();
    expect(map['plantingDate'], isA<Timestamp>());
    final back = Crop.fromMap('c1', map);
    expect(back.id, 'c1');
    expect(back.name, 'Maïs');
    expect(back.areaHa, 1.5);
    expect(back.plantingDate, DateTime(2026, 3, 15));
    expect(back.expectedHarvestDate, DateTime(2026, 7, 1));
    expect(back.status, CropStatus.planned);
  });

  test('unknown enum values and missing fields fall back to defaults', () {
    final crop = Crop.fromMap('x', {'name': 'Riz', 'status': 'mystery'});
    expect(crop.status, CropStatus.growing);
    expect(crop.expectedHarvestDate, isNull);
    final tx = FarmTransaction.fromMap('t', {'amount': 10});
    expect(tx.type, TransactionType.expense);
    expect(tx.category, TransactionCategory.other);
    expect(tx.amount, 10.0);
  });

  test('AnimalBatch stores an integer headcount', () {
    final b = AnimalBatch(
      species: 'Poulets',
      headcount: 250,
      acquiredDate: DateTime(2026, 1, 2),
    );
    final back = AnimalBatch.fromMap('a', b.toMap());
    expect(back.headcount, 250);
    expect(back.species, 'Poulets');
  });

  test('StockItem.isLow respects the alert threshold', () {
    expect(
      const StockItem(name: 'Engrais', quantity: 2, minQuantity: 5).isLow,
      isTrue,
    );
    expect(
      const StockItem(name: 'Engrais', quantity: 5, minQuantity: 5).isLow,
      isTrue,
    );
    expect(
      const StockItem(name: 'Engrais', quantity: 6, minQuantity: 5).isLow,
      isFalse,
    );
    expect(const StockItem(name: 'Sans seuil', quantity: 0).isLow, isFalse);
  });

  test('FarmTransaction.signedAmount is negative for expenses', () {
    final d = DateTime(2026);
    expect(
      FarmTransaction(
        type: TransactionType.income,
        amount: 100,
        date: d,
      ).signedAmount,
      100,
    );
    expect(
      FarmTransaction(
        type: TransactionType.expense,
        amount: 40,
        date: d,
      ).signedAmount,
      -40,
    );
  });
}
