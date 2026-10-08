import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/collection_repository.dart';
import '../data/farm_repository.dart';
import '../models/animal_batch.dart';
import '../models/crop.dart';
import '../models/farm_entity.dart';
import '../models/farm_transaction.dart';
import '../models/stock_item.dart';
import '../widgets/common.dart';
import 'animals_screen.dart';
import 'crops_screen.dart';
import 'dashboard_screen.dart';
import 'finances_screen.dart';
import 'settings_screen.dart';
import 'stock_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  StreamProvider<List<T>> _stream<T extends FarmEntity>(
    CollectionRepository<T> repo,
  ) => StreamProvider<List<T>>(
    create: (_) => repo.watchAll(),
    initialData: const [],
    catchError: (_, error) {
      debugPrint('Firestore stream error ($T): $error');
      return const [];
    },
  );

  @override
  Widget build(BuildContext context) {
    final repo = context.read<FarmRepository>();
    final l10n = context.l10n;

    final tabs = <(String, IconData, Widget, WidgetBuilder?)>[
      (l10n.dashboard, Icons.dashboard_outlined, const DashboardScreen(), null),
      (
        l10n.crops,
        Icons.grass,
        const CropsScreen(),
        (_) => const CropFormScreen(),
      ),
      (
        l10n.animals,
        Icons.pets,
        const AnimalsScreen(),
        (_) => const AnimalFormScreen(),
      ),
      (
        l10n.stock,
        Icons.inventory_2_outlined,
        const StockScreen(),
        (_) => const StockFormScreen(),
      ),
      (
        l10n.finances,
        Icons.account_balance_wallet_outlined,
        const FinancesScreen(),
        (_) => const TransactionFormScreen(),
      ),
    ];
    final (title, _, body, addBuilder) = tabs[_index];

    return MultiProvider(
      providers: [
        _stream<Crop>(repo.crops),
        _stream<AnimalBatch>(repo.animals),
        _stream<StockItem>(repo.stock),
        _stream<FarmTransaction>(repo.transactions),
      ],
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text(_index == 0 ? l10n.appTitle : title),
            actions: [
              IconButton(
                tooltip: l10n.settings,
                icon: const Icon(Icons.settings_outlined),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                ),
              ),
            ],
          ),
          body: body,
          floatingActionButton: addBuilder == null
              ? null
              : FloatingActionButton(
                  tooltip: l10n.add,
                  child: const Icon(Icons.add),
                  onPressed: () => openForm(context, addBuilder),
                ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: _index,
            onDestinationSelected: (i) => setState(() => _index = i),
            destinations: [
              for (final (label, icon, _, _) in tabs)
                NavigationDestination(icon: Icon(icon), label: label),
            ],
          ),
        ),
      ),
    );
  }
}

/// Opens a form screen while keeping access to the repository provider.
void openForm(BuildContext context, WidgetBuilder builder) {
  final repo = context.read<FarmRepository>();
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => Provider.value(
        value: repo,
        child: Builder(builder: builder),
      ),
    ),
  );
}
