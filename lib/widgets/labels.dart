import '../l10n/app_localizations.dart';
import '../models/crop.dart';
import '../models/farm_transaction.dart';
import '../models/stock_item.dart';

extension CropStatusLabel on CropStatus {
  String label(AppLocalizations l10n) => switch (this) {
    CropStatus.planned => l10n.statusPlanned,
    CropStatus.growing => l10n.statusGrowing,
    CropStatus.harvested => l10n.statusHarvested,
  };
}

extension StockCategoryLabel on StockCategory {
  String label(AppLocalizations l10n) => switch (this) {
    StockCategory.seeds => l10n.catSeeds,
    StockCategory.fertilizer => l10n.catFertilizer,
    StockCategory.feed => l10n.catFeed,
    StockCategory.medicine => l10n.catMedicine,
    StockCategory.equipment => l10n.catEquipment,
    StockCategory.harvest => l10n.catHarvest,
    StockCategory.other => l10n.catOther,
  };
}

extension TransactionCategoryLabel on TransactionCategory {
  String label(AppLocalizations l10n) => switch (this) {
    TransactionCategory.sales => l10n.txSales,
    TransactionCategory.seeds => l10n.txSeeds,
    TransactionCategory.fertilizer => l10n.txFertilizer,
    TransactionCategory.feed => l10n.txFeed,
    TransactionCategory.labor => l10n.txLabor,
    TransactionCategory.equipment => l10n.txEquipment,
    TransactionCategory.veterinary => l10n.txVeterinary,
    TransactionCategory.transport => l10n.txTransport,
    TransactionCategory.other => l10n.txOther,
  };
}
