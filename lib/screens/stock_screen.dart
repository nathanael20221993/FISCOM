import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/farm_repository.dart';
import '../models/stock_item.dart';
import '../widgets/common.dart';
import '../widgets/labels.dart';
import 'home_shell.dart';

class StockScreen extends StatelessWidget {
  const StockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = context.watch<List<StockItem>>();
    if (items.isEmpty) {
      return const EmptyState(icon: Icons.inventory_2_outlined);
    }
    final l10n = context.l10n;
    final error = Theme.of(context).colorScheme.error;
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 88),
      itemCount: items.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, i) {
        final item = items[i];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: item.isLow ? error : null,
            foregroundColor: item.isLow ? Colors.white : null,
            child: Icon(
              item.isLow ? Icons.warning_amber : Icons.inventory_2_outlined,
            ),
          ),
          title: Text(item.name),
          subtitle: Text(
            item.isLow
                ? '${item.category.label(l10n)} · ${l10n.lowStock}'
                : item.category.label(l10n),
          ),
          trailing: Text(
            '${context.formatNumber(item.quantity)} ${item.unit}',
            style: Theme.of(context).textTheme.titleSmall
                ?.copyWith(color: item.isLow ? error : null),
          ),
          onTap: () => openForm(context, (_) => StockFormScreen(item: item)),
        );
      },
    );
  }
}

class StockFormScreen extends StatefulWidget {
  const StockFormScreen({super.key, this.item});

  final StockItem? item;

  @override
  State<StockFormScreen> createState() => _StockFormScreenState();
}

class _StockFormScreenState extends State<StockFormScreen> {
  late final _name = TextEditingController(text: widget.item?.name);
  late final _quantity = TextEditingController(
    text: '${widget.item?.quantity ?? ''}',
  );
  late final _unit = TextEditingController(text: widget.item?.unit);
  late final _min = TextEditingController(
    text: (widget.item?.minQuantity ?? 0) > 0
        ? '${widget.item!.minQuantity}'
        : '',
  );
  late final _notes = TextEditingController(text: widget.item?.notes);
  late StockCategory _category = widget.item?.category ?? StockCategory.other;

  @override
  void dispose() {
    for (final c in [_name, _quantity, _unit, _min, _notes]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final repo = context.read<FarmRepository>().stock;
    final existing = widget.item;
    return EntityFormScaffold(
      title: existing == null ? l10n.newStockItem : l10n.editStockItem,
      onSave: () => repo.save(
        StockItem(
          id: existing?.id,
          name: _name.text.trim(),
          category: _category,
          quantity: parseNumber(_quantity.text) ?? 0,
          unit: _unit.text.trim(),
          minQuantity: parseNumber(_min.text) ?? 0,
          notes: _notes.text.trim(),
        ),
      ),
      onDelete: existing == null ? null : () => repo.delete(existing.id!),
      children: [
        TextFormField(
          controller: _name,
          decoration: InputDecoration(labelText: l10n.itemName),
          textCapitalization: TextCapitalization.sentences,
          validator: (v) => requiredValidator(context, v),
        ),
        DropdownButtonFormField<StockCategory>(
          initialValue: _category,
          decoration: InputDecoration(labelText: l10n.category),
          items: [
            for (final c in StockCategory.values)
              DropdownMenuItem(value: c, child: Text(c.label(l10n))),
          ],
          onChanged: (v) => setState(() => _category = v ?? _category),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: TextFormField(
                controller: _quantity,
                decoration: InputDecoration(labelText: l10n.quantity),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (v) => numberValidator(context, v),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: TextFormField(
                controller: _unit,
                decoration: InputDecoration(labelText: l10n.unit),
              ),
            ),
          ],
        ),
        TextFormField(
          controller: _min,
          decoration: InputDecoration(labelText: l10n.minQuantity),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          validator: (v) => numberValidator(context, v, required: false),
        ),
        TextFormField(
          controller: _notes,
          decoration: InputDecoration(labelText: l10n.notes),
          maxLines: 3,
        ),
      ],
    );
  }
}
