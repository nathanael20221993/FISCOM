import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In fr, this message translates to:
  /// **'NTJFARM'**
  String get appTitle;

  /// No description provided for @appTagline.
  ///
  /// In fr, this message translates to:
  /// **'Gestion de votre exploitation agricole'**
  String get appTagline;

  /// No description provided for @email.
  ///
  /// In fr, this message translates to:
  /// **'E-mail'**
  String get email;

  /// No description provided for @password.
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe'**
  String get password;

  /// No description provided for @signIn.
  ///
  /// In fr, this message translates to:
  /// **'Se connecter'**
  String get signIn;

  /// No description provided for @signUp.
  ///
  /// In fr, this message translates to:
  /// **'Créer un compte'**
  String get signUp;

  /// No description provided for @noAccount.
  ///
  /// In fr, this message translates to:
  /// **'Pas encore de compte ? Inscrivez-vous'**
  String get noAccount;

  /// No description provided for @haveAccount.
  ///
  /// In fr, this message translates to:
  /// **'Déjà un compte ? Connectez-vous'**
  String get haveAccount;

  /// No description provided for @forgotPassword.
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe oublié ?'**
  String get forgotPassword;

  /// No description provided for @resetEmailSent.
  ///
  /// In fr, this message translates to:
  /// **'Un e-mail de réinitialisation a été envoyé.'**
  String get resetEmailSent;

  /// No description provided for @authError.
  ///
  /// In fr, this message translates to:
  /// **'Échec de l\'authentification : {message}'**
  String authError(String message);

  /// No description provided for @fieldRequired.
  ///
  /// In fr, this message translates to:
  /// **'Champ obligatoire'**
  String get fieldRequired;

  /// No description provided for @invalidNumber.
  ///
  /// In fr, this message translates to:
  /// **'Nombre invalide'**
  String get invalidNumber;

  /// No description provided for @passwordTooShort.
  ///
  /// In fr, this message translates to:
  /// **'6 caractères minimum'**
  String get passwordTooShort;

  /// No description provided for @dashboard.
  ///
  /// In fr, this message translates to:
  /// **'Accueil'**
  String get dashboard;

  /// No description provided for @crops.
  ///
  /// In fr, this message translates to:
  /// **'Cultures'**
  String get crops;

  /// No description provided for @animals.
  ///
  /// In fr, this message translates to:
  /// **'Élevage'**
  String get animals;

  /// No description provided for @stock.
  ///
  /// In fr, this message translates to:
  /// **'Stock'**
  String get stock;

  /// No description provided for @finances.
  ///
  /// In fr, this message translates to:
  /// **'Finances'**
  String get finances;

  /// No description provided for @settings.
  ///
  /// In fr, this message translates to:
  /// **'Paramètres'**
  String get settings;

  /// No description provided for @save.
  ///
  /// In fr, this message translates to:
  /// **'Enregistrer'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In fr, this message translates to:
  /// **'Annuler'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer'**
  String get delete;

  /// No description provided for @add.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter'**
  String get add;

  /// No description provided for @confirmDeleteTitle.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer ?'**
  String get confirmDeleteTitle;

  /// No description provided for @confirmDeleteMessage.
  ///
  /// In fr, this message translates to:
  /// **'Cette action est irréversible.'**
  String get confirmDeleteMessage;

  /// No description provided for @emptyList.
  ///
  /// In fr, this message translates to:
  /// **'Aucun élément pour le moment.\nAppuyez sur + pour en ajouter.'**
  String get emptyList;

  /// No description provided for @notes.
  ///
  /// In fr, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @saveError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de l\'enregistrement : {message}'**
  String saveError(String message);

  /// No description provided for @newCrop.
  ///
  /// In fr, this message translates to:
  /// **'Nouvelle culture'**
  String get newCrop;

  /// No description provided for @editCrop.
  ///
  /// In fr, this message translates to:
  /// **'Modifier la culture'**
  String get editCrop;

  /// No description provided for @cropName.
  ///
  /// In fr, this message translates to:
  /// **'Culture (ex. maïs)'**
  String get cropName;

  /// No description provided for @variety.
  ///
  /// In fr, this message translates to:
  /// **'Variété'**
  String get variety;

  /// No description provided for @plot.
  ///
  /// In fr, this message translates to:
  /// **'Parcelle'**
  String get plot;

  /// No description provided for @areaHa.
  ///
  /// In fr, this message translates to:
  /// **'Surface (ha)'**
  String get areaHa;

  /// No description provided for @plantingDate.
  ///
  /// In fr, this message translates to:
  /// **'Date de semis'**
  String get plantingDate;

  /// No description provided for @expectedHarvest.
  ///
  /// In fr, this message translates to:
  /// **'Récolte prévue'**
  String get expectedHarvest;

  /// No description provided for @status.
  ///
  /// In fr, this message translates to:
  /// **'Statut'**
  String get status;

  /// No description provided for @statusPlanned.
  ///
  /// In fr, this message translates to:
  /// **'Planifiée'**
  String get statusPlanned;

  /// No description provided for @statusGrowing.
  ///
  /// In fr, this message translates to:
  /// **'En cours'**
  String get statusGrowing;

  /// No description provided for @statusHarvested.
  ///
  /// In fr, this message translates to:
  /// **'Récoltée'**
  String get statusHarvested;

  /// No description provided for @newAnimal.
  ///
  /// In fr, this message translates to:
  /// **'Nouveau lot d\'animaux'**
  String get newAnimal;

  /// No description provided for @editAnimal.
  ///
  /// In fr, this message translates to:
  /// **'Modifier le lot'**
  String get editAnimal;

  /// No description provided for @species.
  ///
  /// In fr, this message translates to:
  /// **'Espèce (ex. poulets)'**
  String get species;

  /// No description provided for @batchName.
  ///
  /// In fr, this message translates to:
  /// **'Nom du lot / identifiant'**
  String get batchName;

  /// No description provided for @headcount.
  ///
  /// In fr, this message translates to:
  /// **'Effectif'**
  String get headcount;

  /// No description provided for @breed.
  ///
  /// In fr, this message translates to:
  /// **'Race'**
  String get breed;

  /// No description provided for @acquiredDate.
  ///
  /// In fr, this message translates to:
  /// **'Date d\'acquisition'**
  String get acquiredDate;

  /// No description provided for @headcountLabel.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =0{aucune tête} =1{1 tête} other{{count} têtes}}'**
  String headcountLabel(int count);

  /// No description provided for @newStockItem.
  ///
  /// In fr, this message translates to:
  /// **'Nouvel article'**
  String get newStockItem;

  /// No description provided for @editStockItem.
  ///
  /// In fr, this message translates to:
  /// **'Modifier l\'article'**
  String get editStockItem;

  /// No description provided for @itemName.
  ///
  /// In fr, this message translates to:
  /// **'Article'**
  String get itemName;

  /// No description provided for @category.
  ///
  /// In fr, this message translates to:
  /// **'Catégorie'**
  String get category;

  /// No description provided for @quantity.
  ///
  /// In fr, this message translates to:
  /// **'Quantité'**
  String get quantity;

  /// No description provided for @unit.
  ///
  /// In fr, this message translates to:
  /// **'Unité (kg, sacs, L…)'**
  String get unit;

  /// No description provided for @minQuantity.
  ///
  /// In fr, this message translates to:
  /// **'Seuil d\'alerte'**
  String get minQuantity;

  /// No description provided for @lowStock.
  ///
  /// In fr, this message translates to:
  /// **'Stock bas'**
  String get lowStock;

  /// No description provided for @catSeeds.
  ///
  /// In fr, this message translates to:
  /// **'Semences'**
  String get catSeeds;

  /// No description provided for @catFertilizer.
  ///
  /// In fr, this message translates to:
  /// **'Engrais / traitements'**
  String get catFertilizer;

  /// No description provided for @catFeed.
  ///
  /// In fr, this message translates to:
  /// **'Aliments du bétail'**
  String get catFeed;

  /// No description provided for @catMedicine.
  ///
  /// In fr, this message translates to:
  /// **'Produits vétérinaires'**
  String get catMedicine;

  /// No description provided for @catEquipment.
  ///
  /// In fr, this message translates to:
  /// **'Matériel'**
  String get catEquipment;

  /// No description provided for @catHarvest.
  ///
  /// In fr, this message translates to:
  /// **'Récoltes'**
  String get catHarvest;

  /// No description provided for @catOther.
  ///
  /// In fr, this message translates to:
  /// **'Autre'**
  String get catOther;

  /// No description provided for @newTransaction.
  ///
  /// In fr, this message translates to:
  /// **'Nouvelle opération'**
  String get newTransaction;

  /// No description provided for @editTransaction.
  ///
  /// In fr, this message translates to:
  /// **'Modifier l\'opération'**
  String get editTransaction;

  /// No description provided for @income.
  ///
  /// In fr, this message translates to:
  /// **'Recette'**
  String get income;

  /// No description provided for @expense.
  ///
  /// In fr, this message translates to:
  /// **'Dépense'**
  String get expense;

  /// No description provided for @amount.
  ///
  /// In fr, this message translates to:
  /// **'Montant'**
  String get amount;

  /// No description provided for @date.
  ///
  /// In fr, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @description.
  ///
  /// In fr, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @balance.
  ///
  /// In fr, this message translates to:
  /// **'Solde'**
  String get balance;

  /// No description provided for @thisMonth.
  ///
  /// In fr, this message translates to:
  /// **'Ce mois-ci'**
  String get thisMonth;

  /// No description provided for @totalIncome.
  ///
  /// In fr, this message translates to:
  /// **'Recettes'**
  String get totalIncome;

  /// No description provided for @totalExpense.
  ///
  /// In fr, this message translates to:
  /// **'Dépenses'**
  String get totalExpense;

  /// No description provided for @txSales.
  ///
  /// In fr, this message translates to:
  /// **'Ventes'**
  String get txSales;

  /// No description provided for @txSeeds.
  ///
  /// In fr, this message translates to:
  /// **'Semences'**
  String get txSeeds;

  /// No description provided for @txFertilizer.
  ///
  /// In fr, this message translates to:
  /// **'Engrais / traitements'**
  String get txFertilizer;

  /// No description provided for @txFeed.
  ///
  /// In fr, this message translates to:
  /// **'Aliments du bétail'**
  String get txFeed;

  /// No description provided for @txLabor.
  ///
  /// In fr, this message translates to:
  /// **'Main-d\'œuvre'**
  String get txLabor;

  /// No description provided for @txEquipment.
  ///
  /// In fr, this message translates to:
  /// **'Matériel'**
  String get txEquipment;

  /// No description provided for @txVeterinary.
  ///
  /// In fr, this message translates to:
  /// **'Vétérinaire'**
  String get txVeterinary;

  /// No description provided for @txTransport.
  ///
  /// In fr, this message translates to:
  /// **'Transport'**
  String get txTransport;

  /// No description provided for @txOther.
  ///
  /// In fr, this message translates to:
  /// **'Autre'**
  String get txOther;

  /// No description provided for @cropsInProgress.
  ///
  /// In fr, this message translates to:
  /// **'Cultures en cours'**
  String get cropsInProgress;

  /// No description provided for @totalAnimals.
  ///
  /// In fr, this message translates to:
  /// **'Animaux'**
  String get totalAnimals;

  /// No description provided for @stockAlerts.
  ///
  /// In fr, this message translates to:
  /// **'Alertes de stock'**
  String get stockAlerts;

  /// No description provided for @noAlerts.
  ///
  /// In fr, this message translates to:
  /// **'Aucune alerte, tout est en ordre.'**
  String get noAlerts;

  /// No description provided for @upcomingHarvests.
  ///
  /// In fr, this message translates to:
  /// **'Récoltes à venir'**
  String get upcomingHarvests;

  /// No description provided for @noUpcomingHarvests.
  ///
  /// In fr, this message translates to:
  /// **'Aucune récolte prévue.'**
  String get noUpcomingHarvests;

  /// No description provided for @language.
  ///
  /// In fr, this message translates to:
  /// **'Langue'**
  String get language;

  /// No description provided for @currency.
  ///
  /// In fr, this message translates to:
  /// **'Devise'**
  String get currency;

  /// No description provided for @signOut.
  ///
  /// In fr, this message translates to:
  /// **'Se déconnecter'**
  String get signOut;

  /// No description provided for @signedInAs.
  ///
  /// In fr, this message translates to:
  /// **'Connecté : {email}'**
  String signedInAs(String email);

  /// No description provided for @firebaseNotConfigured.
  ///
  /// In fr, this message translates to:
  /// **'Firebase n\'est pas encore configuré.\nLancez « flutterfire configure » (voir README).'**
  String get firebaseNotConfigured;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
