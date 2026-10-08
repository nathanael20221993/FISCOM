// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'NTJFARM';

  @override
  String get appTagline => 'Manage your farm';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get signIn => 'Sign in';

  @override
  String get signUp => 'Create account';

  @override
  String get noAccount => 'No account yet? Sign up';

  @override
  String get haveAccount => 'Already have an account? Sign in';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get resetEmailSent => 'A password reset email has been sent.';

  @override
  String authError(String message) {
    return 'Authentication failed: $message';
  }

  @override
  String get fieldRequired => 'Required field';

  @override
  String get invalidNumber => 'Invalid number';

  @override
  String get passwordTooShort => 'At least 6 characters';

  @override
  String get dashboard => 'Home';

  @override
  String get crops => 'Crops';

  @override
  String get animals => 'Livestock';

  @override
  String get stock => 'Stock';

  @override
  String get finances => 'Finances';

  @override
  String get settings => 'Settings';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get add => 'Add';

  @override
  String get confirmDeleteTitle => 'Delete?';

  @override
  String get confirmDeleteMessage => 'This cannot be undone.';

  @override
  String get emptyList => 'Nothing here yet.\nTap + to add one.';

  @override
  String get notes => 'Notes';

  @override
  String saveError(String message) {
    return 'Could not save: $message';
  }

  @override
  String get newCrop => 'New crop';

  @override
  String get editCrop => 'Edit crop';

  @override
  String get cropName => 'Crop (e.g. maize)';

  @override
  String get variety => 'Variety';

  @override
  String get plot => 'Plot';

  @override
  String get areaHa => 'Area (ha)';

  @override
  String get plantingDate => 'Planting date';

  @override
  String get expectedHarvest => 'Expected harvest';

  @override
  String get status => 'Status';

  @override
  String get statusPlanned => 'Planned';

  @override
  String get statusGrowing => 'Growing';

  @override
  String get statusHarvested => 'Harvested';

  @override
  String get newAnimal => 'New livestock batch';

  @override
  String get editAnimal => 'Edit batch';

  @override
  String get species => 'Species (e.g. chickens)';

  @override
  String get batchName => 'Batch name / tag';

  @override
  String get headcount => 'Headcount';

  @override
  String get breed => 'Breed';

  @override
  String get acquiredDate => 'Acquired on';

  @override
  String headcountLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count head',
      one: '1 head',
      zero: 'no head',
    );
    return '$_temp0';
  }

  @override
  String get newStockItem => 'New item';

  @override
  String get editStockItem => 'Edit item';

  @override
  String get itemName => 'Item';

  @override
  String get category => 'Category';

  @override
  String get quantity => 'Quantity';

  @override
  String get unit => 'Unit (kg, bags, L…)';

  @override
  String get minQuantity => 'Alert threshold';

  @override
  String get lowStock => 'Low stock';

  @override
  String get catSeeds => 'Seeds';

  @override
  String get catFertilizer => 'Fertilizer / treatments';

  @override
  String get catFeed => 'Animal feed';

  @override
  String get catMedicine => 'Veterinary products';

  @override
  String get catEquipment => 'Equipment';

  @override
  String get catHarvest => 'Harvest';

  @override
  String get catOther => 'Other';

  @override
  String get newTransaction => 'New transaction';

  @override
  String get editTransaction => 'Edit transaction';

  @override
  String get income => 'Income';

  @override
  String get expense => 'Expense';

  @override
  String get amount => 'Amount';

  @override
  String get date => 'Date';

  @override
  String get description => 'Description';

  @override
  String get balance => 'Balance';

  @override
  String get thisMonth => 'This month';

  @override
  String get totalIncome => 'Income';

  @override
  String get totalExpense => 'Expenses';

  @override
  String get txSales => 'Sales';

  @override
  String get txSeeds => 'Seeds';

  @override
  String get txFertilizer => 'Fertilizer / treatments';

  @override
  String get txFeed => 'Animal feed';

  @override
  String get txLabor => 'Labour';

  @override
  String get txEquipment => 'Equipment';

  @override
  String get txVeterinary => 'Veterinary';

  @override
  String get txTransport => 'Transport';

  @override
  String get txOther => 'Other';

  @override
  String get cropsInProgress => 'Growing crops';

  @override
  String get totalAnimals => 'Animals';

  @override
  String get stockAlerts => 'Stock alerts';

  @override
  String get noAlerts => 'No alerts, everything is in order.';

  @override
  String get upcomingHarvests => 'Upcoming harvests';

  @override
  String get noUpcomingHarvests => 'No harvest planned.';

  @override
  String get language => 'Language';

  @override
  String get currency => 'Currency';

  @override
  String get signOut => 'Sign out';

  @override
  String signedInAs(String email) {
    return 'Signed in as $email';
  }

  @override
  String get firebaseNotConfigured =>
      'Firebase is not configured yet.\nRun \"flutterfire configure\" (see README).';
}
