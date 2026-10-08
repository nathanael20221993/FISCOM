import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'data/farm_repository.dart';
import 'l10n/app_localizations.dart';
import 'screens/home_shell.dart';
import 'screens/login_screen.dart';
import 'services/auth_service.dart';
import 'state/settings_controller.dart';
import 'widgets/common.dart';

class NtjFarmApp extends StatelessWidget {
  const NtjFarmApp({
    super.key,
    required this.settings,
    this.firebaseReady = true,
  });

  final SettingsController settings;
  final bool firebaseReady;

  static const seedColor = Color(0xFF2E7D32);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: settings,
      child: Consumer<SettingsController>(
        builder: (context, settings, _) => MaterialApp(
          onGenerateTitle: (context) => context.l10n.appTitle,
          debugShowCheckedModeBanner: false,
          locale: settings.locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
            inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(),
            ),
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: seedColor,
              brightness: Brightness.dark,
            ),
            inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(),
            ),
          ),
          home: firebaseReady ? const _AuthGate() : const _NotConfigured(),
        ),
      ),
    );
  }
}

class _AuthGate extends StatelessWidget {
  const _AuthGate();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => AuthService(FirebaseAuth.instance),
      child: Builder(
        builder: (context) {
          return StreamBuilder<User?>(
            stream: context.read<AuthService>().authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
              final user = snapshot.data;
              if (user == null) return const LoginScreen();
              return Provider(
                key: ValueKey(user.uid),
                create: (_) =>
                    FarmRepository(FirebaseFirestore.instance, user.uid),
                child: const HomeShell(),
              );
            },
          );
        },
      ),
    );
  }
}

class _NotConfigured extends StatelessWidget {
  const _NotConfigured();

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Text(
          context.l10n.firebaseNotConfigured,
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}
