import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ntjfarm/data/farm_repository.dart';
import 'package:ntjfarm/l10n/app_localizations.dart';
import 'package:ntjfarm/models/crop.dart';
import 'package:ntjfarm/screens/crops_screen.dart';
import 'package:ntjfarm/state/settings_controller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Widget> _wrap(
  Widget child,
  FarmRepository repo, {
  List<Crop> crops = const [],
  String locale = 'fr',
}) async {
  SharedPreferences.setMockInitialValues({'locale': locale});
  final settings = await SettingsController.load();
  return MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: settings),
      Provider.value(value: repo),
      Provider<List<Crop>>.value(value: crops),
    ],
    child: MaterialApp(
      locale: Locale(locale),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: Scaffold(body: child),
    ),
  );
}

void main() {
  late FakeFirebaseFirestore db;
  late FarmRepository repo;

  setUp(() {
    db = FakeFirebaseFirestore();
    repo = FarmRepository(db, 'u');
  });

  testWidgets('crops list shows items and French labels', (tester) async {
    await tester.pumpWidget(
      await _wrap(
        const CropsScreen(),
        repo,
        crops: [
          Crop(
            id: '1',
            name: 'Maïs',
            plot: 'Nord',
            plantingDate: DateTime(2026, 3, 1),
          ),
        ],
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Maïs'), findsOneWidget);
    expect(find.text('En cours'), findsOneWidget);
  });

  testWidgets('empty list shows the English hint', (tester) async {
    await tester.pumpWidget(
      await _wrap(const CropsScreen(), repo, locale: 'en'),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('Nothing here yet'), findsOneWidget);
  });

  testWidgets('crop form validates then saves to Firestore', (tester) async {
    await tester.pumpWidget(await _wrap(const CropFormScreen(), repo));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Enregistrer'));
    await tester.pumpAndSettle();
    expect(find.text('Champ obligatoire'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Culture (ex. maïs)'),
      'Sorgho',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Surface (ha)'),
      '2,5',
    );
    await tester.tap(find.text('Enregistrer'));
    await tester.pumpAndSettle();

    final docs = await db.collection('users/u/crops').get();
    expect(docs.docs, hasLength(1));
    expect(docs.docs.single['name'], 'Sorgho');
    expect(docs.docs.single['areaHa'], 2.5);
  });
}
