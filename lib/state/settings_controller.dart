import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Device-level preferences: interface language and currency label.
class SettingsController extends ChangeNotifier {
  SettingsController._(this._prefs)
    : _locale = Locale(_prefs.getString(_localeKey) ?? 'fr'),
      _currency = _prefs.getString(_currencyKey) ?? 'FCFA';

  static const _localeKey = 'locale';
  static const _currencyKey = 'currency';
  static const supportedCurrencies = [
    'FCFA',
    'XAF',
    'EUR',
    'USD',
    'GNF',
    'CDF',
  ];

  final SharedPreferences _prefs;
  Locale _locale;
  String _currency;

  Locale get locale => _locale;
  String get currency => _currency;

  static Future<SettingsController> load() async =>
      SettingsController._(await SharedPreferences.getInstance());

  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    notifyListeners();
    await _prefs.setString(_localeKey, locale.languageCode);
  }

  Future<void> setCurrency(String currency) async {
    _currency = currency;
    notifyListeners();
    await _prefs.setString(_currencyKey, currency);
  }
}
