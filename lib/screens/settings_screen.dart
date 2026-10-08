import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';
import '../state/settings_controller.dart';
import '../widgets/common.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final settings = context.watch<SettingsController>();
    final auth = context.read<AuthService>();
    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(l10n.language),
            trailing: SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'fr', label: Text('FR')),
                ButtonSegment(value: 'en', label: Text('EN')),
              ],
              selected: {settings.locale.languageCode},
              onSelectionChanged: (s) => settings.setLocale(Locale(s.first)),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.payments_outlined),
            title: Text(l10n.currency),
            trailing: DropdownButton<String>(
              value: settings.currency,
              items: [
                for (final c in SettingsController.supportedCurrencies)
                  DropdownMenuItem(value: c, child: Text(c)),
              ],
              onChanged: (c) {
                if (c != null) settings.setCurrency(c);
              },
            ),
          ),
          const Divider(),
          if (auth.currentUser?.email case final email?)
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: Text(l10n.signedInAs(email)),
            ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(l10n.signOut),
            onTap: () async {
              Navigator.popUntil(context, (route) => route.isFirst);
              await auth.signOut();
            },
          ),
        ],
      ),
    );
  }
}
