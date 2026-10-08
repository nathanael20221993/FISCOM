import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/farm_repository.dart';
import '../models/farm_transaction.dart';
import '../widgets/common.dart';
import '../widgets/labels.dart';
import 'home_shell.dart';

class FinancesScreen extends StatelessWidget {
  const FinancesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final txs = context.watch<List<FarmTransaction>>();
    if (txs.isEmpty) {
      return const EmptyState(icon: Icons.account_balance_wallet_outlined);
    }
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final balance = txs.fold(0.0, (sum, t) => sum + t.signedAmount);
    return Column(
      children: [
        ListTile(
          tileColor: theme.colorScheme.secondaryContainer,
          title: Text(l10n.balance, style: theme.textTheme.titleMedium),
          trailing: Text(
            context.formatMoney(balance),
            style: theme.textTheme.titleMedium?.copyWith(
              color: balance < 0 ? Colors.red : Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.only(bottom: 88),
            itemCount: txs.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, i) {
              final t = txs[i];
              final isIncome = t.type == TransactionType.income;
              final color = isIncome ? Colors.green : Colors.red;
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: color.withValues(alpha: 0.15),
                  foregroundColor: color,
                  child: Icon(isIncome ? Icons.south_west : Icons.north_east),
                ),
                title: Text(
                  t.description.isEmpty
                      ? t.category.label(l10n)
                      : t.description,
                ),
                subtitle: Text(
                  '${t.category.label(l10n)} · ${context.formatDate(t.date)}',
                ),
                trailing: Text(
                  '${isIncome ? '+' : '−'}${context.formatMoney(t.amount)}',
                  style: TextStyle(color: color, fontWeight: FontWeight.w600),
                ),
                onTap: () => openForm(
                  context,
                  (_) => TransactionFormScreen(transaction: t),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class TransactionFormScreen extends StatefulWidget {
  const TransactionFormScreen({super.key, this.transaction});

  final FarmTransaction? transaction;

  @override
  State<TransactionFormScreen> createState() => _TransactionFormScreenState();
}

class _TransactionFormScreenState extends State<TransactionFormScreen> {
  late final _amount = TextEditingController(
    text: '${widget.transaction?.amount ?? ''}',
  );
  late final _description = TextEditingController(
    text: widget.transaction?.description,
  );
  late TransactionType _type =
      widget.transaction?.type ?? TransactionType.expense;
  late TransactionCategory _category =
      widget.transaction?.category ?? TransactionCategory.other;
  late DateTime _date = widget.transaction?.date ?? DateTime.now();

  @override
  void dispose() {
    _amount.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final repo = context.read<FarmRepository>().transactions;
    final existing = widget.transaction;
    return EntityFormScaffold(
      title: existing == null ? l10n.newTransaction : l10n.editTransaction,
      onSave: () => repo.save(
        FarmTransaction(
          id: existing?.id,
          type: _type,
          category: _category,
          amount: parseNumber(_amount.text) ?? 0,
          date: _date,
          description: _description.text.trim(),
        ),
      ),
      onDelete: existing == null ? null : () => repo.delete(existing.id!),
      children: [
        SegmentedButton<TransactionType>(
          segments: [
            ButtonSegment(
              value: TransactionType.expense,
              icon: const Icon(Icons.north_east),
              label: Text(l10n.expense),
            ),
            ButtonSegment(
              value: TransactionType.income,
              icon: const Icon(Icons.south_west),
              label: Text(l10n.income),
            ),
          ],
          selected: {_type},
          onSelectionChanged: (s) => setState(() {
            _type = s.first;
            if (_type == TransactionType.income &&
                _category == TransactionCategory.other) {
              _category = TransactionCategory.sales;
            }
          }),
        ),
        TextFormField(
          controller: _amount,
          decoration: InputDecoration(labelText: l10n.amount),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          validator: (v) => numberValidator(context, v),
        ),
        DropdownButtonFormField<TransactionCategory>(
          key: ValueKey(_category),
          initialValue: _category,
          decoration: InputDecoration(labelText: l10n.category),
          items: [
            for (final c in TransactionCategory.values)
              DropdownMenuItem(value: c, child: Text(c.label(l10n))),
          ],
          onChanged: (v) => setState(() => _category = v ?? _category),
        ),
        DateField(
          label: l10n.date,
          value: _date,
          onChanged: (d) => setState(() => _date = d ?? _date),
        ),
        TextFormField(
          controller: _description,
          decoration: InputDecoration(labelText: l10n.description),
          textCapitalization: TextCapitalization.sentences,
        ),
      ],
    );
  }
}
