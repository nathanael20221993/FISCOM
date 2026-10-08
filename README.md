# NTJFARM

Application mobile (Android / iOS) de gestion d'exploitation agricole, développée
avec **Flutter** et **Firebase**. Interface en **français** et **anglais**.

## Fonctionnalités

| Module | Contenu |
| --- | --- |
| **Accueil** | Recettes / dépenses / solde du mois, cultures en cours, nombre d'animaux, alertes de stock bas, récoltes à venir |
| **Cultures** | Culture, variété, parcelle, surface (ha), date de semis, récolte prévue, statut (planifiée / en cours / récoltée) |
| **Élevage** | Lots d'animaux : espèce, nom du lot, effectif, race, date d'acquisition |
| **Stock** | Semences, engrais, aliments, produits vétérinaires, matériel, récoltes… avec seuil d'alerte |
| **Finances** | Recettes et dépenses par catégorie (ventes, semences, main-d'œuvre, transport…) et solde |
| **Paramètres** | Langue (FR/EN), devise (FCFA, XAF, EUR, USD, GNF, CDF), déconnexion |

Les comptes utilisent l'authentification e-mail / mot de passe de Firebase.
Les données sont stockées dans Cloud Firestore sous `users/{uid}/…` : chaque
utilisateur ne voit que ses propres données (voir `firestore.rules`).
Firestore garde aussi les données en cache sur le téléphone, donc l'application
reste utilisable hors connexion et se synchronise au retour du réseau.

## Démarrage

### 1. Prérequis

- [Flutter](https://docs.flutter.dev/get-started/install) 3.47 ou plus récent
- Un compte [Firebase](https://console.firebase.google.com) (gratuit)
- Les outils Firebase :
  ```bash
  npm install -g firebase-tools
  dart pub global activate flutterfire_cli
  firebase login
  ```

### 2. Configurer Firebase

1. Dans la console Firebase, créez un projet (ex. `ntjfarm`).
2. **Authentication → Sign-in method** : activez **E-mail/Mot de passe**.
3. **Firestore Database** : créez la base de données (mode production).
4. À la racine du projet :
   ```bash
   flutterfire configure --project=<id-de-votre-projet>
   ```
   Cela remplace `lib/firebase_options.dart` et ajoute
   `android/app/google-services.json` / `ios/Runner/GoogleService-Info.plist`.
5. Déployez les règles de sécurité :
   ```bash
   firebase deploy --only firestore:rules --project=<id-de-votre-projet>
   ```

Tant que Firebase n'est pas configuré, l'application affiche un message
l'indiquant au lieu de planter.

### 3. Lancer l'application

```bash
flutter pub get
flutter run            # sur un téléphone branché ou un émulateur
```

Construire un APK Android :

```bash
flutter build apk --release
```

## Développement

```bash
flutter analyze        # analyse statique
flutter test           # tests unitaires et d'interface
```

Les traductions sont dans `lib/l10n/app_fr.arb` (référence) et
`lib/l10n/app_en.arb` ; le code Dart correspondant est généré automatiquement
(`flutter gen-l10n`, lancé aussi par `flutter run`).

### Organisation du code

```
lib/
  main.dart                 initialisation Firebase + préférences
  app.dart                  thème, langues, connexion → accueil
  models/                   Crop, AnimalBatch, StockItem, FarmTransaction
  data/                     accès Firestore (CRUD générique par collection)
  logic/farm_summary.dart   calculs du tableau de bord
  services/auth_service.dart
  state/settings_controller.dart   langue et devise
  screens/                  un fichier par module (liste + formulaire)
  widgets/                  composants partagés (formulaires, dates, libellés)
test/                       tests des modèles, calculs, dépôt et écrans
```
