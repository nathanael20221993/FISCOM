import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../logic/farm_summary.dart';
import '../models/animal_batch.dart';
import '../models/crop.dart';
import '../models/farm_transaction.dart';
import '../models/stock_item.dart';
import '../widgets/common.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final summary = FarmSummary.compute(
      crops: context.watch<List<Crop>>(),
      animals: context.watch<List<AnimalBatch>>(),
      stock: context.watch<List<StockItem>>(),
      transactions: context.watch<List<FarmTransaction>>(),
      now: DateTime.now(),
    );

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          color: theme.colorScheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.thisMonth, style: theme.textTheme.titleMedium),
                const SizedBox(height: 12),
                _MoneyRow(l10n.totalIncome, summary.monthIncome, Colors.green),
                _MoneyRow(l10n.totalExpense, -summary.monthExpense, Colors.red),
                const Divider(),
                _MoneyRow(l10n.balance, summary.monthBalance, null, bold: true),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                icon: Icons.grass,
                label: l10n.cropsInProgress,
                value: '${summary.cropsInProgress}',
              ),
            ),
            Expanded(
              child: _StatCard(
                icon: Icons.pets,
                label: l10n.totalAnimals,
                value: context.formatNumber(summary.totalAnimals),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _Section(
          title: l10n.stockAlerts,
          icon: Icons.warning_amber,
          emptyText: l10n.noAlerts,
          children: [
            for (final item in summary.lowStock)
              ListTile(
                dense: true,
                leading: Icon(
                  Icons.inventory_2_outlined,
                  color: theme.colorScheme.error,
                ),
                title: Text(item.name),
                trailing: Text(
                  '${context.formatNumber(item.quantity)} ${item.unit}',
                ),
              ),
          ],
        ),
        _Section(
          title: l10n.upcomingHarvests,
          icon: Icons.agriculture,
          emptyText: l10n.noUpcomingHarvests,
          children: [
            for (final crop in summary.upcomingHarvests.take(5))
              ListTile(
                dense: true,
                title: Text(crop.name),
                subtitle: crop.plot.isEmpty ? null : Text(crop.plot),
                trailing: Text(context.formatDate(crop.expectedHarvestDate!)),
              ),
          ],
        ),
      ],
    );
  }
}

class _MoneyRow extends StatelessWidget {
  const _MoneyRow(this.label, this.value, this.color, {this.bold = false});

  final String label;
  final double value;
  final Color? color;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      color: color,
      fontWeight: bold ? FontWeight.bold : null,
      fontSize: 16,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(child: Text(label, style: style)),
          Text(context.formatMoney(value), style: style),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: theme.colorScheme.primary),
            const SizedBox(height: 8),
            Text(value, style: theme.textTheme.headlineSmall),
            Text(label, style: theme.textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.icon,
    required this.emptyText,
    required this.children,
  });

  final String title;
  final IconData icon;
  final String emptyText;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Icon(icon),
            title: Text(title, style: Theme.of(context).textTheme.titleMedium),
          ),
          if (children.isEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Text(emptyText),
            )
          else
            ...children,
        ],
      ),
    ),
  );
}
