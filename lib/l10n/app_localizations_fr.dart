// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'NTJFARM';

  @override
  String get appTagline => 'Gestion de votre exploitation agricole';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Mot de passe';

  @override
  String get signIn => 'Se connecter';

  @override
  String get signUp => 'Créer un compte';

  @override
  String get noAccount => 'Pas encore de compte ? Inscrivez-vous';

  @override
  String get haveAccount => 'Déjà un compte ? Connectez-vous';

  @override
  String get forgotPassword => 'Mot de passe oublié ?';

  @override
  String get resetEmailSent => 'Un e-mail de réinitialisation a été envoyé.';

  @override
  String authError(String message) {
    return 'Échec de l\'authentification : $message';
  }

  @override
  String get fieldRequired => 'Champ obligatoire';

  @override
  String get invalidNumber => 'Nombre invalide';

  @override
  String get passwordTooShort => '6 caractères minimum';

  @override
  String get dashboard => 'Accueil';

  @override
  String get crops => 'Cultures';

  @override
  String get animals => 'Élevage';

  @override
  String get stock => 'Stock';

  @override
  String get finances => 'Finances';

  @override
  String get settings => 'Paramètres';

  @override
  String get save => 'Enregistrer';

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get add => 'Ajouter';

  @override
  String get confirmDeleteTitle => 'Supprimer ?';

  @override
  String get confirmDeleteMessage => 'Cette action est irréversible.';

  @override
  String get emptyList =>
      'Aucun élément pour le moment.\nAppuyez sur + pour en ajouter.';

  @override
  String get notes => 'Notes';

  @override
  String saveError(String message) {
    return 'Erreur lors de l\'enregistrement : $message';
  }

  @override
  String get newCrop => 'Nouvelle culture';

  @override
  String get editCrop => 'Modifier la culture';

  @override
  String get cropName => 'Culture (ex. maïs)';

  @override
  String get variety => 'Variété';

  @override
  String get plot => 'Parcelle';

  @override
  String get areaHa => 'Surface (ha)';

  @override
  String get plantingDate => 'Date de semis';

  @override
  String get expectedHarvest => 'Récolte prévue';

  @override
  String get status => 'Statut';

  @override
  String get statusPlanned => 'Planifiée';

  @override
  String get statusGrowing => 'En cours';

  @override
  String get statusHarvested => 'Récoltée';

  @override
  String get newAnimal => 'Nouveau lot d\'animaux';

  @override
  String get editAnimal => 'Modifier le lot';

  @override
  String get species => 'Espèce (ex. poulets)';

  @override
  String get batchName => 'Nom du lot / identifiant';

  @override
  String get headcount => 'Effectif';

  @override
  String get breed => 'Race';

  @override
  String get acquiredDate => 'Date d\'acquisition';

  @override
  String headcountLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count têtes',
      one: '1 tête',
      zero: 'aucune tête',
    );
    return '$_temp0';
  }

  @override
  String get newStockItem => 'Nouvel article';

  @override
  String get editStockItem => 'Modifier l\'article';

  @override
  String get itemName => 'Article';

  @override
  String get category => 'Catégorie';

  @override
  String get quantity => 'Quantité';

  @override
  String get unit => 'Unité (kg, sacs, L…)';

  @override
  String get minQuantity => 'Seuil d\'alerte';

  @override
  String get lowStock => 'Stock bas';

  @override
  String get catSeeds => 'Semences';

  @override
  String get catFertilizer => 'Engrais / traitements';

  @override
  String get catFeed => 'Aliments du bétail';

  @override
  String get catMedicine => 'Produits vétérinaires';

  @override
  String get catEquipment => 'Matériel';

  @override
  String get catHarvest => 'Récoltes';

  @override
  String get catOther => 'Autre';

  @override
  String get newTransaction => 'Nouvelle opération';

  @override
  String get editTransaction => 'Modifier l\'opération';

  @override
  String get income => 'Recette';

  @override
  String get expense => 'Dépense';

  @override
  String get amount => 'Montant';

  @override
  String get date => 'Date';

  @override
  String get description => 'Description';

  @override
  String get balance => 'Solde';

  @override
  String get thisMonth => 'Ce mois-ci';

  @override
  String get totalIncome => 'Recettes';

  @override
  String get totalExpense => 'Dépenses';

  @override
  String get txSales => 'Ventes';

  @override
  String get txSeeds => 'Semences';

  @override
  String get txFertilizer => 'Engrais / traitements';

  @override
  String get txFeed => 'Aliments du bétail';

  @override
  String get txLabor => 'Main-d\'œuvre';

  @override
  String get txEquipment => 'Matériel';

  @override
  String get txVeterinary => 'Vétérinaire';

  @override
  String get txTransport => 'Transport';

  @override
  String get txOther => 'Autre';

  @override
  String get cropsInProgress => 'Cultures en cours';

  @override
  String get totalAnimals => 'Animaux';

  @override
  String get stockAlerts => 'Alertes de stock';

  @override
  String get noAlerts => 'Aucune alerte, tout est en ordre.';

  @override
  String get upcomingHarvests => 'Récoltes à venir';

  @override
  String get noUpcomingHarvests => 'Aucune récolte prévue.';

  @override
  String get language => 'Langue';

  @override
  String get currency => 'Devise';

  @override
  String get signOut => 'Se déconnecter';

  @override
  String signedInAs(String email) {
    return 'Connecté : $email';
  }

  @override
  String get firebaseNotConfigured =>
      'Firebase n\'est pas encore configuré.\nLancez « flutterfire configure » (voir README).';
}
