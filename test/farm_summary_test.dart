import 'package:flutter_test/flutter_test.dart';
import 'package:ntjfarm/logic/farm_summary.dart';
import 'package:ntjfarm/models/animal_batch.dart';
import 'package:ntjfarm/models/crop.dart';
import 'package:ntjfarm/models/farm_transaction.dart';
import 'package:ntjfarm/models/stock_item.dart';

void main() {
  test('computes monthly totals, counts and alerts', () {
    final now = DateTime(2026, 10, 8);
    final summary = FarmSummary.compute(
      now: now,
      crops: [
        Crop(
          name: 'Maïs',
          plantingDate: DateTime(2026, 6),
          expectedHarvestDate: DateTime(2026, 11, 20),
        ),
        Crop(
          name: 'Manioc',
          plantingDate: DateTime(2026, 4),
          expectedHarvestDate: DateTime(2026, 10, 30),
        ),
        Crop(
          name: 'Arachide',
          plantingDate: DateTime(2026, 3),
          expectedHarvestDate: DateTime(2026, 7),
          status: CropStatus.harvested,
        ),
        Crop(
          name: 'Tomate',
          plantingDate: DateTime(2026, 11),
          status: CropStatus.planned,
        ),
      ],
      animals: [
        AnimalBatch(species: 'Poulets', headcount: 200, acquiredDate: now),
        AnimalBatch(species: 'Chèvres', headcount: 12, acquiredDate: now),
      ],
      stock: const [
        StockItem(name: 'NPK', quantity: 1, minQuantity: 3),
        StockItem(name: 'Provende', quantity: 50, minQuantity: 10),
      ],
      transactions: [
        FarmTransaction(
          type: TransactionType.income,
          amount: 500000,
          date: DateTime(2026, 10, 2),
        ),
        FarmTransaction(
          type: TransactionType.expense,
          amount: 120000,
          date: DateTime(2026, 10, 5),
        ),
        // Previous month: counts in the overall balance only.
        FarmTransaction(
          type: TransactionType.expense,
          amount: 80000,
          date: DateTime(2026, 9, 28),
        ),
        // Same month, other year: must not count as "this month".
        FarmTransaction(
          type: TransactionType.income,
          amount: 1000,
          date: DateTime(2025, 10, 3),
        ),
      ],
    );

    expect(summary.monthIncome, 500000);
    expect(summary.monthExpense, 120000);
    expect(summary.monthBalance, 380000);
    expect(summary.totalBalance, 301000);
    expect(summary.cropsInProgress, 2);
    expect(summary.totalAnimals, 212);
    expect(summary.lowStock.map((s) => s.name), ['NPK']);
    expect(summary.upcomingHarvests.map((c) => c.name), ['Manioc', 'Maïs']);
  });

  test('empty farm gives zeroes', () {
    final s = FarmSummary.compute(
      crops: const [],
      animals: const [],
      stock: const [],
      transactions: const [],
      now: DateTime(2026),
    );
    expect(s.monthBalance, 0);
    expect(s.totalAnimals, 0);
    expect(s.lowStock, isEmpty);
  });
}
