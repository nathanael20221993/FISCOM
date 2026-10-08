import '../models/animal_batch.dart';
import '../models/crop.dart';
import '../models/farm_transaction.dart';
import '../models/stock_item.dart';

/// Figures shown on the dashboard, computed from the raw lists.
class FarmSummary {
  const FarmSummary({
    required this.monthIncome,
    required this.monthExpense,
    required this.totalBalance,
    required this.cropsInProgress,
    required this.totalAnimals,
    required this.lowStock,
    required this.upcomingHarvests,
  });

  final double monthIncome;
  final double monthExpense;
  final double totalBalance;
  final int cropsInProgress;
  final int totalAnimals;
  final List<StockItem> lowStock;

  /// Non-harvested crops with an expected harvest date, soonest first.
  final List<Crop> upcomingHarvests;

  double get monthBalance => monthIncome - monthExpense;

  factory FarmSummary.compute({
    required List<Crop> crops,
    required List<AnimalBatch> animals,
    required List<StockItem> stock,
    required List<FarmTransaction> transactions,
    required DateTime now,
  }) {
    var income = 0.0, expense = 0.0, balance = 0.0;
    for (final t in transactions) {
      balance += t.signedAmount;
      if (t.date.year == now.year && t.date.month == now.month) {
        if (t.type == TransactionType.income) {
          income += t.amount;
        } else {
          expense += t.amount;
        }
      }
    }
    final upcoming =
        crops
            .where(
              (c) =>
                  c.status != CropStatus.harvested &&
                  c.expectedHarvestDate != null,
            )
            .toList()
          ..sort(
            (a, b) => a.expectedHarvestDate!.compareTo(b.expectedHarvestDate!),
          );
    return FarmSummary(
      monthIncome: income,
      monthExpense: expense,
      totalBalance: balance,
      cropsInProgress: crops
          .where((c) => c.status == CropStatus.growing)
          .length,
      totalAnimals: animals.fold(0, (sum, a) => sum + a.headcount),
      lowStock: stock.where((s) => s.isLow).toList(),
      upcomingHarvests: upcoming,
    );
  }
}
