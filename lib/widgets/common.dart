import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../state/settings_controller.dart';

extension L10nX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);

  String get _localeName => Localizations.localeOf(this).toLanguageTag();

  String formatDate(DateTime date) =>
      DateFormat.yMMMd(_localeName).format(date);

  String formatNumber(num value) =>
      NumberFormat.decimalPattern(_localeName).format(value);

  String formatMoney(num value) =>
      '${formatNumber(value)} ${watch<SettingsController>().currency}';
}

/// Parses user input that may use a comma as decimal separator.
double? parseNumber(String? text) => double.tryParse(
  (text ?? '').trim().replaceAll(' ', '').replaceAll(',', '.'),
);

String? requiredValidator(BuildContext context, String? value) =>
    (value == null || value.trim().isEmpty) ? context.l10n.fieldRequired : null;

String? numberValidator(
  BuildContext context,
  String? value, {
  bool required = true,
}) {
  if (value == null || value.trim().isEmpty) {
    return required ? context.l10n.fieldRequired : null;
  }
  final n = parseNumber(value);
  return (n == null || n < 0) ? context.l10n.invalidNumber : null;
}

Future<bool> confirmDelete(BuildContext context) async {
  final l10n = context.l10n;
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l10n.confirmDeleteTitle),
      content: Text(l10n.confirmDeleteMessage),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(l10n.delete),
        ),
      ],
    ),
  );
  return result ?? false;
}

class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 64, color: Theme.of(context).colorScheme.outline),
          const SizedBox(height: 16),
          Text(context.l10n.emptyList, textAlign: TextAlign.center),
        ],
      ),
    ),
  );
}

/// Tappable field that opens a date picker.
class DateField extends StatelessWidget {
  const DateField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.clearable = false,
  });

  final String label;
  final DateTime? value;
  final ValueChanged<DateTime?> onChanged;
  final bool clearable;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () async {
      final picked = await showDatePicker(
        context: context,
        initialDate: value ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );
      if (picked != null) onChanged(picked);
    },
    child: InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.event),
        suffixIcon: clearable && value != null
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () => onChanged(null),
              )
            : null,
      ),
      child: Text(value == null ? '—' : context.formatDate(value!)),
    ),
  );
}

/// Common layout for all add/edit screens: a validated form, a save button and
/// an optional delete action.
class EntityFormScaffold extends StatefulWidget {
  const EntityFormScaffold({
    super.key,
    required this.title,
    required this.children,
    required this.onSave,
    this.onDelete,
  });

  final String title;
  final List<Widget> children;
  final Future<void> Function() onSave;
  final Future<void> Function()? onDelete;

  @override
  State<EntityFormScaffold> createState() => _EntityFormScaffoldState();
}

class _EntityFormScaffoldState extends State<EntityFormScaffold> {
  final _formKey = GlobalKey<FormState>();
  bool _busy = false;

  Future<void> _run(Future<void> Function() action) async {
    setState(() => _busy = true);
    try {
      await action();
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      setState(() => _busy = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.saveError(e.toString()))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final onDelete = widget.onDelete;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          if (onDelete != null)
            IconButton(
              tooltip: context.l10n.delete,
              icon: const Icon(Icons.delete_outline),
              onPressed: _busy
                  ? null
                  : () async {
                      if (await confirmDelete(context)) await _run(onDelete);
                    },
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            for (final child in widget.children)
              Padding(padding: const EdgeInsets.only(bottom: 16), child: child),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton.icon(
            icon: _busy
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.check),
            label: Text(context.l10n.save),
            onPressed: _busy
                ? null
                : () {
                    if (_formKey.currentState!.validate()) _run(widget.onSave);
                  },
          ),
        ),
      ),
    );
  }
}
