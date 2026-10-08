import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/farm_repository.dart';
import '../models/animal_batch.dart';
import '../widgets/common.dart';
import 'home_shell.dart';

class AnimalsScreen extends StatelessWidget {
  const AnimalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final batches = context.watch<List<AnimalBatch>>();
    if (batches.isEmpty) return const EmptyState(icon: Icons.pets);
    final l10n = context.l10n;
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 88),
      itemCount: batches.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, i) {
        final b = batches[i];
        final details = [
          if (b.breed.isNotEmpty) b.breed,
          '${l10n.acquiredDate} : ${context.formatDate(b.acquiredDate)}',
        ];
        return ListTile(
          leading: const CircleAvatar(child: Icon(Icons.pets)),
          title: Text(b.name.isEmpty ? b.species : '${b.species} — ${b.name}'),
          subtitle: Text(details.join(' · ')),
          trailing: Text(
            l10n.headcountLabel(b.headcount),
            style: Theme.of(context).textTheme.titleSmall,
          ),
          onTap: () => openForm(context, (_) => AnimalFormScreen(batch: b)),
        );
      },
    );
  }
}

class AnimalFormScreen extends StatefulWidget {
  const AnimalFormScreen({super.key, this.batch});

  final AnimalBatch? batch;

  @override
  State<AnimalFormScreen> createState() => _AnimalFormScreenState();
}

class _AnimalFormScreenState extends State<AnimalFormScreen> {
  late final _species = TextEditingController(text: widget.batch?.species);
  late final _name = TextEditingController(text: widget.batch?.name);
  late final _headcount = TextEditingController(
    text: '${widget.batch?.headcount ?? ''}',
  );
  late final _breed = TextEditingController(text: widget.batch?.breed);
  late final _notes = TextEditingController(text: widget.batch?.notes);
  late DateTime _acquired = widget.batch?.acquiredDate ?? DateTime.now();

  @override
  void dispose() {
    for (final c in [_species, _name, _headcount, _breed, _notes]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final repo = context.read<FarmRepository>().animals;
    final existing = widget.batch;
    return EntityFormScaffold(
      title: existing == null ? l10n.newAnimal : l10n.editAnimal,
      onSave: () => repo.save(
        AnimalBatch(
          id: existing?.id,
          species: _species.text.trim(),
          name: _name.text.trim(),
          headcount: parseNumber(_headcount.text)?.round() ?? 0,
          breed: _breed.text.trim(),
          acquiredDate: _acquired,
          notes: _notes.text.trim(),
        ),
      ),
      onDelete: existing == null ? null : () => repo.delete(existing.id!),
      children: [
        TextFormField(
          controller: _species,
          decoration: InputDecoration(labelText: l10n.species),
          textCapitalization: TextCapitalization.sentences,
          validator: (v) => requiredValidator(context, v),
        ),
        TextFormField(
          controller: _name,
          decoration: InputDecoration(labelText: l10n.batchName),
        ),
        TextFormField(
          controller: _headcount,
          decoration: InputDecoration(labelText: l10n.headcount),
          keyboardType: TextInputType.number,
          validator: (v) => numberValidator(context, v),
        ),
        TextFormField(
          controller: _breed,
          decoration: InputDecoration(labelText: l10n.breed),
        ),
        DateField(
          label: l10n.acquiredDate,
          value: _acquired,
          onChanged: (d) => setState(() => _acquired = d ?? _acquired),
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
