import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/farm_repository.dart';
import '../models/crop.dart';
import '../widgets/common.dart';
import '../widgets/labels.dart';
import 'home_shell.dart';

class CropsScreen extends StatelessWidget {
  const CropsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final crops = context.watch<List<Crop>>();
    if (crops.isEmpty) return const EmptyState(icon: Icons.grass);
    final l10n = context.l10n;
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 88),
      itemCount: crops.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, i) {
        final crop = crops[i];
        final details = [
          if (crop.variety.isNotEmpty) crop.variety,
          if (crop.plot.isNotEmpty) crop.plot,
          if (crop.areaHa > 0) '${context.formatNumber(crop.areaHa)} ha',
          '${l10n.plantingDate} : ${context.formatDate(crop.plantingDate)}',
        ];
        return ListTile(
          leading: const CircleAvatar(child: Icon(Icons.grass)),
          title: Text(crop.name),
          subtitle: Text(details.join(' · ')),
          trailing: Chip(label: Text(crop.status.label(l10n))),
          onTap: () => openForm(context, (_) => CropFormScreen(crop: crop)),
        );
      },
    );
  }
}

class CropFormScreen extends StatefulWidget {
  const CropFormScreen({super.key, this.crop});

  final Crop? crop;

  @override
  State<CropFormScreen> createState() => _CropFormScreenState();
}

class _CropFormScreenState extends State<CropFormScreen> {
  late final _name = TextEditingController(text: widget.crop?.name);
  late final _variety = TextEditingController(text: widget.crop?.variety);
  late final _plot = TextEditingController(text: widget.crop?.plot);
  late final _area = TextEditingController(
    text: (widget.crop?.areaHa ?? 0) > 0 ? '${widget.crop!.areaHa}' : '',
  );
  late final _notes = TextEditingController(text: widget.crop?.notes);
  late DateTime _plantingDate = widget.crop?.plantingDate ?? DateTime.now();
  late DateTime? _harvestDate = widget.crop?.expectedHarvestDate;
  late CropStatus _status = widget.crop?.status ?? CropStatus.growing;

  @override
  void dispose() {
    for (final c in [_name, _variety, _plot, _area, _notes]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final repo = context.read<FarmRepository>().crops;
    final existing = widget.crop;
    return EntityFormScaffold(
      title: existing == null ? l10n.newCrop : l10n.editCrop,
      onSave: () => repo.save(
        Crop(
          id: existing?.id,
          name: _name.text.trim(),
          variety: _variety.text.trim(),
          plot: _plot.text.trim(),
          areaHa: parseNumber(_area.text) ?? 0,
          plantingDate: _plantingDate,
          expectedHarvestDate: _harvestDate,
          status: _status,
          notes: _notes.text.trim(),
        ),
      ),
      onDelete: existing == null ? null : () => repo.delete(existing.id!),
      children: [
        TextFormField(
          controller: _name,
          decoration: InputDecoration(labelText: l10n.cropName),
          textCapitalization: TextCapitalization.sentences,
          validator: (v) => requiredValidator(context, v),
        ),
        TextFormField(
          controller: _variety,
          decoration: InputDecoration(labelText: l10n.variety),
        ),
        TextFormField(
          controller: _plot,
          decoration: InputDecoration(labelText: l10n.plot),
        ),
        TextFormField(
          controller: _area,
          decoration: InputDecoration(labelText: l10n.areaHa),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          validator: (v) => numberValidator(context, v, required: false),
        ),
        DropdownButtonFormField<CropStatus>(
          initialValue: _status,
          decoration: InputDecoration(labelText: l10n.status),
          items: [
            for (final s in CropStatus.values)
              DropdownMenuItem(value: s, child: Text(s.label(l10n))),
          ],
          onChanged: (v) => setState(() => _status = v ?? _status),
        ),
        DateField(
          label: l10n.plantingDate,
          value: _plantingDate,
          onChanged: (d) => setState(() => _plantingDate = d ?? _plantingDate),
        ),
        DateField(
          label: l10n.expectedHarvest,
          value: _harvestDate,
          clearable: true,
          onChanged: (d) => setState(() => _harvestDate = d),
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
